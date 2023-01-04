import 'dart:math';
import 'package:draggable_expandable_fab/draggable_expandable_fab.dart';
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/assign_revoke_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/description_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/presentation/edit_deal/edit_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/multi_staff_screen_potentail/ui/multi_staff_screen.dart';
import 'package:epoint_deal_plugin/widget/custom_avatar.dart';
import 'package:epoint_deal_plugin/widget/custom_avatar_with_url.dart';
import 'package:epoint_deal_plugin/widget/custom_info_item.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailDealScreen extends StatefulWidget {
  String deal_code;
  int indexTab;
  bool customerCare;
  DetailDealScreen({Key key, this.deal_code, this.indexTab, this.customerCare})
      : super(key: key);

  @override
  _DetailDealScreenState createState() => _DetailDealScreenState();
}

class _DetailDealScreenState extends State<DetailDealScreen> {
  final ScrollController _controller = ScrollController();
  List<WorkListStaffModel> models = [];
  DetailDealData detail;
  bool allowPop = false;

  final formatter = NumberFormat.currency(
    locale: 'vi_VN',
    decimalDigits: 0,
    symbol: '',
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
  }

  void getData() async {
    var dataDetail =
        await DealConnection.getdetailDeal(context, widget.deal_code);
    if (dataDetail != null) {
      if (dataDetail.errorCode == 0) {
        detail = dataDetail.data;
        setState(() {});
      } else {
        await DealConnection.showMyDialog(context, dataDetail.errorDescription);
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (allowPop) {
          Navigator.of(context).pop(allowPop);
        } else {
          Navigator.of(context).pop();
        }
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppLocalizations.text(LangKey.detail_deal),
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          // leadingWidth: 20.0,
        ),
        body: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: buildBody()),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: ExpandableDraggableFab(
          initialDraggableOffset:
              Offset(12, MediaQuery.of(context).size.height * 11 / 14),
          initialOpen: false,
          curveAnimation: Curves.easeOutSine,
          childrenBoxDecoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(10.0)),
          childrenCount: 3,
          distance: 10,
          childrenType: ChildrenType.columnChildren,
          childrenAlignment: Alignment.centerRight,
          childrenInnerMargin: EdgeInsets.all(20.0),
          openWidget: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.3),
                )
              ], shape: BoxShape.circle, color: AppColors.primaryColor),
              width: 60,
              height: 60,
              child: Image.asset(
                Assets.iconFABMenu,
                scale: 2.5,
              )),
          closeWidget: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.3),
                )
              ], shape: BoxShape.circle, color: Color(0xFF5F5F5F)),
              width: 60,
              height: 60,
              child: Icon(
                Icons.clear,
                size: 35,
                color: Colors.white,
              )),
          children: [
            // (detail?.saleId == 0)
            //     ? Column(
            //         children: [
            //           FloatingActionButton(
            //               backgroundColor: AppColors.primaryColor,
            //               heroTag: "btn1",
            //               onPressed: () async {
            //                 models = await Navigator.of(context).push(
            //                     MaterialPageRoute(
            //                         builder: (context) =>
            //                             MultipleStaffScreenDeal(
            //                               models: models,
            //                             )));

            //                 if (models != null && models.length > 0) {
            //                   int staffID = models[0].staffId;

            //                   if (staffID != null) {
            //                     DescriptionModelResponse result =
            //                         await DealConnection.assignRevokeLead(
            //                             context,
            //                             AssignRevokeDealModelRequest(
            //                                 type: "assign",
            //                                 dealCode: detail.dealCode,
            //                                 saleId: staffID,
            //                                 timeRevokeLead: 30));

            //                     if (result != null) {
            //                       if (result.errorCode == 0) {
            //                         print(result.errorDescription);

            //                         await DealConnection.showMyDialog(
            //                             context, result.errorDescription);
            //                         getData();
            //                       } else {
            //                         DealConnection.showMyDialog(
            //                             context, result.errorDescription);
            //                       }
            //                     }
            //                   }

            //                   print(models);
            //                 }

            //                 print("iconAssignment");
            //               },
            //               child:
            //                   Image.asset(Assets.iconAssignment, scale: 2.5)),
            //           SizedBox(
            //             height: 5.0,
            //           ),
            //           Text(
            //             AppLocalizations.text(LangKey.assignment),
            //             style: TextStyle(
            //                 color: Colors.white,
            //                 fontSize: 14.0,
            //                 fontWeight: FontWeight.w400),
            //           )
            //         ],
            //       )
            //     : Column(
            //         children: [
            //           FloatingActionButton(
            //               backgroundColor: Color(0xFFFFAD02),
            //               heroTag: "btn1",
            //               onPressed: () async {
            //                 DealConnection.showMyDialogWithFunction(
            //                     context,
            //                     AppLocalizations.text(
            //                         LangKey.warningRecallStaff),
            //                     ontap: () async {
            //                   DescriptionModelResponse result =
            //                       await DealConnection.assignRevokeLead(
            //                           context,
            //                           AssignRevokeDealModelRequest(
            //                               type: "revoke",
            //                               dealCode: detail.dealCode,
            //                               saleId: detail.saleId,
            //                               timeRevokeLead: 30));

            //                   Navigator.of(context).pop();

            //                   if (result != null) {
            //                     if (result.errorCode == 0) {
            //                       print(result.errorDescription);

            //                       await DealConnection.showMyDialog(
            //                           context, result.errorDescription);
            //                       getData();
            //                     } else {
            //                       DealConnection.showMyDialog(
            //                           context, result.errorDescription);
            //                     }
            //                   }
            //                 });
            //                 print("iconRecall");
            //               },
            //               child: Image.asset(Assets.iconRecall, scale: 2.5)),
            //           SizedBox(
            //             height: 5.0,
            //           ),
            //           Text(AppLocalizations.text(LangKey.recall),
            //               style: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 14.0,
            //                   fontWeight: FontWeight.w400))
            //         ],
            //       ),
            Column(
              children: [
                FloatingActionButton(
                    backgroundColor: Color(0xFFCD6000),
                    heroTag: "btn2",
                    onPressed: () async {
                      if (Global.createJob != null) {
                        await Global.createJob();
                      }

                      print("iconTask");
                    },
                    child: Image.asset(
                      Assets.iconTask,
                      scale: 2.5,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Text(AppLocalizations.text(LangKey.createJobs),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400))
              ],
            ),
            Column(
              children: [
                FloatingActionButton(
                    backgroundColor: Color(0xFFDD2C00),
                    heroTag: "btn3",
                    onPressed: () async {
                      DealConnection.showMyDialogWithFunction(context,
                          AppLocalizations.text(LangKey.warningDeleteDeal),
                          ontap: () async {
                        DescriptionModelResponse result =
                            await DealConnection.deleteDeal(
                                context, detail.dealCode);

                        Navigator.of(context).pop();

                        if (result != null) {
                          if (result.errorCode == 0) {
                            print(result.errorDescription);

                            await DealConnection.showMyDialog(
                                context, result.errorDescription);
                            Navigator.of(context).pop(true);
                          } else {
                            DealConnection.showMyDialog(
                                context, result.errorDescription);
                          }
                        }
                      });

                      print("iconDelete");
                    },
                    child: Image.asset(
                      Assets.iconDelete,
                      scale: 2.5,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Text(AppLocalizations.text(LangKey.delete),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400))
              ],
            ),
            Column(
              children: [
                FloatingActionButton(
                  heroTag: "btn4",
                  onPressed: () async {
                    if (detail.journeyCode != "PJD_DEAL_END") {
                      bool result = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditDealScreen(detail: detail)));

                      if (result != null) {
                        if (result) {
                          allowPop = true;
                          getData();
                          ;
                        }
                      }
                    }

                    print("iconEdit");
                  },
                  backgroundColor: Color(0xFF00BE85),
                  child: Image.asset(
                    Assets.iconEdit,
                    scale: 2.5,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(AppLocalizations.text(LangKey.edit),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return (detail == null)
        ? Container()
        : Column(
            children: [
              // Container(
              //     // height: 100,
              //     padding: EdgeInsets.all(10.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         _buildFunction(
              //             AppLocalizations.text(LangKey.edit),
              //             Assets.iconEdit,
              //             Color(0xFF59B196), () async {
              //           if (detail.journeyCode != "PJD_DEAL_END") {
              //             bool result = await Navigator.of(context).push(
              //                 MaterialPageRoute(
              //                     builder: (context) =>
              //                         EditDealScreen(detail: detail)));

              //             if (result != null) {
              //               if (result) {
              //                 allowPop = true;
              //                 getData();
              //                 ;
              //               }
              //             }
              //           }
              //         }),
              //         _buildFunction(
              //             AppLocalizations.text(LangKey.delete),
              //             Assets.iconDelete,
              //             Color.fromARGB(255, 231, 86, 86), () async {

              //               DealConnection.showMyDialogWithFunction(context,AppLocalizations.text(LangKey.warningDeleteDeal), ontap: () async {

              //                 DescriptionModelResponse result =
              //               await DealConnection.deleteDeal(
              //                   context, detail.dealCode);

              //                    Navigator.of(context).pop();

              //           if (result != null) {
              //             if (result.errorCode == 0) {
              //               print(result.errorDescription);

              //               await DealConnection.showMyDialog(
              //                   context, result.errorDescription);
              //               Navigator.of(context).pop(true);
              //             } else {
              //               DealConnection.showMyDialog(
              //                   context, result.errorDescription);
              //             }
              //           }
              //               });

              //           // DescriptionModelResponse result =
              //           //     await DealConnection.deleteDeal(
              //           //         context, detail.dealCode);

              //           // if (result != null) {
              //           //   if (result.errorCode == 0) {
              //           //     print(result.errorDescription);

              //           //     await DealConnection.showMyDialog(
              //           //         context, result.errorDescription);
              //           //     Navigator.of(context).pop(true);
              //           //   } else {
              //           //     DealConnection.showMyDialog(
              //           //         context, result.errorDescription);
              //           //   }
              //           // }

              //         }),
              //         (detail?.saleId == null)
              //             ? _buildFunction(
              //                 AppLocalizations.text(LangKey.assignment),
              //                 Assets.iconAssignment,
              //                 Color(0xFF2F9AF4), () async {
              //                 int staffID = await Navigator.of(context).push(
              //                     MaterialPageRoute(
              //                         builder: (context) => AllocatorScreen()));

              //                 if (staffID != null) {
              //                   DescriptionModelResponse result =
              //                       await DealConnection.assignRevokeLead(
              //                           context,
              //                           AssignRevokeDealModelRequest(
              //                               type: "assign",
              //                               dealCode: detail.dealCode,
              //                               saleId: staffID,
              //                               timeRevokeLead: 30));

              //                   if (result != null) {
              //                     if (result.errorCode == 0) {
              //                       print(result.errorDescription);

              //                       await DealConnection.showMyDialog(
              //                           context, result.errorDescription);
              //                       getData();
              //                     } else {
              //                       DealConnection.showMyDialog(
              //                           context, result.errorDescription);
              //                     }
              //                   }
              // }
              //               })
              //             : _buildFunction(
              //                 AppLocalizations.text(LangKey.recall),
              //                 Assets.iconRecall,
              //                 Color(0xFF2F9AF4), () async {
              //                 DescriptionModelResponse result =
              //                     await DealConnection.assignRevokeLead(
              //                         context,
              //                         AssignRevokeDealModelRequest(
              //                             type: "revoke",
              //                             dealCode: detail.dealCode,
              //                             saleId: detail.saleId,
              //                             timeRevokeLead: 30));

              //                 if (result != null) {
              //                   if (result.errorCode == 0) {
              //                     print(result.errorDescription);

              //                     await DealConnection.showMyDialog(
              //                         context, result.errorDescription);
              //                     getData();
              //                   } else {
              //                     DealConnection.showMyDialog(
              //                         context, result.errorDescription);
              //                   }
              //                 }
              //               }),
              //         _buildFunction(
              //             AppLocalizations.text(LangKey.createJobs),
              //             Assets.iconTask,
              //             Color.fromARGB(255, 243, 180, 125), () async {
              //           if (Global.createJob != null) {
              //             await Global.createJob(widget.deal_code);
              //           }
              //         })
              //       ],
              //     )),
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _controller,
                children: buildInfomation(),
              )),
              Container(
                height: 20.0,
              )
            ],
          );
  }

  List<Widget> buildInfomation() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 70), child: _dealInformationV2()),
          //     Container(
          //       decoration: const BoxDecoration(color: AppColors.lightGrey),
          //       padding: const EdgeInsets.all(16.0),
          //       child: Row(
          //         children: [
          //           _buildAvatar(detail?.dealName ?? ""),
          //           Expanded(
          //               child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Container(
          //                 height: 40.0,
          //                 padding: EdgeInsets.only(left: 15.0 / 1.5),
          //                 child: Column(
          //                   crossAxisAlignment: CrossAxisAlignment.start,
          //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //                   children: [
          //                     Text(
          //                       detail?.dealName ?? "",
          //                       style: AppTextStyles.style14BlackWeight500,
          //                     ),
          //                     Text(
          //                       detail?.customerName ?? "",
          //                       style: TextStyle(
          //                           fontSize: AppTextSizes.size18,
          //                           color: AppColors.black,
          //                           fontWeight: FontWeight.w600),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           )),
          //         ],
          //       ),
          //     ),
          //     Container(
          //       width: MediaQuery.of(context).size.width,
          //       decoration: const BoxDecoration(color: AppColors.white),
          //       padding: const EdgeInsets.all(8.0),
          //       // margin: const EdgeInsets.only(bottom: 10.0),
          //       child: Column(
          //         children: [
          //           _phoneNumberItem(),
          //           const Divider(),
          //           _infoItem(
          //               AppLocalizations.text(LangKey.dealPrice),
          // formatter.format(num.parse(detail?.amount ?? "")) + "VND", style: TextStyle(
          // fontSize: AppTextSizes.size16,
          // color: AppColors.bluePrimary,
          // fontWeight: FontWeight.w500)),
          //           const Divider(),
          //           _infoItem(
          //               AppLocalizations.text(LangKey.dealCode),
          //               detail?.dealCode ?? ""),
          //           const Divider(),
          //           (detail?.staffName != null)
          //               ? _infoItem(AppLocalizations.text(LangKey.allottedPerson),
          //                   detail?.staffName ?? "")
          //               : Container(),
          //           (detail?.staffName != null) ? Divider() : Container(),
          //           _infoItem(AppLocalizations.text(LangKey.pipeline),
          //               detail?.pipelineCode ?? ""),
          //         ],
          //       ),
          //     ),
          // Container(
          //   margin: const EdgeInsets.only(bottom: 20.0),
          //   height: 5.0,
          //   decoration: const BoxDecoration(
          //     color: AppColors.lightGrey,
          //   ),
          // ),
          // SingleChildScrollView(
          //   physics: ClampingScrollPhysics(),
          //   scrollDirection: Axis.horizontal,
          //   child: builJourneyTracking(),
          // ),
          // Container(
          //   margin: const EdgeInsets.only(top: 20.0, bottom: 8.0),
          //   height: 5.0,
          //   decoration: const BoxDecoration(
          //     color: AppColors.lightGrey,
          //   ),
          // ),
          SubDetailDealCustomer(
            detail: detail,
            indexTab: widget.indexTab,
          )
        ],
      )
    ];
  }

  Widget _dealInformationV2() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.all(11.0),
          // padding: EdgeInsets.only(bot),
          child: Container(
            padding: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Color(0xFFC3C8D3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(right: 8.0, top: 8.0),
                    margin: EdgeInsets.only(top: 25.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 24,
                              width: 55,
                              margin: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF3AEDB6),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Center(
                                child: Text("Mới",
                                    style: TextStyle(
                                        color: Color(0xFF11B482),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ),
                            Text("80%",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700))
                          ],
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(detail?.dealName ?? "",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 4.0,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Zalo",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                children: [
                              TextSpan(
                                  text: " - " + "Tinh Gia",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold))
                            ])),
                        SizedBox(height: 5),
                        Text(detail?.phone ?? "",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                        SizedBox(height: 5),
                        Text(
                          "DN- CTY TNHH MỘT THÀNH VIÊN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontSize: 16.0,
                              color: Color(0xFF8E8E8E),
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 8.0),
                  margin: EdgeInsets.only(right: 8.0, top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          // width: MediaQuery.of(context).size.width / 2 - 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // infoItem(Assets.iconName, item?.staffFullName ?? "", true),
                              // infoItem(Assets.iconInteraction, item?.journeyName ?? "", true),

                              infoItem(Assets.iconDeal, detail?.dealCode),
                              infoItem(
                                  Assets.iconName, detail?.staffName ?? ""),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 3.0, bottom: 8.0),
                                margin: EdgeInsets.only(bottom: 8.0, left: 5.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      height: 15.0,
                                      width: 15.0,
                                      child:
                                          Image.asset(Assets.iconInteraction),
                                    ),
                                    Expanded(
                                      child: RichText(
                                          text: TextSpan(
                                              text: "27/08/2022" + " ",
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              children: [
                                            TextSpan(
                                                text: "(1 ngày)",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal))
                                          ])),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 3.0, bottom: 6.0),
                                margin: EdgeInsets.only(left: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      height: 15.0,
                                      width: 15.0,
                                      child: Image.asset(Assets.iconTag),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "35.000 VND",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                        // maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              print(detail.phone);
                              await callPhone(detail?.phone ?? "");
                            },
                            child: Container(
                              padding: EdgeInsets.all(20.0 / 2),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFF06A605),
                                borderRadius: BorderRadius.circular(50),
                                // border:  Border.all(color: AppColors.white,)
                              ),
                              child: Center(
                                  child: Image.asset(
                                Assets.iconCall,
                                color: AppColors.white,
                              )),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _actionItem(
                                  Assets.iconCalendar, Color(0xFF26A7AD),
                                  show: true, number: 30, ontap: () {
                                print("1");
                              }),
                              _actionItem(Assets.iconOutdate, Color(0xFFDD2C00),
                                  show: true, number: 30, ontap: () {
                                print("2");
                              }),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 44.5,
          top: -55,
          child: _buildAvatar(detail?.dealName ?? ""),
        ),
      ],
    );
  }

  Widget infoItem(String icon, String title) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8.0),
      margin: EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            height: 15.0,
            width: 15.0,
            child: Image.asset(icon),
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal),
              // maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionItem(String icon, Color color,
      {num number, bool show = false, Function ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
          margin: EdgeInsets.only(left: 17),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(1000.0)),
                child: Center(
                  child: Image.asset(
                    icon,
                    scale: 2.5,
                  ),
                ),
              ),
              show
                  ? Positioned(
                      left: 30,
                      bottom: 30,
                      child: Container(
                        width: (number > 99)
                            ? 30
                            : (number > 9)
                                ? 25
                                : 22,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFFF45E38)),
                        child: Center(
                            child: Text("${number ?? 0}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600))),
                      ))
                  : Container()
            ],
          )),
    );
  }

  // Widget builJourneyTracking() {
  //   int lenght = detail?.journeyTracking?.length ?? 0;
  //   return Stack(
  //     alignment: AlignmentDirectional.centerStart,
  //     children: [
  //       Row(
  //         children: [
  //           Container(
  //             width: 10.0,
  //           ),
  //           (lenght > 0)
  //               ? journeyitem(detail.journeyTracking[0].journeyName,
  //                   detail.journeyTracking[0].check, 130.0)
  //               : Container(),
  //           (lenght > 1)
  //               ? journeyitem((detail.journeyTracking[1].journeyName),
  //                   detail.journeyTracking[1].check, 190.0)
  //               : Container(),
  //           (lenght > 2)
  //               ? journeyitem((detail.journeyTracking[2].journeyName),
  //                   detail?.journeyTracking[2].check, 190.0)
  //               : Container(),
  //           (lenght > 3)
  //               ? journeyitem((detail.journeyTracking[3].journeyName),
  //                   detail.journeyTracking[3].check, 190.0)
  //               : Container(),
  //           (lenght > 4)
  //               ? journeyitem((detail.journeyTracking[4].journeyName),
  //                   detail.journeyTracking[4].check, 180.0)
  //               : Container(),
  //           (lenght > 5)
  //               ? journeyitem((detail.journeyTracking[5].journeyName),
  //                   detail.journeyTracking[5].check, 180.0)
  //               : Container(),
  //           Container(
  //             width: 30,
  //           )
  //         ],
  //       ),
  //       (lenght > 0)
  //           ? positionJourney(
  //               126,
  //               detail.journeyTracking[0].check
  //                   ? Color(0xFF0BC50B)
  //                   : Color(0xFFF99843))
  //           : Container(),
  //       (lenght > 1)
  //           ? positionJourney(
  //               316,
  //               detail.journeyTracking[1].check
  //                   ? Color(0xFF0BC50B)
  //                   : Color(0xFFF99843))
  //           : Container(),
  //       (lenght > 2)
  //           ? positionJourney(
  //               506,
  //               detail.journeyTracking[2].check
  //                   ? Color(0xFF0BC50B)
  //                   : Color(0xFFF99843))
  //           : Container(),
  //       (lenght > 3)
  //           ? positionJourney(
  //               696,
  //               detail.journeyTracking[3].check
  //                   ? Color(0xFF0BC50B)
  //                   : Color(0xFFF99843))
  //           : Container(),
  //       (lenght > 4)
  //           ? positionJourney(
  //               876,
  //               detail.journeyTracking[4].check
  //                   ? Color(0xFF0BC50B)
  //                   : Color(0xFFF99843))
  //           : Container(),
  //       (detail.journeyTracking.length > 5)
  //           ? positionJourney(
  //               1056,
  //               detail.journeyTracking[5].check
  //                   ? Color(0xFF0BC50B)
  //                   : Color(0xFFF99843))
  //           : Container(),
  //       // positionJourney(116),
  //     ],
  //   );
  // }

  // Widget journeyitem(String title, bool status, double width) {
  //   return Container(
  //     // margin: EdgeInsets.only(right: margin) ,
  //     decoration: BoxDecoration(
  //       color: status ? const Color(0xFF0BC50B) : const Color(0xFFF99843),
  //     ),
  //     width: width,
  //     height: 40,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         status
  //             ? Icon(Icons.check, color: Color(0xFFFFFFFF))
  //             : Image.asset(
  //                 Assets.iconWait,
  //                 color: Color(0xFFFFFFFF),
  //                 width: 24.0,
  //               ),
  //         Container(
  //           width: 4.0,
  //         ),
  //         Text(
  //           title,
  //           style: TextStyle(
  //               fontSize: AppTextSizes.size15,
  //               color:
  //                   status ? const Color(0xFFFFFFFF) : const Color(0xFF000000),
  //               fontWeight: FontWeight.bold),
  //         )
  //       ],
  //     ),
  //   );
  // }

  // Widget positionJourney(double left, Color color) {
  //   return Positioned(
  //     left: left,
  //     bottom: 5,
  //     child: Transform.rotate(
  //       angle: 45 * pi / 180,
  //       child: Container(
  //           decoration: BoxDecoration(
  //               color: color,
  //               border: Border(
  //                   top: BorderSide(color: AppColors.lineColor, width: 2.0),
  //                   right: BorderSide(color: AppColors.lineColor, width: 2.0))),
  //           height: 30,
  //           width: 30),
  //     ),
  //   );
  // }

  Widget _infoItem(String title, String content,
      {TextStyle style, String icon, String icon2}) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 2.1,
            child: Row(
              children: [
                if (icon != null)
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    height: 15.0,
                    width: 15.0,
                    child: Image.asset(icon),
                  ),
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    title,
                    style: AppTextStyles.style15BlackNormal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Text(
            content,
            style: style ??
                TextStyle(
                    fontSize: AppTextSizes.size15,
                    color: AppColors.black,
                    fontWeight: FontWeight.normal),
            // maxLines: 1,
          )),
          if (icon2 != null)
            Container(
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              height: 30.0,
              width: 30.0,
              child: Image.asset(icon2),
            ),
        ],
      ),
    );
  }

  Widget _phoneNumberItem() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 2.1,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    AppLocalizations.text(LangKey.phoneNumber),
                    style: AppTextStyles.style15BlackNormal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(detail?.phone ?? "",
                style: AppTextStyles.style16BlueWeight500),
          ),
          InkWell(
            onTap: () {
              callPhone(detail?.phone ?? "");
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color(0xFF06A605),
                borderRadius: BorderRadius.circular(50),
                // border:  Border.all(color: AppColors.white,)
              ),
              child: Center(
                  child: Image.asset(
                Assets.iconCall,
                color: AppColors.white,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> callPhone(String phone) async {
    final regSpace = RegExp(r"\s+");
    // return await launchUrl(Uri.parse("tel:" + phone.replaceAll(regSpace, "")));
    return await launch("tel:" + phone.replaceAll(regSpace, ""));
  }

  Future<bool> _openChathub(String link) async {
    return await launch(link);
  }

  Widget _buildAvatar(String name) {
    return Container(
      width: 87.0,
      height: 87.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: AppColors.primaryColor,
        ),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000.0),
        child: CustomAvatar(
          color: Color(0xFFEEB132),
          name: name,
          textSize: 36.0,
        ),
      ),
    );
  }

  Widget _buildFunction(String name, String icon, Color color, Function ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            padding: (name == AppLocalizations.text(LangKey.recall))
                ? EdgeInsets.all(8.0)
                : EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Image.asset(
              icon,
            ),
          ),
          Container(height: 8.0),
          Text(name)
        ],
      ),
    );
  }
}

