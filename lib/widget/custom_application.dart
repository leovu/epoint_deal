// part of widget;

// class CustomApplication extends StatelessWidget {

//   final TimeoffdaysSearchModel? model;
//   final bool isPersonal;
//   final Function? onDelete;
//   final Function(String)? onDecline;
//   final Function? onAccept;
//   final Function(TimeoffdaysSearchModel)? onRefresh;

//   const CustomApplication({
//     Key? key,
//     this.model,
//     this.isPersonal = true,
//     this.onDelete,
//     this.onDecline,
//     this.onAccept,
//     this.onRefresh,
//   }) : super(key: key);

//   final double _iconSize = 20.0;

//   _accept(BuildContext context){
//     CustomNavigator.showCustomAlertDialog(
//         context,
//         AppLocalizations.text(LangKey.notification),
//         AppLocalizations.text(LangKey.accept_application_confirm),
//       enableCancel: true,
//       textSubmitted: AppLocalizations.text(LangKey.accept),
//       onSubmitted: () {
//           CustomNavigator.pop(context);
//           onAccept!();
//       }
//     );
//   }

//   _decline(BuildContext context){
//     FocusNode focusNode = FocusNode();
//     TextEditingController controller = TextEditingController();
//     CustomNavigator.showCustomAlertDialog(
//         context,
//         AppLocalizations.text(LangKey.notification),
//         null,
//         enableCancel: true,
//         child: CustomTextField(
//           focusNode: focusNode,
//           controller: controller,
//           backgroundColor: Colors.transparent,
//           borderColor: AppColors.borderColor,
//           hintText: AppLocalizations.text(LangKey.enter_decline_reason),
//           maxLines: 4,
//           maxLength: 191,
//           textInputAction: TextInputAction.newline,
//           keyboardType: TextInputType.multiline,
//         ),
//         textSubmitted: AppLocalizations.text(LangKey.decline),
//         onSubmitted: () {
//           CustomNavigator.showCustomAlertDialog(
//               context,
//               AppLocalizations.text(LangKey.notification),
//               AppLocalizations.text(LangKey.decline_application_confirm),
//               enableCancel: true,
//               textSubmitted: AppLocalizations.text(LangKey.decline),
//               onSubmitted: () {
//                 CustomNavigator.pop(context);
//                 onDecline!(controller.text);
//               }
//           );
//         }
//     );
//   }

//   Widget _buildRow(IconData icon, String? title, {String? content, Widget? child, bool isTitle = false}){
//     return Row(
//       children: [
//         Icon(
//           icon,
//           color: AppColors.primaryColor,
//           size: _iconSize,
//         ),
//         SizedBox(width: AppSizes.minPadding,),
//         Text(
//           title ?? "",
//           style: isTitle
//               ? AppTextStyles.style15PrimaryBold
//               : AppTextStyles.style14BlackBold,
//         ),
//         SizedBox(width: AppSizes.minPadding,),
//         Expanded(
//           child: child ?? Text(
//             content ?? "",
//             style: AppTextStyles.style14BlackNormal,
//             textAlign: TextAlign.right,
//             maxLines: 1,
//             overflow: TextOverflow.ellipsis,
//           ),
//         )
//       ],
//     );
//   }

