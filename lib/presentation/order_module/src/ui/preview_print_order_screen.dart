// import 'dart:typed_data';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:epoint_deal_plugin/common/lang_key.dart';
// import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
// import 'package:epoint_deal_plugin/common/localization/global.dart';
// import 'package:epoint_deal_plugin/common/theme.dart';
// import 'package:epoint_deal_plugin/model/response/preview_print_model.dart';
// import 'package:epoint_deal_plugin/model/response/print_devices_response_model.dart';
// import 'package:epoint_deal_plugin/utils/ultility.dart';
// import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
// import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
// import 'package:flutter/material.dart';
// import 'package:screenshot/screenshot.dart' as sc;
// import 'package:image/image.dart' as im;

// import '../bloc/preview_print_order_bloc.dart';

// class PreviewPrintOrderScreen extends StatefulWidget {
//   final PrintDevicesModel? model;
//   final int type;
//   final int? id;
//   final String? code;
//   PreviewPrintOrderScreen({Key? key, this.id, this.code, this.model, this.type = 0})
//       : super(key: key);
//   @override
//   State<PreviewPrintOrderScreen> createState() =>
//       _PreviewPrintOrderScreenState();
// }

// class _PreviewPrintOrderScreenState extends State<PreviewPrintOrderScreen> {

//   sc.ScreenshotController _screenshotController = sc.ScreenshotController();
//   List<sc.ScreenshotController> _listScreenshotController = [];
//   late NetworkPrinter printer;
//   PreviewPrintResponseModel? previewInfo;
//   bool isConnectedPrinter = false;

//   late PreviewPrintOrderBloc _bloc;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _bloc = PreviewPrintOrderBloc(context);
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await getPrintOrder();
//       const PaperSize paper = PaperSize.mm80;
//       final profile = await CapabilityProfile.load();
//       printer = NetworkPrinter(paper, profile);
//       CustomNavigator.showProgressDialog(context);
//       await connectPrinter();
//       setState(() {});
//       if (widget.type != 0) {
//         _listScreenshotController.clear();
//         previewInfo!.orderDetail!.forEach((element) {
//           sc.ScreenshotController controller = sc.ScreenshotController();
//           _listScreenshotController.add(controller);
//         });
//       }
//     });
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _bloc.dispose();
//   }

//   getPrintOrder() async {
//     // TODO: implement getOrderDetail
//     previewInfo = await _bloc.getPrintOrder(widget.id, Global.branch_code);
//     setState(() {});
//   }

//   connectPrinter() async {
//     final PosPrintResult res = await printer.connect(widget.model!.printerIp!,
//         port: widget.model!.printerPort!);
//     if (res == PosPrintResult.success) {
//       isConnectedPrinter = true;
//       CustomNavigator.hideProgressDialog();
//     }
//     else {
//       printer.disconnect();
//       CustomNavigator.hideProgressDialog();
//       await CustomNavigator.showCustomAlertDialog(
//           context,
//           AppLocalizations.text(LangKey.notification),
//           AppLocalizations.text(LangKey.connect_printer_error));
//     }
//   }
//   printing(sc.ScreenshotController controller) async {
//     if(isConnectedPrinter) {
//       CustomNavigator.showProgressDialog(context);
//       Uint8List? value = await controller.capture();
//       if (value != null) {
//         im.Image img = im.grayscale(im.decodePng(value)!);
//         im.Image thumbnail = im.copyResize(
//           img,
//           width: 550,
//           height: img.height * 550 ~/ img.width,
//         );
//         await printReceipt(printer, thumbnail);
//         await CustomNavigator.showCustomAlertDialog(
//             context,
//             AppLocalizations.text(LangKey.notification),
//             '${AppLocalizations.text(LangKey.success_print)}!');
//       }
//       else {
//         await CustomNavigator.showCustomAlertDialog(
//             context,
//             AppLocalizations.text(LangKey.notification),
//             '${AppLocalizations.text(LangKey.fail_print)}!');
//       }
//       CustomNavigator.hideProgressDialog();
//     }
//   }