class DetailPotentialTabModel {
  String typeName;
  int typeID;
  bool selected;

  DetailPotentialTabModel({this.typeName, this.typeID, this.selected});

  factory DetailPotentialTabModel.fromJson(Map<String, dynamic> parsedJson) {
    return DetailPotentialTabModel(
        typeName: parsedJson['typeName'],
        typeID: parsedJson['typeID'],
        selected: parsedJson['selected']);
  }
}

class SubDetailDealCustomer extends StatefulWidget {
  DetailDealData detail;
  int indexTab;
  SubDetailDealCustomer({Key key, this.detail, this.indexTab})
      : super(key: key);

  @override
  _SSubDetailDealCustomerCustomerState createState() =>
      _SSubDetailDealCustomerCustomerState();
}

class _SSubDetailDealCustomerCustomerState
    extends State<SubDetailDealCustomer> {
  int index = 0;

  List<DetailPotentialTabModel> tabDeal = [
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.generalInfomation),
        typeID: 0,
        selected: true),
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.customerCare),
        typeID: 1,
        selected: false),
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.discuss),
        typeID: 2,
        selected: false),
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.order_history),
        typeID: 3,
        selected: false)
  ];

  @override
  void initState() {
    super.initState();
    index = widget.indexTab;
    for (int i = 0; i < tabDeal.length; i++) {
      if (index == tabDeal[i].typeID) {
        tabDeal[i].selected = true;
      } else {
        tabDeal[i].selected = false;
      }
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: buildListOption(),
        ),
        Container(
          height: 20,
        ),
        (index == 0)
            ? detailInformation()
            : (index == 1)
                ? customerCare()
                : (index == 2)
                    ? Container()
                    : orderHistory()
      ],
    );
  }

  Widget buildListOption() {
    return Row(
      children: [
        option(AppLocalizations.text(LangKey.generalInfomation),
            tabDeal[0].selected, 100, () {
          index = 0;
          selectedTab(0);
        }),
        option(AppLocalizations.text(LangKey.customerCare), tabDeal[1].selected,
            120, () {
          index = 1;
          selectedTab(1);
        }),
        option(AppLocalizations.text(LangKey.discuss), tabDeal[2].selected, 80,
            () {
          index = 2;
          selectedTab(2);
        }),
        option(AppLocalizations.text(LangKey.order_history),
            tabDeal[3].selected, 120, () {
          index = 3;
          selectedTab(3);
        })
      ],
    );
  }

  Widget option(String title, bool show, double width, Function ontap) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15.0 / 1.5),
          height: 40,
          child: InkWell(
            onTap: ontap,
            child: Center(
              child: Text(
                title,
                style: show
                    ? TextStyle(
                        fontSize: AppTextSizes.size16,
                        color: AppColors.blueColor,
                        fontWeight: FontWeight.bold)
                    : TextStyle(
                        fontSize: AppTextSizes.size16,
                        color: AppColors.colorTabUnselected,
                        fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
        ),
        show
            ? Container(
                decoration: const BoxDecoration(color: AppColors.blueColor),
                width: width,
                height: 3.0,
              )
            : Container()
      ],
    );
  }

  Widget generalInfomation() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text(
              AppLocalizations.text(LangKey.picture),
              style: TextStyle(
                  fontSize: AppTextSizes.size15,
                  color: const Color(0xFF858080),
                  fontWeight: FontWeight.normal),
            ),
          ),

          Center(
            child: _buildAvatarImg(widget.detail.customerName),
          ),

          const Divider(),

          _infoItem(AppLocalizations.text(LangKey.fullName),
              widget.detail?.customerName ?? "",
              icon: Assets.iconStyleCustomer),
          const Divider(),
          _infoItem(AppLocalizations.text(LangKey.phoneNumber),
              widget.detail?.phone ?? "",
              icon: Assets.iconCall),
          const Divider(),

          _infoItem(AppLocalizations.text(LangKey.customerStyle),
              widget.detail?.typeCustomer ?? "",
              icon: Assets.iconSourceCustomer),
          const Divider(),

          _infoItem(AppLocalizations.text(LangKey.customerSource),
              widget.detail?.orderSourceName ?? "",
              icon: Assets.iconPerson),
          const Divider(),

          _infoItem(AppLocalizations.text(LangKey.email),
              widget.detail?.customerEmail ?? "",
              icon: Assets.iconEmail),
          const Divider(),
          sexInfo(widget.detail?.customerGender ?? ""),
          const Divider(),
          _infoItem(AppLocalizations.text(LangKey.provinceCity),
              "${widget.detail?.province ?? ""}",
              icon: Assets.iconProvince),
          const Divider(),
          _infoItem(AppLocalizations.text(LangKey.district),
              "${widget.detail?.district ?? ""}",
              icon: Assets.iconDistrict),
          const Divider(),
          // _infoItem(AppLocalizations.text(LangKey.wards),
          //     "${widget.detail?.wardType ?? ""} ${widget.detail?.wardName ?? ""}",
          //     icon: Assets.iconWards),
          // const Divider(),
          _infoItem(AppLocalizations.text(LangKey.address),
              widget.detail?.address ?? "",
              icon: Assets.iconAddress),
          const Divider(),
          _infoItem(AppLocalizations.text(LangKey.businessFocalPoint),
              widget.detail?.staffName ?? "",
              icon: Assets.iconPoint),
          // const Divider(),
          // _infoItem(
          //     AppLocalizations.text(LangKey.zalo), widget.detail?. ?? "",
          //     icon: Assets.iconSource, icon2: Assets.iconZalo),
        ],
      ),
    );
  }

  Widget generalInfomationV2() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(left: 11, right: 11, bottom: 120),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(width: 1, color: Color(0xFFC3C8D3))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        margin:
                            EdgeInsets.only(left: 7.5, top: 8.0, bottom: 6.0),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10.0),
                              height: 15.0,
                              width: 15.0,
                              child: Image.asset(Assets.iconStyleCustomer),
                            ),
                            Container(
                              height: 30,
                              width: MediaQuery.of(context).size.width / 1.8,
                              padding: EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(0, 1),
                                    blurRadius: 2,
                                    color: Colors.black.withOpacity(0.3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(widget.detail?.customerName ?? "",
                                      style: TextStyle(
                                          fontSize: AppTextSizes.size15,
                                          color: AppColors.black,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(width: 3.0),
                                  Text(" " + "(Cá nhân)",
                                      style:
                                          TextStyle(color: Color(0xFF858080)))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        right: 15,
                        bottom: -6,
                        child: Image.asset(
                          Assets.iconZalo,
                          scale: 3.0,
                        )),

                    // Positioned(
                    //     right: 20,
                    //     bottom: 0,
                    //     child: Image.asset(
                    //       Assets.iconMessenger,
                    //       scale: 3.0,
                    //     ))
                  ],
                ),
                _infoItemV2(Assets.iconCall, widget.detail?.phone ?? ""),
                SizedBox(height: 5.0),
                _infoItemV2(Assets.iconSex, "Nam"),
                SizedBox(height: 5.0),
                _infoItemV2(Assets.iconEmail, "Kqcustoms@gmail.com"),
                SizedBox(height: 5.0),
                _infoItemV2(Assets.iconAddress,
                    "73 Trần Huy Liệu, Phường 12, Quận Phú Nhuận, TP.HCM "),
                SizedBox(height: 5.0),
                _infoItemV2(Assets.iconWards, "Đầu mối doanh nghiệp")
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                  height: 45.0,
                  width: 45.0,
                  child: Image.asset(Assets.iconMessenger),
                ),
              ),
              InkWell(
                onTap: () {},
                child: Container(
                  margin: const EdgeInsets.only(left: 8.0, right: 8.0),
                  height: 57.0,
                  width: 57.0,
                  child: Image.asset(Assets.iconZalo),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _infoItemV2(String icon, String title) {
    return Container(
      padding: const EdgeInsets.only(bottom: 8.0),
      margin: EdgeInsets.only(left: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            height: 15.0,
            width: 15.0,
            child: Image.asset(icon),
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal),
              // maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget customerCare() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [customerCareItem(), customerCareItem(), customerCareItem()],
      ),
    );
  }

  // Widget customerCareHistory() {
  //   return Container(
  //     margin: EdgeInsets.only(bottom: 20.0),
  //     child: Column(
  //       children: [customerCareItem(), customerCareItem(), customerCareItem()],
  //     ),
  //   );
  // }

  Widget customerCareItem() {
    return InkWell(
      onTap: () async {},
      child: Container(
        child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          // height: 300,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                child: SizedBox(
                  //Cái này là bên trái
                  width: MediaQuery.of(context).size.width / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        '09:45',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '22,\ntháng 12,\nnăm 2022',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                //Cai này là bên phải
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                    left: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Cái này là dòng tiêu đề
                      Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text:
                                      '[012345678] Tên công việc này dài quá trời dài',
                                  style: TextStyle(
                                    color: Color(0xFF0067AC),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: ' ',
                                    ),
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.check_circle_outline_sharp,
                                      color: Colors.green,
                                      size: 16,
                                    )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      InkWell(
                        child: Container(
                          height: 30,
                          width: 100,
                          margin: EdgeInsets.only(top: 10.0),
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ], color: Colors.white),
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.iconCall,
                                scale: 3.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                AppLocalizations.text(LangKey.call),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                                // maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "15",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconFiles,
                                  scale: 3.0,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "12",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconComment,
                                  scale: 3.0,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "12",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconTimeDetail,
                                  scale: 3.0,
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            CustomAvatarWithURL(
                              name: "NV.Trixie Miami",
                              size: 50.0,
                            ),
                            Container(
                              width: 10.0,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NV.Trixie Miami",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),

                      Container(
                        child: Wrap(
                          children: List.generate(5, (index) => _tagItem()),
                          spacing: 10,
                          runSpacing: 10,
                        ),
                      )

                      //cái này là button gọi điện
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tagItem() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 2,
          color: Colors.black.withOpacity(0.3),
        )
      ], color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.iconTag,
            scale: 3.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            "Tag1",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w500),
            // maxLines: 1,
          )
        ],
      ),
    );
  }

  Widget orderHistory() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          orderHistoryItem(),
          orderHistoryItem(),
          orderHistoryItem(),
        ],
      ),
    );
  }

  Widget orderHistoryItem() {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              color: Colors.black.withOpacity(0.3),
            )
          ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: CustomInfoItem(
                      icon: Assets.iconDeal, title: "DH_140720222900")),
              Container(
                height: 24,
                // width: 55,
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                // margin: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                    color: Color(0xFF11B482),
                    borderRadius: BorderRadius.circular(50.0)),
                child: Center(
                  child: Text("Đã thanh toán",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
          CustomInfoItem(icon: Assets.iconTime, title: "15:00 14 tháng 7,2022"),
          CustomInfoItem(icon: Assets.iconBranch, title: "Chi nhánh 1"),
          CustomInfoItem(icon: Assets.iconShipper, title: "Giao hàng - 2022-12-24 13:30"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: CustomInfoItem(icon: Assets.iconDeal, title: "1 sản phẩm")),
              Row(
                children: [
                  Image.asset(Assets.iconTag,scale: 2.5,),
                  SizedBox(width: 10.0,),
                  Text("35.000 VND",style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  // Widget customerCareInfoItem(String title) {
  //   return Container(
  //       padding: EdgeInsets.all(8.0),
  //       margin: EdgeInsets.only(bottom: 5.0),
  //       decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(5),
  //           border: Border.all(width: 1, color: Color(0xFFC3C8D3))),
  //       child: Row(
  //         children: [
  //           Expanded(
  //               child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: [
  //               Text(title,
  //                   style: TextStyle(
  //                       color: AppColors.primaryColor,
  //                       fontSize: 14.0,
  //                       fontWeight: FontWeight.bold)),
  //               SizedBox(height: 8.0),
  //               RichText(
  //                   text: TextSpan(
  //                       text: "Loại công việc: ",
  //                       style: TextStyle(
  //                           fontSize: 14.0,
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.bold),
  //                       children: [
  //                     TextSpan(
  //                         text: "Gọi điện",
  //                         style: TextStyle(
  //                             color: Colors.black,
  //                             fontSize: 14.0,
  //                             fontWeight: FontWeight.normal))
  //                   ])),
  //               SizedBox(height: 8.0),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.start,
  //                 children: [
  //                   // Container(
  //                   //   height: 16,
  //                   //   width: 16,
  //                   //   margin: EdgeInsets.only(right: 5.0),
  //                   //   decoration: BoxDecoration(
  //                   //       borderRadius: BorderRadius.circular(1000.0),
  //                   //       color: Colors.orange),
  //                   // ),

  //                   _buildAvatarWithImage(
  //                       "https://i.ex-cdn.com/mgn.vn/files/content/2022/11/10/sofm-101-1240.jpg"),

  //                   SizedBox(width: 5.0),

  //                   Text(
  //                     "NV.Trixie Miami",
  //                     style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 14.0,
  //                         fontWeight: FontWeight.w600),
  //                   )
  //                 ],
  //               )
  //             ],
  //           )),
  //           Container(
  //             padding: EdgeInsets.only(left: 6.0, right: 6.0),
  //             height: 24,
  //             decoration: BoxDecoration(
  //                 color: Color(0xFF068229),
  //                 borderRadius: BorderRadius.circular(525.0)),
  //             child: Center(
  //               child: Text("Đã hoàn thành",
  //                   style: TextStyle(
  //                       color: Colors.white,
  //                       fontSize: 14.0,
  //                       fontWeight: FontWeight.w600)),
  //             ),
  //           )
  //         ],
  //       ));
  // }

// avatar
  Widget _buildAvatarWithImage(String image) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10000.0),
      child: FittedBox(
        child: Container(
          width: 16.0,
          height: 16.0,
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blueGrey,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(1), BlendMode.dstATop),
                  image: NetworkImage(image))),
        ),
        fit: BoxFit.fill,
      ),
    );
  }

