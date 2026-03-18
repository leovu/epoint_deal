// part of widget;

// class ContainerJob extends StatelessWidget {

//   final List<WorkJobModel>? models;
//   final EdgeInsetsGeometry? padding;
//   final ScrollPhysics? physics;
//   final bool? shrinkWrap;
//   final Function(WorkJobModel, double)? onUpdated;
//   final Function(WorkJobModel, int)? onComment;
//   final Function(WorkJobModel, DateTime)? onDate;
//   final Function(WorkJobModel, WorkListStatusModel)? onStatus;
//   final Function? onRefresh;
//   final Function(WorkJobModel)? onDecline;
//   final Function(WorkJobModel)? onApprove;
//   final Function(WorkJobModel, bool)? onChanged;
//   final bool? fromParent;
//   final bool? fromTicket;
//   final Function? onLoadmore;
//   final bool? showLoadmore;

//   ContainerJob({
//     this.models,
//     this.padding,
//     this.physics,
//     this.shrinkWrap,
//     this.onUpdated,
//     this.onComment,
//     this.onDate,
//     this.onStatus,
//     this.onRefresh,
//     this.onApprove,
//     this.onDecline,
//     this.onChanged,
//     this.fromParent,
//     this.fromTicket,
//     this.onLoadmore,
//     this.showLoadmore
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomListView(
//       padding: padding??EdgeInsets.zero,
//       shrinkWrap: shrinkWrap ?? false,
//       physics: physics,
//       separator: Column(
//         children: [
//           Container(height: AppSizes.minPadding,),
//           CustomLine(size: 2.0,),
//           Container(height: AppSizes.minPadding,),
//         ],
//       ),
//       children: models == null
//           ? List.generate(4, (index) => CustomJob())
//           : models!.map((e) => CustomJob(
//         model: e,
//         fromParent: fromParent,
//         fromTicket: fromTicket,
//         onUpdated: (event) {
//           if(onUpdated != null){
//             onUpdated!(e, event);
//           }
//         },
//         onComment: (event) {
//           if(onComment != null){
//             onComment!(e, event);
//           }
//         },
//         onDate: (event) {
//           if(onDate != null){
//             onDate!(e, event);
//           }
//         },
//         onStatus: (event) {
//           if(onStatus != null){
//             onStatus!(e, event);
//           }
//         },
//         onRefresh: onRefresh,
//         onDecline: (){
//           if(onDecline != null){
//             onDecline!(e);
//           }
//         },
//         onApprove: (){
//           if(onApprove != null){
//             onApprove!(e);
//           }
//         },
//         onChanged: onChanged == null
//             ? null
//             : (event){
//           onChanged!(e, event!);
//         },
//       )).toList(),
//       showLoadmore: showLoadmore,
//       onLoadmore: onLoadmore,
//     );
//   }
// }


// class CustomJob extends StatelessWidget {

//   final Function(bool?)? onChanged;
//   final WorkJobModel? model;
//   final Function(double)? onUpdated;
//   final Function(int)? onComment;
//   final Function(DateTime)? onDate;
//   final Function(WorkListStatusModel)? onStatus;
//   final Function? onRefresh;
//   final Function? onDecline;
//   final Function? onApprove;
//   final bool? fromParent;
//   final bool? fromTicket;

//   CustomJob({
//     this.model,
//     this.onChanged,
//     this.onUpdated,
//     this.onComment,
//     this.onDate,
//     this.onStatus,
//     this.onRefresh,
//     this.onDecline,
//     this.onApprove,
//     this.fromParent,
//     this.fromTicket
//   });

//   _approve(BuildContext context){
//     CustomNavigator.showCustomAlertDialog(
//         context,
//         AppLocalizations.text(LangKey.approve),
//         AppLocalizations.text(LangKey.approve_work_confirm),
//         textSubmitted: AppLocalizations.text(LangKey.approve),
//         enableCancel: true,
//         onSubmitted: () {
//           CustomNavigator.pop(context);
//           if(onApprove != null){
//             onApprove!();
//           }
//         }
//     );
//   }

//   _decline(BuildContext context){
//     CustomNavigator.showCustomAlertDialog(
//         context,
//         AppLocalizations.text(LangKey.decline),
//         AppLocalizations.text(LangKey.decline_work_confirm),
//         textSubmitted: AppLocalizations.text(LangKey.decline),
//         enableCancel: true,
//         onSubmitted: () {
//           CustomNavigator.pop(context);
//           if(onDecline != null){
//             onDecline!();
//           }
//         }
//     );
//   }

//   _showProgress(BuildContext context) async {
//     if(onUpdated == null){
//       return;
//     }

//     if(model!.isEdit != 1 || (model!.parentId == null && (model!.totalChildJob ?? 0) > 0)){
//       CustomNavigator.showCustomAlertDialog(
//         context,
//         AppLocalizations.text(LangKey.notification),
//         AppLocalizations.text(LangKey.cannot_edit),
//       );
//       return;
//     }



//     double? event = await CustomNavigator.showCustomBottomDialog(context, ProgressScreen(id: model!.manageWorkId, value: model!.progress));
//     if(event != null){
//       onUpdated!(event);
//     }
//   }

//   _showComment(BuildContext context){
//     if(onComment == null){
//       return;
//     }
//     CustomNavigator.push(context, CustomScaffold(
//       title: AppLocalizations.text(LangKey.comment),
//       body: CommentScreen(
//         id: model!.manageWorkId,
//         onCallback: (event) {
//           onComment!(event);
//         },
//       ),
//     ));
//   }

//   _showDate(BuildContext context) async {
//     if(onDate == null){
//       return;
//     }

//     if(model!.isEdit != 1){
//       CustomNavigator.showCustomAlertDialog(
//         context,
//         AppLocalizations.text(LangKey.notification),
//         AppLocalizations.text(LangKey.cannot_edit),
//       );
//       return;
//     }

//     DateTime now = DateTime.now();
//     DateTime current = parseDate(model!.dateEnd) ?? now;

//     if(current.millisecondsSinceEpoch < now.millisecondsSinceEpoch){
//       current = now;
//     }

//     final date = await showDatePicker(
//       context: context,
//       initialDate: current,
//       firstDate: now,
//       lastDate: now.add(Duration(days: 365)),
//       locale: LocalizationsConfig.getCurrentLocale(),
//     );

//     if(date != null){
//       DatePicker.showTimePicker(
//           context,
//           locale: Globals.localeType,
//           showSecondsColumn: false,
//           currentTime: current,
//           onConfirm: (event) {
//             onDate!(DateTime(date.year, date.month, date.day, event.hour, event.minute));
//           }
//       );
//     }
//   }

//   _showStatus(BuildContext context){
//     if(onStatus == null){
//       return;
//     }

//     if(model!.isEdit != 1){
//       CustomNavigator.showCustomAlertDialog(
//         context,
//         AppLocalizations.text(LangKey.notification),
//         AppLocalizations.text(LangKey.cannot_edit),
//       );
//       return;
//     }

//     List<CustomBottomOptionModel> options = (model!.listStatus ?? <WorkListStatusModel>[]).map((e) => CustomBottomOptionModel(
//         text: e.manageStatusName,
//         isSelected: model!.manageStatusId == e.manageStatusId,
//         onTap: (){
//           if(!e.isCancel!){
//             CustomNavigator.pop(context);
//             onStatus!(e);
//             return;
//           }

//           String content = "${AppLocalizations.text(LangKey.are_you_sure_you_want_to)} ${e.manageStatusName} ${AppLocalizations.text(LangKey.this_task)!.toLowerCase()}?";
//           if(model!.parentId == null){
//             if((model!.totalChildJob ?? 0) > 0){
//               content = "${AppLocalizations.text(LangKey.this_task_has_the_number_of_subtasks_of)} ${model!.totalChildJob}\n$content";
//             }
//           }

//           CustomNavigator.showCustomAlertDialog(
//               context,
//               AppLocalizations.text(LangKey.notification),
//               content,
//               textSubmitted: e.manageStatusName,
//               enableCancel: true,
//               onSubmitted: () {
//                 CustomNavigator.pop(context);
//                 CustomNavigator.pop(context);
//                 onStatus!(e);
//               }
//           );
//         }
//     )).toList();

//     CustomNavigator.showCustomBottomDialog(context, CustomBottomSheet(
//       title: AppLocalizations.text(LangKey.status),
//       body: CustomBottomOption(
//         options: options,
//       ),
//     ));
//   }

//   _showAvatars(BuildContext context){
//     CustomNavigator.showCustomBottomDialog(context, CustomBottomSheet(
//       title: AppLocalizations.text(LangKey.supporter),
//       body: CustomListView(
//           padding: EdgeInsets.zero,
//           shrinkWrap: true,
//           separator: CustomLine(),
//           children: model!.listStaff!.map((e) => Container(
//             padding: EdgeInsets.symmetric(
//                 horizontal: AppSizes.maxPadding,
//                 vertical: AppSizes.minPadding),
//             child: Row(
//               children: [
//                 CustomAvatar(
//                   url: e.staffAvatar,
//                   name: e.staffName,
//                   size: AppSizes.sizeOnTap,
//                 ),
//                 Container(width: AppSizes.minPadding,),
//                 Expanded(child: Text(
//                   e.staffName ?? "",
//                   style: AppTextStyles.style15BlackNormal,
//                 ))
//               ],
//             ),
//           )).toList()
//       ),
//     ));
//   }

//   Widget _buildSkeleton(){
//     return CustomShimmer(
//       child: CustomListView(
//         physics: NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: AppSizes.maxPadding),
//         shrinkWrap: true,
//         children: [
//           CustomSkeleton(),
//           Container(
//             alignment: Alignment.centerLeft,
//             child: CustomSkeleton(width: AppSizes.maxWidth/ 3,),
//           ),
//           Row(
//             children: [
//               Expanded(child: CustomSkeleton(),),
//               Container(width: AppSizes.maxPadding,),
//               Expanded(child: CustomSkeleton(),),
//               Container(width: AppSizes.maxPadding,),
//               Expanded(child: CustomSkeleton(),),
//             ],
//           )
//         ],
//       ),
//     );
//   }

//   Widget _buildRow(String icon, String text, {GestureTapCallback? onTap, bool isBetween = false}){
//     return InkWell(
//       child: Container(
//         padding: EdgeInsets.symmetric(vertical: AppSizes.minPadding),
//         child: Row(
//           mainAxisAlignment: isBetween?MainAxisAlignment.center:MainAxisAlignment.start,
//           children: [
//             CustomImageIcon(
//               icon: icon,
//               size: 13.0,
//               color: AppColors.blackColor,
//             ),
//             Container(width: 5.0,),
//             Flexible(child: AutoSizeText(
//               text,
//               style: AppTextStyles.style13BlackNormal,
//               minFontSize: 4.0,
//               maxLines: 1,
//               overflow: TextOverflow.ellipsis,
//             ))
//           ],
//         ),
//       ),
//       onTap: onTap,
//     );
//   }

//   Widget _buildTag(WorkJobTagsModel model){
//     return CustomTag(name: model.manageTagName, icon: model.manageTagIcon,);
//   }

//   Widget _buildLine(){
//     return Container(
//       height: 25,
//       child: CustomLine(
//         isVertical: false,
//         size: 2,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(model == null){
//       return _buildSkeleton();
//     }
//     return InkWell(
//       child: CustomListView(
//         physics: NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: AppSizes.maxPadding),
//         shrinkWrap: true,
//         separatorPadding: 0.0,
//         children: [
//           if((model!.textOverdue ?? "").isNotEmpty)
//             Container(
//               padding: EdgeInsets.only(bottom: AppSizes.minPadding),
//               child: Container(
//                 padding: EdgeInsets.symmetric(
//                     horizontal: AppSizes.minPadding,
//                     vertical: AppSizes.minPadding/ 2
//                 ),
//                 color: AppColors.red100,
//                 child: Row(
//                   children: [
//                     CustomImageIcon(
//                       icon: Assets.iconClock,
//                       size: 13,
//                       color: AppColors.blackColor,
//                     ),
//                     Container(width: 5.0,),
//                     Expanded(
//                       child: Text(
//                         model!.textOverdue!,
//                         style: AppTextStyles.style12BlackNormal,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           Container(
//             padding: EdgeInsets.only(left: AppSizes.maxPadding),
//             decoration: BoxDecoration(
//                 border: Border(
//                     left: BorderSide(
//                         color: parsePriorityJobColor(model!.priority),
//                         width: 2
//                     )
//                 )
//             ),
//             child: Row(
//               children: [
//                 Expanded(child: CustomListView(
//                   shrinkWrap: true,
//                   padding: EdgeInsets.zero,
//                   physics: NeverScrollableScrollPhysics(),
//                   separatorPadding: 5.0,
//                   children: [
//                     Text(
//                       model!.manageWorkTitle ?? "",
//                       style: AppTextStyles.style15BlackBold,
//                     ),
//                     if((model!.processorName ?? "") != "")
//                       Row(
//                         children: [
//                           CustomAvatar(
//                             url: model!.processorAvatar,
//                             name: model!.processorName,
//                             size: 30.0,
//                           ),
//                           Container(width: AppSizes.minPadding/ 2,),
//                           Expanded(
//                             child: Text(
//                               model!.processorName!,
//                               style: AppTextStyles.style14BlackNormal,
//                             ),
//                           )
//                         ],
//                       ),
//                     if((model!.manageProjectName ?? "") != "")
//                       Text(
//                         model!.manageProjectName!,
//                         style: AppTextStyles.style13HintNormal,
//                       ),
//                     if((model!.tags?.length ?? 0) != 0)
//                       Wrap(
//                         spacing: 5.0,
//                         runSpacing: 5.0,
//                         children: model!.tags!.map((e) => _buildTag(e)).toList(),
//                       ),
//                     if((model!.listStaff?.length ?? 0) != 0)
//                       InkWell(
//                         child: Row(
//                           children: [
//                             Text(
//                               "${AppLocalizations.text(LangKey.supporter)}: ",
//                               style: AppTextStyles.style12BlackNormal.copyWith(
//                                 fontStyle: FontStyle.italic,
//                               ),
//                             ),
//                             Expanded(
//                               child: CustomAvatars(models: model!.listStaff!.map((e) => e).toList(),),
//                             )
//                           ],
//                         ),
//                         onTap: () => _showAvatars(context),
//                       )
//                   ],
//                 )),
//                 InkWell(
//                   child: Container(
//                     width: AppSizes.sizeOnTap,
//                     height: AppSizes.sizeOnTap,
//                     child: Stack(
//                       fit: StackFit.expand,
//                       children: [
//                         CircularProgressIndicator(
//                           value: (model!.progress ?? 0) / 100,
//                           backgroundColor: AppColors.orange200,
//                           color: AppColors.orange500,
//                           strokeWidth: 2,
//                         ),
//                         Container(
//                           padding: EdgeInsets.all(4.0),
//                           alignment: Alignment.center,
//                           child: Text(
//                             "${(model!.progress ?? 0).toInt()}%",
//                             style: AppTextStyles.style12BlackNormal,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   onTap: () => _showProgress(context),
//                 ),
//                 onChanged == null?Container():Checkbox(
//                     value: model!.isSelected ?? false,
//                     onChanged: onChanged
//                 )
//               ],
//             ),
//           ),
//           Container(height: AppSizes.minPadding,),
//           CustomLine(),
//           Row(
//             children: [
//               Expanded(child: _buildRow(
//                   Assets.iconClock,
//                   parseAndFormatDate(model!.dateEnd, format: AppFormat.formatDateTime),
//                   onTap: () => _showDate(context)
//               )),
//               Container(width: AppSizes.minPadding/ 2,),
//               _buildLine(),
//               Expanded(child: _buildRow(
//                   Assets.iconChat,
//                   (model!.totalMessage ?? 0).toString(),
//                   onTap: () => _showComment(context),
//                   isBetween: true
//               ),),
//               _buildLine(),
//               Container(width: AppSizes.minPadding,),
//               Expanded(
//                 child: model!.isApprove == 1? Row(
//                   children: [
//                     Expanded(
//                       child: CustomChip(
//                         icons: Icons.close,
//                         backgroundColor: AppColors.darkRedColor,
//                         onTap: () => _decline(context),
//                       ),
//                     ),
//                     Container(width: 5.0,),
//                     Expanded(
//                       child: CustomChip(
//                         icons: Icons.check,
//                         onTap: () => _approve(context),
//                       ),
//                     ),
//                   ],
//                 ): CustomChip(
//                   text: model!.manageStatusName ?? "",
//                   backgroundColor: HexColor(model!.manageStatusColor),
//                   style: AppTextStyles.style12WhiteNormal,
//                   isExpand: true,
//                   onTap: () => _showStatus(context),
//                 ),
//               )
//             ],
//           )
//         ],
//       ),
//       onTap: () async {
//         await CustomNavigator.push(context, JobScreen(
//           model!.manageWorkId,
//           fromParent: fromParent,
//           fromTicket: fromTicket
//         ));
//         if(onRefresh != null){
//           onRefresh!();
//         }
//       },
//     );
//   }
// }

// class ContainerRemind extends StatelessWidget {
//   final List<WorkListRemindModel>? models;
//   final bool? showDelete;
//   final Function(WorkListRemindModel)? onDelete;
//   final Function(WorkListRemindModel)? onTap;
//   const ContainerRemind({
//     this.models,
//     this.onDelete,
//     this.onTap,
//     this.showDelete,
//     Key? key
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return CustomListView(
//       padding: EdgeInsets.symmetric(
//           horizontal: AppSizes.maxPadding,
//           vertical: AppSizes.minPadding),
//       separator: Column(
//         children: [
//           SizedBox(height: AppSizes.minPadding,),
//           CustomLine(),
//           SizedBox(height: AppSizes.minPadding,),
//         ],
//       ),
//       children: models == null
//           ? List.generate(4, (index) => CustomRemind())
//           : models!.map((e) => CustomRemind(
//         model: e,
//         onDelete: () {
//           if(onDelete != null){
//             onDelete!(e);
//           }
//         },
//         onTap: onTap == null? null: (){
//           onTap!(e);
//         },
//         showDelete: showDelete,
//       )).toList(),
//     );
//   }
// }


// class CustomRemind extends StatelessWidget {

//   final WorkListRemindModel? model;
//   final GestureTapCallback? onDelete;
//   final GestureTapCallback? onTap;
//   final bool? showDelete;

//   CustomRemind({this.model, this.onDelete, this.onTap, this.showDelete});

//   @override
//   Widget build(BuildContext context) {
//     final double? avatarSize = AppSizes.sizeOnTap;

//     if(model == null){
//       return CustomShimmer(
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomSkeleton(
//               width: avatarSize,
//               height: avatarSize,
//               radius: avatarSize,
//             ),
//             Container(width: AppSizes.minPadding,),
//             Expanded(child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomSkeleton(width: AppSizes.maxWidth/ 3,),
//                 Container(height: AppSizes.minPadding,),
//                 CustomSkeleton()
//               ],
//             )),
//             Container(width: AppSizes.minPadding,),
//             CustomSkeleton(width: AppSizes.maxWidth* 0.2,)
//           ],
//         ),
//       );
//     }

//     return InkWell(
//       child: Row(
//         crossAxisAlignment: (model!.title ?? "").isNotEmpty
//             ? CrossAxisAlignment.start
//             : CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: EdgeInsets.only(right: AppSizes.minPadding),
//             child: CustomAvatar(
//               size: avatarSize,
//               url: model!.staffAvatar,
//               name: model!.staffName,
//             ),
//           ),
//           Expanded(child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if((model!.title ?? "").isNotEmpty)
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       model!.title ?? "",
//                       style: AppTextStyles.style13BlackBold,
//                     ),
//                     Container(height: AppSizes.minPadding/ 2,),
//                   ],
//                 ),
//               Text(
//                 model!.description ?? "",
//                 style: AppTextStyles.style15BlackNormal,
//               )
//             ],
//           )),
//           Container(width: AppSizes.minPadding,),
//           Text(
//             parseAndFormatDate(model!.dateRemind, format: AppFormat.formatRemind),
//             style: AppTextStyles.style12BlackNormal,
//           ),
//           Container(width: AppSizes.minPadding,),
//           Column(
//             children: [
//               Row(
//                 children: [
//                   Icon(
//                       Icons.check,
//                       size: 15.0,
//                       color: model!.isSent == 1?AppColors.primaryColor:AppColors.grey300Color
//                   ),
//                   if(model!.manageWorkId != null && onTap != null)
//                     Padding(
//                       padding: EdgeInsets.only(left: AppSizes.minPadding),
//                       child: Icon(
//                           Icons.navigate_next,
//                           size: 15.0,
//                           color: AppColors.blackColor
//                       ),
//                     ),
//                 ],
//               ),
//               if((showDelete ?? false))
//                 CustomCheckbox(
//                     model!.isSelected,
//                         (_) => onDelete!()
//                 )
//             ],
//           ),
//         ],
//       ),
//       onTap: (showDelete ?? false) ? onDelete : onTap,
//     );
//   }
// }