//   Future<void> printReceipt(NetworkPrinter printer, im.Image imgSrc) async {
//     printer.image(imgSrc);
//     printer.cut();
//     await Future.delayed(Duration(seconds: 1));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       title: widget.code,
//       body: previewInfo == null ? Container(color: Colors.white,) :
//       Column(
//         children: <Widget>[
//           Expanded(
//             child: widget.type == 0
//                 ? SingleChildScrollView(
//               child: sc.Screenshot(
//                   controller: _screenshotController,
//                   child: bill()
//               ),
//             )
//                 : ListView.builder(
//                 padding: const EdgeInsets.all(8.0),
//                 itemCount: _listScreenshotController.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(bottom: 10.0),
//                     child: sc.Screenshot(
//                       controller: _listScreenshotController[index],
//                       child: Row(
//                         children: [
//                           Expanded(child: tag(index,_listScreenshotController.length)),
//                           QrImageView(
//                             data: previewInfo!.order!.orderId.toString(),
//                             version: QrVersions.auto,
//                             size: MediaQuery.of(context).size.width * 0.3,
//                             gapless: false,
//                           ),
//                         ],
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                       ),
//                     ),
//                   );
//                 }),
//           ),
//           if (widget.type == 0 && isConnectedPrinter)
//             CustomBottom(
//               text: AppLocalizations.text(LangKey.print),
//               onTap: () {
//                 printing(_screenshotController);
//               },
//             ),
//           if (widget.type == 1 && isConnectedPrinter)
//             CustomBottom(
//               text: AppLocalizations.text(LangKey.print),
//               onTap: () {
//                 if(_listScreenshotController.isNotEmpty) {
//                   _listScreenshotController.forEach((element) async {
//                     await printing(element);
//                   });
//                 }
//               },
//             )
//         ],
//       ),
//     );
//   }

