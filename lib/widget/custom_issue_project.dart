// import 'package:epoints_task_manager_mobile/common/assets.dart';
// import 'package:epoints_task_manager_mobile/common/lang_key.dart';
// import 'package:epoints_task_manager_mobile/common/localization/app_localizations.dart';
// import 'package:epoints_task_manager_mobile/common/theme.dart';
// import 'package:epoints_task_manager_mobile/data/models/response/project_list_issue_response_model.dart';
// import 'package:epoints_task_manager_mobile/presentation/utils/ultility.dart';
// import 'package:epoints_task_manager_mobile/presentation/widgets/widget.dart';
// import 'package:flutter/material.dart';
// import 'package:readmore/readmore.dart';

// class CustomIssueProject extends StatelessWidget {
//   final ProjectListIssueModel? model;
//   final bool isOverview;
//   final GestureTapCallback? onTapAddJob;
//   final GestureTapCallback? onTap;
//   final GestureTapCallback? onDelete;
//   final GestureTapCallback? onExchange;
//   final GestureTapCallback? onEdited;

//   CustomIssueProject(this.model, this.isOverview,
//       {this.onTapAddJob, this.onTap, this.onDelete, this.onExchange, this.onEdited});

//   @override
//   Widget build(BuildContext context) {
//     return model == null
//         ? CustomShimmer(
//             child: CustomSkeleton(
//               width: MediaQuery.of(context).size.width / 2,
//             ),
//           )
//         : InkWell(
//             onTap: onTap,
//             child: Container(
//               constraints: BoxConstraints(
//                   maxHeight: AppSizes.maxHeight/ 5,
//                   maxWidth: AppSizes.maxWidth/ 1.1),
//               decoration: BoxDecoration(
//                   color: AppColors.whiteColor,
//                   boxShadow: [
//                     BoxShadow(
//                         offset: Offset(0.0, 0.0),
//                         blurRadius: 1.0,
//                         color: AppColors.blackColor.withOpacity(0.2))
//                   ],
//                   borderRadius: BorderRadius.circular(10.0)),
//               padding: EdgeInsets.all(AppSizes.minPadding),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Expanded(
//                       child: Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CustomAvatar(
//                         size: AppSizes.sizeOnTap/ 2,
//                         url: model!.staffAvatar,
//                         name: model!.staffName,
//                       ),
//                       Container(
//                         width: AppSizes.minPadding,
//                       ),
//                       Expanded(
//                           child: Column(
//                         children: [
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Expanded(
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(
//                                             model!.staffName!,
//                                             style:
//                                                 AppTextStyles.style16BlackBold,
//                                           ),
//                                           Text(
//                                             parseAndFormatDate(model!.createdAt,
//                                                 format:
//                                                     AppFormat.formatDateTime),
//                                             style: AppTextStyles
//                                                 .style12HintNormalItalic,
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     model!.statusName != '' ? Row(
//                                       children: [
//                                         CustomTagIndicator(
//                                           padding: EdgeInsets.all(
//                                               AppSizes.minPadding/ 2),
//                                           name: model!.statusName ?? "",
//                                           backgroundColor: AppColors.green300.withOpacity(0.2),
//                                           indicatorColor: AppColors.green300,
//                                           style: AppTextStyles.style12WhiteBold
//                                               .copyWith(
//                                                   color: AppColors.green300),
//                                         ),
//                                         SizedBox(
//                                           width: AppSizes.minPadding,
//                                         ),
//                                         isOverview
//                                             ? Container()
//                                             : Row(
//                                               children: [
//                                                 InkWell(
//                                                     onTap: onEdited,
//                                                     child: Icon(
//                                                       Icons.edit_note,
//                                                       color: AppColors.primaryColor,
//                                                     )),
//                                                 SizedBox(
//                                                   width: AppSizes.minPadding,
//                                                 ),
//                                                 InkWell(
//                                                     onTap: onDelete,
//                                                     child: Icon(
//                                                       Icons.delete,
//                                                       color: AppColors.red500,
//                                                     )),


//                                               ],
//                                             )
//                                       ],
//                                     ) : Container(),
//                                   ],
//                                 ),
//                                 Expanded(
//                                   child: SingleChildScrollView(
//                                     scrollDirection: Axis.vertical,
//                                     child: Padding(
//                                       padding: EdgeInsets.symmetric(
//                                           vertical: AppSizes.minPadding),
//                                       child: ReadMoreText(
//                                         model!.content ?? "",
//                                         trimLines: 4,
//                                         style: AppTextStyles.style15BlackNormal,
//                                         colorClickableText: AppColors
//                                             .functionFrequentlyAskedQuestions,
//                                         trimMode: TrimMode.Line,
//                                         textAlign: TextAlign.start,
//                                         textDirection: TextDirection.ltr,
//                                         trimCollapsedText:
//                                             '${AppLocalizations.text(LangKey.seeMore)}',
//                                         trimExpandedText: AppLocalizations.text(
//                                             LangKey.see_less)!,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: AppSizes.minPadding/ 2,
//                           ),
//                         ],
//                       ))
//                     ],
//                   )),
//                   !isOverview
//                       ? Row(
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             InkWell(
//                                 onTap: onTapAddJob,
//                                 child: CustomButtonIconText(
//                                   icon: Assets.iconPlus,
//                                   iconColor: AppColors.whiteColor,
//                                   size: AppSizes.iconSize/ 2,
//                                   text: AppLocalizations.text(LangKey.add_work),
//                                   style: AppTextStyles.style12BlackBold
//                                       .copyWith(color: AppColors.whiteColor),
//                                   backgroundColor: AppColors
//                                       .functionFrequentlyAskedQuestions,
//                                 )),
//                             SizedBox(
//                               width: AppSizes.minPadding/ 2,
//                             ),
//                             model!.parentId != null ? Container() :InkWell(
//                                 onTap: onExchange,
//                                 child: CustomButtonIconText(
//                                   icon: Assets.iconChat,
//                                   iconColor: AppColors.whiteColor,
//                                   size: AppSizes.iconSize/ 2,
//                                   text: AppLocalizations.text(LangKey.exchange),
//                                   style: AppTextStyles.style12BlackBold
//                                       .copyWith(color: AppColors.whiteColor),
//                                   backgroundColor: AppColors
//                                       .functionFrequentlyAskedQuestions,
//                                 )),
//                             (model!.status != null && model!.status!.compareTo('success') == 0)
//                                 ? Row(
//                                     children: [
//                                       SizedBox(
//                                         width: AppSizes.minPadding/ 2,
//                                       ),
//                                       CustomButtonIconText(
//                                         icon: Assets.iconCheck,
//                                         size: AppSizes.iconSize/ 2,
//                                         iconColor: AppColors.whiteColor,
//                                         text: AppLocalizations.text(
//                                             LangKey.processed),
//                                         style: AppTextStyles.style12BlackBold
//                                             .copyWith(
//                                                 color: AppColors.whiteColor),
//                                         backgroundColor: AppColors.green300,
//                                       ),
//                                     ],
//                                   )
//                                 : Container(),
//                           ],
//                         )
//                       : Container()
//                 ],
//               ),
//             ));
//   }
// }
