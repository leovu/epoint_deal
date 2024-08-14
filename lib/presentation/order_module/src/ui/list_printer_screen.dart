// import 'package:epoint_deal_plugin/common/lang_key.dart';
// import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
// import 'package:epoint_deal_plugin/common/localization/global.dart';
// import 'package:epoint_deal_plugin/common/theme.dart';
// import 'package:epoint_deal_plugin/model/request/print_devices_request_model.dart';
// import 'package:epoint_deal_plugin/model/response/print_devices_response_model.dart';
// import 'package:epoint_deal_plugin/presentation/order_module/src/ui/preview_print_order_screen.dart';
// import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
// import 'package:epoint_deal_plugin/widget/custom_empty.dart';
// import 'package:epoint_deal_plugin/widget/custom_line.dart';
// import 'package:epoint_deal_plugin/widget/custom_listview.dart';
// import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
// import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
// import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
// import 'package:epoint_deal_plugin/widget/widget.dart';
// import 'package:flutter/material.dart';

// import '../bloc/list_printer_bloc.dart';

// class ListPrinterScreen extends StatefulWidget {
//   final int? id;

//   final String? code;

//   ListPrinterScreen({Key? key, this.id, this.code}) : super(key: key);

//   @override
//   State<ListPrinterScreen> createState() => _ListPrinterScreenState();
// }

// class _ListPrinterScreenState extends State<ListPrinterScreen> {
//   late ListPrinterBloc _bloc;

//   @override
//   void initState() {
//     // TODO: implement initState

//     super.initState();

//     _bloc = ListPrinterBloc(context);

//     WidgetsBinding.instance.addPostFrameCallback((_) => _onRefresh(false));
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose

//     _bloc.dispose();

//     super.dispose();
//   }

//   Future _onRefresh(bool isRefresh) {
//     return _bloc.printDevices(
//         PrintDevicesRequestModel(branchId: Global.branchId), isRefresh);
//   }

//   Widget _buildContainer(List<Widget> children) {
//     return CustomListView(
//       padding: EdgeInsets.zero,
//       separatorPadding: 0.0,
//       children: children,
//     );
//   }

//   Widget _buildSkeleton() {
//     return _buildContainer(List.generate(
//         2,
//         (index) => CustomShimmer(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(AppSizes.maxPadding),
//                     child: Row(
//                       children: [
//                         CustomSkeleton(
//                           width: AppSizes.sizeOnTap,
//                           height: AppSizes.sizeOnTap,
//                           radius: AppSizes.sizeOnTap,
//                         ),
//                         Container(
//                           width: AppSizes.maxPadding,
//                         ),
//                         Expanded(
//                             child: Column(
//                           children: [
//                             CustomSkeleton(),
//                             Container(
//                               height: AppSizes.minPadding,
//                             ),
//                             CustomSkeleton(),
//                             Container(
//                               height: AppSizes.minPadding,
//                             ),
//                             CustomSkeleton(),
//                           ],
//                         ))
//                       ],
//                     ),
//                   ),
//                   CustomLine()
//                 ],
//               ),
//             )));
//   }

//   Widget _buildEmpty() {
//     return CustomEmpty(
//       title: AppLocalizations.text(LangKey.print_devices_empty),
//     );
//   }

//   Widget _buildContent(List<PrintDevicesModel> models) {
//     return _buildContainer(models
//         .map((e) => InkWell(
//               onTap: () {
//                 CustomNavigator.showCustomAlertDialog(
//                   context,

//                   AppLocalizations.text(LangKey.notification),

//                   AppLocalizations.text(LangKey.printer_type_selection),

//                   enableCancel: true,

//                   textSubmitted: AppLocalizations.text(LangKey.print),

//                   // textSubSubmitted: AppLocalizations.text(LangKey.tag_print),

//                   onSubmitted: () => CustomNavigator.push(
//                       context,
//                       PreviewPrintOrderScreen(
//                         id: widget.id,
//                         code: widget.code,
//                         model: e,
//                         type: 0,
//                       )),

//                   onSubSubmitted: () => CustomNavigator.push(
//                       context,
//                       PreviewPrintOrderScreen(
//                         id: widget.id,
//                         code: widget.code,
//                         model: e,
//                         type: 1,
//                       )),
//                 );
//               },
//               child: Column(
//                 children: [
//                   Container(
//                     padding: EdgeInsets.all(AppSizes.maxPadding),
//                     child: Row(
//                       children: [
//                         Icon(
//                           Icons.print,
//                           color: AppColors.primaryColor,
//                           size: AppSizes.sizeOnTap,
//                         ),
//                         Container(
//                           width: AppSizes.maxPadding,
//                         ),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 e.printerName ?? "",
//                                 style: AppTextStyles.style15BlackBold,
//                               ),
//                               Container(
//                                 height: 5.0,
//                               ),
//                               Text(
//                                 "IP: ${e.printerIp ?? ""}",
//                                 style: AppTextStyles.style13BlackNormal,
//                               ),
//                               Container(
//                                 height: 5.0,
//                               ),
//                               Text(
//                                 "Port: ${e.printerPort ?? ""}",
//                                 style: AppTextStyles.style13PrimaryNormal,
//                               ),
//                               if (e.isDefault == 1) ...[
//                                 Container(
//                                   height: 5.0,
//                                 ),
//                                 Text(
//                                   AppLocalizations.text(LangKey.defaultString)!,
//                                   style: AppTextStyles.style13HintNormal,
//                                 ),
//                               ]
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                   CustomLine()
//                 ],
//               ),
//             ))
//         .toList());
//   }

//   Widget _buildBody() {
//     return StreamBuilder(
//         stream: _bloc.outputModels,
//         initialData: null,
//         builder: (_, snapshot) {
//           List<PrintDevicesModel>? models =
//               snapshot.data as List<PrintDevicesModel>?;

//           return ContainerDataBuilder(
//             data: models,
//             emptyBuilder: _buildEmpty(),
//             skeletonBuilder: _buildSkeleton(),
//             bodyBuilder: () => _buildContent(models!),
//             onRefresh: () => _onRefresh(true),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       title: AppLocalizations.text(LangKey.list_printer_title),
//       body: _buildBody(),
//     );
//   }
// }