//   Widget bill() {
//     return SingleChildScrollView(
//       physics: NeverScrollableScrollPhysics(),
//       child: Container(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             if(previewInfo!.configPrintBill!.isShowLogo == 1)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: SizedBox(width: 100,height: 100,child:
//                 Container(
//                     decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey.shade400)),
//                     child: CachedNetworkImage(imageUrl: previewInfo!.spaInfo!.logo!)),),
//               ),
//             if(previewInfo!.configPrintBill!.isShowUnit == 1)
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AutoSizeText(previewInfo!.branchInfo!.branchName!,style:TextStyle(fontSize: 18)),
//               ),
//             if(previewInfo!.configPrintBill!.isShowAddress == 1)
//               AutoSizeText(previewInfo!.branchInfo!.address!,style:TextStyle(fontSize: 18)),
//             if(previewInfo!.configPrintBill!.isShowPhone == 1)
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: AutoSizeText.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                           text: 'Hotline: ',
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//                       TextSpan(text: previewInfo!.spaInfo!.hotLine,style:TextStyle(fontSize: 18,fontWeight: FontWeight.bold))
//                     ],
//                   ),
//                 ),
//               ),
//             if(previewInfo!.configPrintBill!.isCompanyTaxCode == 1 && previewInfo!.spaInfo!.taxCode != null)
//               Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: AutoSizeText.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                           text: 'MST: ',
//                           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//                       TextSpan(text: previewInfo!.spaInfo!.taxCode,style:TextStyle(fontSize: 18))
//                     ],
//                   ),
//                 ),
//               ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(height: 1.0,color: Colors.black,width: MediaQuery.of(context).size.width*0.95,),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: AutoSizeText('HOÁ ĐƠN BÁN HÀNG',
//                   style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//             ),
//             if(previewInfo!.configPrintBill!.isShowOrderCode == 1)
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Align(
//                     alignment:Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: AutoSizeText('Mã hoá đơn: ${previewInfo!.order!.orderCode}',style:TextStyle(fontSize: 18)),
//                     )),
//               ),
//             if(previewInfo!.configPrintBill!.isShowCustomer == 1)
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Align(
//                     alignment:Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: AutoSizeText('Khách hàng: ${previewInfo!.order!.customerId == 1 ? 'Khách hàng vãng lai' : previewInfo!.order!.fullName}',style:TextStyle(fontSize: 18)),
//                     )),
//               ),
//             if(previewInfo!.configPrintBill!.isCustomerCode == 1)
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Align(
//                     alignment:Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: AutoSizeText('Mã KH: ${previewInfo!.order!.customerCode ?? ''}',style:TextStyle(fontSize: 18)),
//                     )),
//               ),
//             if(previewInfo!.configPrintBill!.isProfileCode == 1)
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Align(
//                     alignment:Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: AutoSizeText('Mã hồ sơ: ${previewInfo!.order!.profileCode ?? ''}',style:TextStyle(fontSize: 18)),
//                     )),
//               ),
//             if(previewInfo!.configPrintBill!.isShowCashier == 1)
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Align(
//                     alignment:Alignment.centerLeft,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                       child: AutoSizeText('Thu ngân: ${previewInfo!.order!.staffName}',style:TextStyle(fontSize: 18)),
//                     )),
//               ),
//             if(previewInfo!.configPrintBill!.isShowDatetime == 1)
//               Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: Align(
//                     alignment:Alignment.centerLeft,
//                     child: Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 5.0),
//                         child: AutoSizeText('Thời gian: ${formatDate(DateTime.now(), format: AppFormat.formatDateTime)}',style:TextStyle(fontSize: 18)))),
//               ),
//             Container(height:5.0),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 width: MediaQuery.of(context).size.width*0.95,
//                 decoration: BoxDecoration(
//                     border: Border.all()
//                 ),
//                 child: Column(
//                   children: [
//                     Container(
//                       height: 40,
//                       child: Row(
//                         children: [
//                           Container(
//                               width:MediaQuery.of(context).size.width*0.35,
//                               child: Center(child: AutoSizeText('Tên dịch vụ',style:TextStyle(fontSize: 18)))),
//                           Container(width: 1.0,color: Colors.black,),
//                           Expanded(
//                             child: Center(child: AutoSizeText('SL')),
//                           ),
//                           Container(width: 1.0,color: Colors.black,),
//                           Container(
//                               width:MediaQuery.of(context).size.width*0.23,
//                               child: Center(child: AutoSizeText('Đơn giá',style:TextStyle(fontSize: 18)))),
//                           Container(width: 1.0,color: Colors.black,),
//                           Container(
//                               width:MediaQuery.of(context).size.width*0.23,
//                               child: Center(child: AutoSizeText('T.Tiền',style:TextStyle(fontSize: 18)))),
//                         ],
//                       ),
//                     ),
//                     billService(),
//                     Container(height: 8.0,),
//                     Container(height: 1.0,color: Colors.black,),
//                     billMoneyInfo(),
//                     Container(height: 1.0,color: Colors.black,),
//                     Align(
//                         alignment:Alignment.centerLeft,
//                         child: Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8.0),child: AutoSizeText('Ghi chú: ',style:TextStyle(fontSize: 18))))
//                   ],
//                 ),
//               ),
//             ),
//             if(previewInfo!.configPrintBill!.noteFooter != '' && previewInfo!.configPrintBill!.noteFooter != null)
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0),
//                 child: AutoSizeText(previewInfo!.configPrintBill!.noteFooter!,
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 18)),
//               ),
//             if(previewInfo!.configPrintBill!.isShowFooter == 1)
//               Padding(
//                 padding: const EdgeInsets.only(top:8.0),
//                 child: AutoSizeText('Hoá đơn chỉ có giá trị trong vài ngày',
//                     style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18)),
//               ),
//             if(previewInfo!.configPrintBill!.isShowFooter == 1)
//               Padding(
//                 padding: const EdgeInsets.only(top:5.0),
//                 child: AutoSizeText('CẢM ƠN QUÝ KHÁCH VÀ HẸN GẶP LẠI',
//                     style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18)),
//               ),
//             // Padding(
//             //   padding: const EdgeInsets.only(top:15.0),
//             //   child: AutoSizeText('Lần in 1 - Ngày in: ${formatDate(DateTime.now(), format: AppFormat.formatDateTime)}',style:TextStyle(fontSize: 18)),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.only(top:3.0),
//             //   child: AutoSizeText('www.epoints.vn',
//             //       style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//             // ),
//             // Padding(
//             //   padding: const EdgeInsets.all(8.0),
//             //   child: SizedBox(width: 40,height: 40,child:
//             //   Container(
//             //       child: ColorFiltered(colorFilter: ColorFilter.mode(
//             //         Colors.grey,
//             //         BlendMode.saturation,
//             //       ),
//             //           child: Image.network('https://epoints.vn/uploads/config/20210904/9163076374804092021_config.png'))),),
//             // ),
//             // Center(
//             //   child: QrImageView(
//             //     data: previewInfo!.order!.orderId.toString(),
//             //     version: QrVersions.auto,
//             //     size: MediaQuery.of(context).size.width * 0.3,
//             //     gapless: false,
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget billMoneyInfo() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           child: Expanded(child:
//           Container(
//             decoration: BoxDecoration(
//                 border: Border(
//                   right: BorderSide(width: 1.0, color: Colors.black),
//                 )
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(height: 15.0,),
//                 Padding(
//                   padding: const EdgeInsets.only(left:8.0),
//                   child: AutoSizeText('Tổng dịch vụ:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left:8.0,top: 5.0),
//                   child: AutoSizeText('Thành tiền:',style:TextStyle(fontSize: 18)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left:8.0,top: 5.0),
//                   child: AutoSizeText('Giảm giá:',style:TextStyle(fontSize: 18)),
//                 ),
//                 Container(height: 30.0,),
//                 Padding(
//                   padding: const EdgeInsets.only(left:8.0),
//                   child: AutoSizeText('Tiền thanh toán:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left:8.0,top: 5.0),
//                   child: AutoSizeText('+ Tiền khách trả:',style:TextStyle(fontSize: 18)),
//                 ),
//                 if(previewInfo!.configPrintBill!.isPaymentMethod == 1 && previewInfo!.receiptDetail!.isNotEmpty)
//                   Column(
//                     children: previewInfo!.receiptDetail!.map((e) => Padding(
//                       padding: const EdgeInsets.only(left:12.0,top: 5.0),
//                       child: AutoSizeText(' ${e.paymentMethodName}',style:TextStyle(fontSize: 18)),
//                     ),).toList(),
//                   ),
//                 if(previewInfo!.configPrintBill!.isAmountReturn == 1)
//                   Padding(
//                     padding: const EdgeInsets.only(left:8.0,top: 5.0),
//                     child: AutoSizeText('+ Tiền trả lại:',style:TextStyle(fontSize: 18)),
//                   ),
//                 if(previewInfo!.configPrintBill!.isDeptCustomer == 1)
//                   Padding(
//                     padding: const EdgeInsets.only(left:8.0,top: 5.0),
//                     child: AutoSizeText('+ Khách nợ:',style:TextStyle(fontSize: 18)),
//                   ),
//                 if(previewInfo!.configPrintBill!.isAmountMember == 1)
//                   Padding(
//                     padding: const EdgeInsets.only(left:8.0,top: 15.0),
//                     child: AutoSizeText('Tài khoản thành viên:',style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//                   ),
//                 Container(height: 15.0,),
//               ],
//             ),
//           )),
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               Container(height: 15.0,),
//               Padding(
//                 padding: const EdgeInsets.only(right:8.0),
//                 child: AutoSizeText(previewInfo!.orderDetail!.length.toString(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right:8.0,top: 5.0),
//                 child: AutoSizeText(previewInfo!.order!.total.getMoneyFormat(),style:TextStyle(fontSize: 18)),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right:8.0,top: 5.0),
//                 child: AutoSizeText(previewInfo!.totalDiscount.getMoneyFormat(),style:TextStyle(fontSize: 18)),
//               ),
//               Container(height: 30.0,),
//               Padding(
//                 padding: const EdgeInsets.only(right:8.0),
//                 child: AutoSizeText(previewInfo!.order!.amount.getMoneyFormat(),style:TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(right:8.0,top: 5.0),
//                 child: AutoSizeText(previewInfo!.amountPaid.getMoneyFormat(),style:TextStyle(fontSize: 18)),
//               ),
//               if(previewInfo!.configPrintBill!.isPaymentMethod == 1 && previewInfo!.receiptDetail!.isNotEmpty)
//                 Column(
//                   children: previewInfo!.receiptDetail!.map((e) => Padding(
//                     padding: const EdgeInsets.only(right:8.0,top: 5.0),
//                     child: AutoSizeText(e.amount.getMoneyFormat(),style:TextStyle(fontSize: 18)),
//                   ),).toList(),
//                 ),
//               if(previewInfo!.configPrintBill!.isAmountReturn == 1)
//                 Padding(
//                   padding: const EdgeInsets.only(right:8.0,top: 5.0),
//                   child: AutoSizeText(previewInfo!.amountReturn.getMoneyFormat(),style:TextStyle(fontSize: 18)),
//                 ),
//               if(previewInfo!.configPrintBill!.isDeptCustomer == 1)
//                 Padding(
//                   padding: const EdgeInsets.only(right:8.0,top: 5.0),
//                   child: AutoSizeText(((previewInfo!.order!.amount!-previewInfo!.amountPaid!) < 0.0 ? 0.0 : previewInfo!.order!.amount!-previewInfo!.amountPaid!).getMoneyFormat(),style:TextStyle(fontSize: 18)),
//                 ),
//               if(previewInfo!.configPrintBill!.isAmountMember == 1)
//                 Padding(
//                   padding: const EdgeInsets.only(right:8.0,top: 15.0),
//                   child: AutoSizeText(previewInfo!.accountMoney.getMoneyFormat(),style:TextStyle(fontSize: 18)),
//                 ),
//               Container(height: 15.0,),
//             ],
//           ),
//         )
//       ],
//     );
//   }

//   Widget billService() {
//     List<Widget> _arr = [];
//     if(previewInfo!.orderDetail != null && previewInfo!.orderDetail!.isNotEmpty) {
//       for(int i=0;i<=previewInfo!.orderDetail!.length-1;i++) {
//         _arr.add(Container(height: 1.0,color: Colors.black,));
//         final e = previewInfo!.orderDetail![i];
//         _arr.add(
//             Column(children: [
//               Padding(
//                 padding: EdgeInsets.only(left: 8.0,right: 8.0,top: 8.0,bottom: 5.0),
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: AutoSizeText(e.objectName!,style:TextStyle(fontSize: 18))),
//               ),
//               if(e.note != null) Padding(
//                 padding: EdgeInsets.only(left: 8.0,right: 8.0,bottom: 5.0),
//                 child: Align(
//                     alignment: Alignment.centerLeft,
//                     child: AutoSizeText('(Ghi chú: ${e.note})',style: TextStyle(fontStyle: FontStyle.italic,fontSize: 18.0),)),
//               ),
//               Container(
//                 child: Row(
//                   children: [
//                     Container(
//                         width:MediaQuery.of(context).size.width*0.35,
//                         child: Container()),
//                     Container(width: 1.0,color: Colors.black,),
//                     Expanded(
//                       child: Center(child: AutoSizeText(e.quantity.toString(),style:TextStyle(fontSize: 18))),
//                     ),
//                     Container(width: 1.0,color: Colors.black,),
//                     Container(
//                         width:MediaQuery.of(context).size.width*0.23,
//                         child: Center(child: AutoSizeText(e.price.getMoneyFormat(),style:TextStyle(fontSize: 18)))),
//                     Container(width: 1.0,color: Colors.black,),
//                     Container(
//                         width:MediaQuery.of(context).size.width*0.23,
//                         child: Center(child: AutoSizeText(e.amount.getMoneyFormat(),style:TextStyle(fontSize: 18)))),
//                   ],
//                 ),
//               )
//             ],)
//         );
//         // if(previewInfo!.orderDetail![i].attach != null && previewInfo!.orderDetail![i].attach!.isNotEmpty) {
//         //   previewInfo!.orderDetail![i].attach!.forEach((h) {
//         //     _arr.add(Column(children: [
//         //       Padding(
//         //         padding: EdgeInsets.only(left: 18.0,right: 8.0,top: 8.0,bottom: 5.0),
//         //         child: Align(
//         //             alignment: Alignment.centerLeft,
//         //             child: AutoSizeText('+ ${h.objectName}',style:TextStyle(fontSize: 18))),
//         //       ),
//         //       Container(
//         //         child: Row(
//         //           children: [
//         //             Container(
//         //                 width:MediaQuery.of(context).size.width*0.35,
//         //                 child: Container()),
//         //             Container(width: 1.0,color: Colors.black,),
//         //             Expanded(
//         //               child: Center(child: AutoSizeText(h.quantity.toString(),style:TextStyle(fontSize: 18))),
//         //             ),
//         //             Container(width: 1.0,color: Colors.black,),
//         //             Container(
//         //                 width:MediaQuery.of(context).size.width*0.23,
//         //                 child: Center(child: AutoSizeText(h.price.getMoneyFormat(),style:TextStyle(fontSize: 18)))),
//         //             Container(width: 1.0,color: Colors.black,),
//         //             Container(
//         //                 width:MediaQuery.of(context).size.width*0.23,
//         //                 child: Center(child: AutoSizeText(h.amount.getMoneyFormat(),style:TextStyle(fontSize: 18)))),
//         //           ],
//         //         ),
//         //       )
//         //     ],));
//         //   });
//         // }
//       }
//     }
//     return Column(children: _arr,);
//   }

//   Widget tag(int index,int total) {
//     return Column(
//       children: [
//         AutoSizeText(
//           previewInfo!.order!.orderCode!,
//           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
//         ),
//         Container(
//           height: 10.0,
//         ),
//         AutoSizeText.rich(
//           TextSpan(
//             children: [
//               TextSpan(
//                   text: previewInfo!.order!.deliveryRequestDate,
//                   style: TextStyle(fontSize: 18)),
//             ],
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         Container(
//           height: 5.0,
//         ),
//         AutoSizeText.rich(
//           TextSpan(
//             children: [
//               TextSpan(
//                   text: 'STT: ${index+1}/$total \n',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               TextSpan(
//                   text: previewInfo!.orderDetail![index].objectName,
//                   style: TextStyle(fontSize: 18)),
//             ],
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//         Container(
//           height: 5.0,
//         ),
//         // AutoSizeText.rich(
//         //   TextSpan(
//         //     children: [
//         //       TextSpan(
//         //           text: 'D/v thêm: ',
//         //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//         //       TextSpan(
//         //           text:
//         //           attachMoreService(previewInfo!.orderDetail![index].attach!),
//         //           style: TextStyle(fontSize: 18)),
//         //     ],
//         //   ),
//         //   maxLines: 2,
//         //   overflow: TextOverflow.ellipsis,
//         // ),
//         // Container(
//         //   height: 5.0,
//         // ),
//         AutoSizeText.rich(
//           TextSpan(
//             children: [
//               TextSpan(
//                   text: 'Ghi chú: ',
//                   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
//               TextSpan(
//                   text: previewInfo!.orderDetail![index].note ?? "",
//                   style: TextStyle(fontSize: 18)),
//             ],
//           ),
//           maxLines: 1,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//       crossAxisAlignment: CrossAxisAlignment.start,
//     );
//   }

//   // String attachMoreService(List<OrderDetailAttachModel> attach) {
//   //   String result = "";
//   //   if (attach.length > 0) {
//   //     for (int i = 0; i <= attach.length - 1; i++) {
//   //       result += attach[i].objectName!;
//   //       if (i != attach.length - 1) {
//   //         result += ",";
//   //       }
//   //     }
//   //   }
//   //   return result;
//   // }
// }