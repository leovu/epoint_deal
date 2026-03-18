// part of widget;

// class ContainerTicket extends StatelessWidget {
//   final TicketMyTicketResponseModel? model;
//   final Function(TicketMyTicketModel, TicketListStatusModel)? onStatus;
//   final Function? onLoadMore;
//   final CustomRefreshCallback? onRefresh;

//   const ContainerTicket(
//       {Key? key, this.model, this.onStatus, this.onLoadMore, this.onRefresh})
//       : super(key: key);

//   Widget _buildEmpty() {
//     return CustomEmpty(
//       title: AppLocalizations.text(LangKey.data_empty),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ContainerDataBuilder(
//       data: model?.data,
//       emptyBuilder: _buildEmpty(),
//       skeletonBuilder: CustomListView(
//         children: List.generate(4, (index) => CustomTicket()),
//       ),
//       bodyBuilder: () => CustomListView(
//         children: model!.data!
//             .map((e) => CustomTicket(
//                   model: e,
//                   onStatus:
//                       onStatus == null ? null : (event) => onStatus!(e, event),
//                 ))
//             .toList(),
//         showLoadmore: model!.pageModel?.enableLoadmore,
//         onLoadmore: onLoadMore,
//       ),
//       onRefresh: onRefresh,
//     );
//   }
// }

// class CustomTicket extends StatelessWidget {
//   final TicketMyTicketModel? model;
//   final Function(TicketListStatusModel)? onStatus;

//   CustomTicket({this.model, this.onStatus});

//   _showStatus(BuildContext context) {
//     if (onStatus == null) {
//       return;
//     }

//     if (model!.editTicket != 1) {
//       CustomNavigator.showCustomAlertDialog(
//         context,
//         AppLocalizations.text(LangKey.notification),
//         AppLocalizations.text(LangKey.cannot_edit),
//       );
//       return;
//     }

//     List<CustomBottomOptionModel> options =
//         (model!.listStatus ?? <TicketListStatusModel>[])
//             .map((e) => CustomBottomOptionModel(
//                 text: e.statusName,
//                 isSelected: model!.ticketStatusId == e.ticketStatusId,
//                 textColor: parseStatusColor(e.ticketStatusId),
//                 onTap: () async {
//                   String content =
//                       "${AppLocalizations.text(LangKey.confirm_status_update)}: ${e.statusName ?? ""}";

//                   CustomNavigator.showCustomAlertDialog(context,
//                       AppLocalizations.text(LangKey.notification), content,
//                       textSubmitted: AppLocalizations.text(LangKey.update),
//                       enableCancel: true, onSubmitted: () {
//                     CustomNavigator.pop(context);
//                     onStatus!(e);
//                   });
//                 }))
//             .toList();

//     CustomNavigator.showCustomBottomDialog(
//         context,
//         CustomBottomSheet(
//           title: AppLocalizations.text(LangKey.status),
//           body: CustomBottomOption(
//             options: options,
//           ),
//         ));
//   }

//   Widget _buildContainer(Widget child) {
//     return Container(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(10.0),
//           border: Border.all(color: AppColors.borderColor)),
//       child: child,
//     );
//   }

//   Widget _buildSkeleton() {
//     return CustomListView(
//       padding: EdgeInsets.all(AppSizes.minPadding),
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: List.generate(10, (index) => CustomRowInformation()),
//     );
//   }