//   Widget _buildSkeleton(){
//     return CustomContainerList(
//       child: CustomShimmer(
//         child: CustomListView(
//           padding: EdgeInsets.all(AppSizes.minPadding),
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           separator:  Column(
//             children: [
//               SizedBox(height: AppSizes.minPadding,),
//               CustomLine(),
//               SizedBox(height: AppSizes.minPadding,),
//             ],
//           ),
//           children: List.generate(4, (index) => Row(
//             children: [
//               CustomSkeleton(
//                 width: _iconSize,
//                 height: _iconSize,
//               ),
//               SizedBox(width: AppSizes.minPadding,),
//               CustomSkeleton(width: AppSizes.maxWidth* 0.2,),
//               SizedBox(width: AppSizes.minPadding,),
//               Expanded(child: CustomSkeleton(),)
//             ],
//           )).toList(),
//         ),
//       )
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(model == null){
//       return _buildSkeleton();
//     }

//     List<Widget> staffs = [];

//     if((model!.staff?.length ?? 0) != 0){
//       for(var e in model!.staff!){
//         staffs.addAll([
//           CustomApproveAvatar(
//             size: 20.0,
//             url: e.staffAvatar,
//             name: e.fullName,
//             isApproved: e.isApprovce,
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 1.0),
//             child: CustomImageIcon(
//               icon: Assets.iconNextArrow,
//               size: 10.0,
//             ),
//           ),
//         ]);
//       }

//       staffs.removeLast();
//     }

//     bool showDelete = model!.isApprovce == null && isPersonal && onDelete != null;

//     return CustomContainerList(child: Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             left: AppSizes.minPadding,
//             right: showDelete ? 0.0 : AppSizes.minPadding,
//             top: AppSizes.minPadding,
//             bottom: AppSizes.minPadding,
//           ),
//           child: Row(
//             children: [
//               Icon(
//                 Icons.bookmark,
//                 color: AppColors.primaryColor,
//                 size: _iconSize,
//               ),
//               SizedBox(width: AppSizes.minPadding,),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       model!.timeOffTypeName ?? "",
//                       style: AppTextStyles.style15PrimaryBold,
//                     ),
//                     SizedBox(height: AppSizes.minPadding/ 2,),
//                     Text(
//                       parseAndFormatDate(model!.createdAt, format: AppFormat.formatDateTime),
//                       style: AppTextStyles.style14HintNormal,
//                     )
//                   ],
//                 ),
//               ),
//               if(showDelete)
//                 InkWell(
//                   borderRadius: BorderRadius.circular(100.0),
//                   child: Padding(
//                     padding: EdgeInsets.all(AppSizes.minPadding),
//                     child: Icon(
//                       Icons.highlight_remove,
//                       size: 20.0,
//                       color: AppColors.red500,
//                     ),
//                   ),
//                   onTap: () {
//                     CustomNavigator.showCustomAlertDialog(
//                         context,
//                         AppLocalizations.text(LangKey.notification),
//                         AppLocalizations.text(LangKey.delete_application_confirm),
//                         enableCancel: true,
//                         textSubmitted: AppLocalizations.text(LangKey.delete),
//                         onSubmitted: () {
//                           CustomNavigator.pop(context);
//                           onDelete!();
//                         }
//                     );
//                   },
//                 ),
//             ],
//           ),
//         ),
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: AppSizes.minPadding),
//           child: CustomLine(),
//         ),
//         CustomListView(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           padding: EdgeInsets.all(AppSizes.minPadding),
//           separator: Column(
//             children: [
//               SizedBox(height: AppSizes.minPadding,),
//               CustomLine(),
//               SizedBox(height: AppSizes.minPadding,),
//             ],
//           ),
//           children: [
//             _buildRow(
//                 Icons.calendar_today,
//                 AppLocalizations.text(LangKey.day),
//                 content: parseApplicationTime(model!.timeOffDaysStart, model!.timeOffDaysEnd, model!.timeOffDaysTimeText)
//             ),
//             if(!isPersonal)
//               Row(
//                 children: [
//                   CustomAvatar(
//                     url: model!.staffAvatar,
//                     name: model!.fullName,
//                     size: AppSizes.sizeOnTap,
//                   ),
//                   SizedBox(width: AppSizes.minPadding,),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           model!.fullName ?? "",
//                           style: AppTextStyles.style14BlackBold,
//                         ),
//                         SizedBox(height: AppSizes.minPadding/ 2,),
//                         Text(
//                           model!.departmentName ?? "",
//                           style: AppTextStyles.style13BlackNormal,
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             Column(
//               children: [
//                 _buildRow(
//                     Icons.check_circle_outline,
//                     AppLocalizations.text(LangKey.status),
//                     child: Row(
//                       children: [
//                         CustomChip(
//                           text: parseApplicationStatus(model!.isApprovce),
//                           style: AppTextStyles.style12WhiteBold,
//                           backgroundColor: parseApplicationStatusColor(model!.isApprovce),
//                         ),
//                         Expanded(
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: staffs,
//                           ),
//                         )
//                       ],
//                     )
//                 ),
//               ],
//             ),
//             _buildRow(
//                 Icons.playlist_add_check,
//                 AppLocalizations.text(LangKey.reason),
//                 content: model!.timeOffNote
//             ),
//             if(!isPersonal && model!.isUpdate == 1)
//               Row(
//                 children: [
//                   if(onDecline != null)
//                     Expanded(
//                       child: CustomButton(
//                         text: AppLocalizations.text(LangKey.notApprove),
//                         style: AppTextStyles.style14WhiteBold,
//                         backgroundColor: AppColors.red500,
//                         onTap: () => _decline(context),
//                       ),
//                     ),
//                   SizedBox(width: AppSizes.minPadding,),
//                   if(onAccept != null)
//                     Expanded(
//                       child: CustomButton(
//                         text: AppLocalizations.text(LangKey.approve1),
//                         style: AppTextStyles.style14WhiteBold,
//                         backgroundColor: AppColors.green300,
//                         onTap: () => _accept(context),
//                       ),
//                     ),
//                 ],
//               )
//           ],
//         )
//       ],
//     ), onTap: () async {
//       CustomNavigator.push(context, ApplicationDetailScreen(
//           model!.timeOffDaysId,
//           isPersonal,
//           (event){
//             if(onRefresh != null){
//               onRefresh!(event);
//             }
//           }
//       ));
//     });
//   }
// }