// thông tin chi tiết
  Widget detailInformation() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8),
          //   child: Text(
          //     AppLocalizations.text(LangKey.picture),
          //     style: TextStyle(
          //         fontSize: AppTextSizes.size15,
          //         color: const Color(0xFF858080),
          //         fontWeight: FontWeight.normal),
          //   ),
          // ),
          Divider(),

          _infoDetailItem(
            AppLocalizations.text(LangKey.allottedPerson),
            widget.detail?.staffName ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.product),
            widget.detail?.productNameBuy ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.expectedEndingDate),
            widget.detail?.closingDate ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.actualEndDate),
            widget.detail?.closingDueDate ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.reasonForFailure),
            widget.detail?.reasonLoseCode ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.agency),
            widget.detail?.branchName ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.orderSource),
            widget.detail?.orderSourceName ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.probability),
            widget.detail?.probability != ""
                ? NumberFormat.currency(
                      locale: 'en_US',
                      decimalDigits: 1,
                      symbol: '',
                    ).format(num.parse(widget.detail?.probability ?? "0")) +
                    "%"
                : "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.dealDetail),
            widget.detail?.dealDescription ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.dateCreated),
            widget.detail?.createdAt ?? "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.lastModifiedDate),
            widget.detail?.updatedAt ?? "",
          ),
          Divider(),
        ],
      ),
    );
  }

  Widget _infoItem(String title, String content,
      {TextStyle style, String icon, String icon2}) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 1.9,
            child: Row(
              children: [
                if (icon != null)
                  Container(
                    margin: const EdgeInsets.only(right: 8.0),
                    height: 15.0,
                    width: 15.0,
                    child: Image.asset(icon),
                  ),
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    title,
                    style: AppTextStyles.style15BlackNormal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Text(
            content,
            style: style ?? AppTextStyles.style15BlackNormal,
            // maxLines: 1,
          )),
          if (icon2 != null)
            Container(
              margin: const EdgeInsets.only(left: 8.0, right: 8.0),
              height: 30.0,
              width: 30.0,
              child: Image.asset(icon2),
            ),
        ],
      ),
    );
  }

  Widget _infoDetailItem(String title, String content, {TextStyle style}) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 1.9,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    title,
                    style: AppTextStyles.style15BlackNormal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Text(
            content,
            style: style ?? AppTextStyles.style15BlackNormal,
            // maxLines: 1,
          )),
        ],
      ),
    );
  }

  Widget dealDeveloping() {
    return Container(
      margin: EdgeInsets.only(top: 50.0, bottom: 100.0),
      child: Column(
        children: [
          SizedBox(
            height: 204,
            width: 295,
            child: Image.asset(Assets.imgFeatureDeveloping),
          ),
          Center(
              child: Text(
            AppLocalizations.text(LangKey.featureDeveloping),
            style: AppTextStyles.style18BlueBold,
            maxLines: 1,
          ))
        ],
      ),
    );
  }

  Widget sexInfo(String sex) {
    return Container(
      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 2,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 4.0),
                  height: 20.0,
                  width: 20.0,
                  child: Image.asset(Assets.iconSex),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: Text(
                    AppLocalizations.text(LangKey.sex),
                    style: AppTextStyles.style15BlackNormal,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          sex != ""
              ? Container(
                  height: 40,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: AppColors.darkGrey,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      sex != "other"
                          ? Container(
                              margin: const EdgeInsets.only(
                                right: 4.0,
                              ),
                              height: 20.0,
                              width: 20.0,
                              child: sex == "male"
                                  ? Image.asset(Assets.iconMale)
                                  : Image.asset(Assets.iconFemale),
                            )
                          : Container(),
                      Text(
                        sex == "other"
                            ? AppLocalizations.text(LangKey.other)
                            : sex == "male"
                                ? AppLocalizations.text(LangKey.male)
                                : AppLocalizations.text(LangKey.female),
                        style: AppTextStyles.style15BlackNormal,
                        maxLines: 1,
                      )
                    ],
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget _buildAvatarImg(String name) {
    return Container(
      width: 65.0,
      height: 65.0,
      padding: const EdgeInsets.all(2.0),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.lightGrey,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000.0),
        child: CustomAvatar(
          name: name,
          textSize: AppTextSizes.size22,
        ),
      ),
    );
  }

  selectedTab(int index) async {
    List<DetailPotentialTabModel> models = tabDeal;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;

    setState(() {});
  }
}