//   Widget _buildRow(
//       {String? icon,
//       String? title,
//       String? content,
//       TextStyle? contentStyle,
//       Widget? child}) {
//     return CustomRowInformation(
//       icon: icon,
//       title: title,
//       alignment: CrossAxisAlignment.start,
//       content: content,
//       child: child,
//       contentStyle: contentStyle,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (model == null) {
//       return _buildContainer(_buildSkeleton());
//     }
//     return InkWell(
//       child: Container(
//         decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10.0),
//             border: Border.all(color: AppColors.borderColor)),
//         child: CustomListView(
//           padding: EdgeInsets.all(AppSizes.minPadding),
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                     child: _buildRow(
//                   icon: Assets.iconTagFill,
//                   title: "",
//                   content: model!.ticketCode,
//                   contentStyle: AppTextStyles.style14PrimaryBold,
//                 )),
//                 if (model!.ticketAlertId != null)
//                   Padding(
//                     padding: EdgeInsets.only(left: AppSizes.minPadding),
//                     child: CustomTicketAlert(
//                       id: model!.ticketAlertId,
//                     ),
//                   ),
//                 SizedBox(
//                   width: AppSizes.minPadding,
//                 ),
//                 CustomChip(
//                   text: model!.statusName,
//                   backgroundColor: parseStatusColor(model!.ticketStatusId),
//                   style: AppTextStyles.style14WhiteBold,
//                   onTap: () => _showStatus(context),
//                 )
//               ],
//             ),
//             _buildRow(
//               icon: Assets.iconTitleFill,
//               title: AppLocalizations.text(LangKey.title),
//               content: model!.title,
//             ),
//             _buildRow(
//               icon: Assets.iconUser,
//               title: AppLocalizations.text(LangKey.customer),
//               content: model!.customerName,
//             ),
//             _buildRow(
//               icon: Assets.iconAlertCircleFill,
//               title: AppLocalizations.text(LangKey.request),
//               content: model!.issueName,
//             ),
//             _buildRow(
//               icon: Assets.iconClockFill,
//               title: AppLocalizations.text(LangKey.time_of_birth),
//               content: parseAndFormatDate(model!.dateIssue,
//                   format: AppFormat.formatDateTime),
//             ),
//             _buildRow(
//               icon: Assets.iconClockFill,
//               title: AppLocalizations.text(LangKey.compulsory_completion_time),
//               content: parseAndFormatDate(model!.dateExpected,
//                   format: AppFormat.formatDateTime),
//             ),
//             _buildRow(
//                 icon: Assets.iconUserGroup,
//                 title: AppLocalizations.text(LangKey.handling_staff),
//                 child: CustomTicketStaffHandler(
//                   models: model!.staffHandler,
//                   isDetail: false,
//                 )
//             ),
//           ],
//         ),
//       ),
//       onTap: () => CustomNavigator.push(
//           context, TicketDetailsScreen(model!.ticketId, model!.ticketCode)),
//     );
//   }
// }

// class CustomTicketAlert extends StatelessWidget {
//   final int? id;

//   const CustomTicketAlert({Key? key, this.id}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Image.asset(
//       id == 1
//           ? Assets.imageTicketWarning1
//           : id == 2
//               ? Assets.imageTicketWarning2
//               : Assets.imageTicketWarning3,
//       width: AppSizes.iconSize,
//     );
//   }
// }

// class CustomTicketStaffHandler extends StatelessWidget {
//   final List<StaffHandler>? models;
//   final bool isDetail;

//   const CustomTicketStaffHandler({Key? key, this.models, this.isDetail = true})
//       : super(key: key);

//   Widget _buildEmptyData() {
//     return Text(
//       AppLocalizations.text(LangKey.unallocated_staff)!,
//       style: AppTextStyles.style14HintNormalItalic,
//       textAlign: isDetail ? TextAlign.left : TextAlign.right,
//     );
//   }

//   Widget _buildStaff(){
//     String text = models![0].userName ?? "";
//     if (models!.length > 1) {
//       text += ", ${models![1].userName ?? ""}";
//     }
//     if (models!.length > 2) {
//       text += " ${AppLocalizations.text(LangKey.and)!.toLowerCase()} ${models!.length - 2} ${AppLocalizations.text(LangKey.others)!.toLowerCase()}";
//     }
//     return Text(
//       text,
//       style: AppTextStyles.style14BlackNormal,
//       textAlign: isDetail ? TextAlign.left : TextAlign.right,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return (models?.length ?? 0) == 0
//         ? _buildEmptyData()
//         : InkWell(
//             child: _buildStaff(),
//             onTap: models!.length > 2
//                 ? () {
//                     CustomNavigator.push(
//                         context,
//                         ListStaffScreen(
//                           models!
//                               .map((e) => WorkListStaffModel(
//                                   staffAvatar: e.staffAvatar,
//                                   staffName: e.userName))
//                               .toList(),
//                           title: AppLocalizations.text(LangKey.handling_staff),
//                         ));
//                   }
//                 : null,
//           );
//   }
// }
