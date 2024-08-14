// part of widget;

// final double _imageHeight = AppSizes.maxWidth* 0.35;

// Widget _buildRow(String title, String? content, {TextStyle? titleStyle, TextStyle? contentStyle}){
//   return RichText(
//     text: TextSpan(
//         text: title,
//         style: titleStyle ?? AppTextStyles.style14HintNormal,
//         children: [
//           TextSpan(
//               text: content ?? "",
//               style: contentStyle ?? AppTextStyles.style14BlackNormal
//           )
//         ]
//     ),
//   );
// }

// Widget _buildHeader(String? url, int? point){
//   return ClipRRect(
//     borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
//     child: Stack(
//       children: [
//         CustomNetworkImage(
//           width: double.infinity,
//           height: _imageHeight,
//           url: url,
//         ),
//         if((point ?? 0) > 0)
//           Positioned(
//             top: 0.0,
//             left: AppSizes.maxPadding,
//             child: Container(
//               decoration: BoxDecoration(
//                   image: DecorationImage(
//                       image: AssetImage(
//                         Assets.iconSurveyReward,
//                       ),
//                       fit: BoxFit.contain
//                   )
//               ),
//               padding: EdgeInsets.symmetric(
//                   vertical: AppSizes.maxPadding,
//                   horizontal: AppSizes.minPadding),
//               child: Column(
//                 children: [
//                   Image.asset(
//                     Assets.imageSurveyStar,
//                     width: 16.0,
//                   ),
//                   Text(
//                     "+$point",
//                     style: AppTextStyles.style14BlackBold,
//                   )
//                 ],
//               ),
//             ),
//           )
//       ],
//     ),
//   );
// }

// Widget _buildSkeleton(){
//   return CustomContainerList(child: CustomShimmer(
//     child: Column(
//       children: [
//         CustomSkeleton(
//           height: _imageHeight,
//           borderRadius: BorderRadius.vertical(top: Radius.circular(4.0)),
//         ),
//         CustomListView(
//           shrinkWrap: true,
//           physics: NeverScrollableScrollPhysics(),
//           children: [
//             Row(
//               children: [
//                 CustomSkeleton(width: AppSizes.maxWidth/ 2,),
//               ],
//             ),
//             CustomSkeleton(),
//           ],
//         )
//       ],
//     ),
//   ));
// }

// class CustomSurvey extends StatelessWidget {

//   final SurveyListMissionModel? model;
//   final GestureTapCallback? onTap;
//   final GestureTapCallback? onContinue;

//   const CustomSurvey({Key? key, this.model, this.onContinue,this.onTap}) : super(key: key);

//   final double countPointSize = 32.0;
//   final Color countPointColor = AppColors.orange300;

//   Widget _buildContent(){
//     Color color;
//     if(model!.surveyStatus == surveyStatusOpen){
//       color = AppColors.cyan;
//     }
//     else{
//       color = AppColors.orange300;
//     }
//     return CustomListView(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: [
//         Row(
//           children: [
//             CustomDot(color: color,),
//             Container(width: AppSizes.minPadding,),
//             Expanded(child: Text(
//               model!.surveyStatusName ?? "",
//               style: AppTextStyles.style14PrimaryRegular.copyWith(
//                 color: color
//               ),
//             ),)
//           ],
//         ),
//         Text(
//           model!.surveyName ?? "",
//           style: AppTextStyles.style16BlackBold,
//         ),
//         _buildRow(
//             "${AppLocalizations.text(LangKey.time_takes_place)}: ",
//             (model!.startDate ?? "").isNotEmpty && (model!.endDate ?? "").isNotEmpty
//                 ? "${parseAndFormatDate(model!.startDate, parse: AppFormat.formatDateCreate)} - ${parseAndFormatDate(model!.endDate, parse: AppFormat.formatDateCreate)}"
//                 : AppLocalizations.text(LangKey.no_limit)
//         ),
//         _buildRow(
//             "${AppLocalizations.text(LangKey.made)}: ",
//             (model!.maxTimes ?? 0) > 0
//                 ? "${model!.numCompletedTimes ?? 0}/${model!.maxTimes}"
//                 : (model!.numCompletedTimes ?? 0).toString()
//         ),
//         if(model!.countPoint == surveyPointTypePoint)
//           Row(
//             children: [
//               Container(
//                 width: countPointSize,
//                 height: countPointSize,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: AppColors.orange300.withOpacity(0.2)
//                 ),
//                 alignment: Alignment.center,
//                 child: Image.asset(
//                   Assets.iconSurveyPoint,
//                   width: AppSizes.iconSize,
//                 ),
//               ),
//               SizedBox(width: AppSizes.minPadding,),
//               Expanded(
//                 child: Text(
//                   AppLocalizations.text(LangKey.scoring_survey)!,
//                   style: AppTextStyles.style14BlackBold,
//                 ),
//               )
//             ],
//           ),
//       ],
//     );
//   }

//   Widget _buildFooter(){
//     return Column(
//       children: [
//         Row(
//           children: [
//             Container(width: AppSizes.maxPadding,),
//             Icon(
//               Icons.check_circle_outline,
//               color: AppColors.primaryColor,
//               size: 16.0,
//             ),
//             Container(width: AppSizes.minPadding,),
//             Expanded(
//               child: _buildRow(
//                   (model!.numQuestionsCompleted ?? 0).toString(),
//                   "/${model!.totalQuestions ?? 0} ${AppLocalizations.text(LangKey.question)}",
//                   titleStyle: AppTextStyles.style14PrimaryBold,
//                   contentStyle: AppTextStyles.style14HintNormal
//               ),
//             ),
//             InkWell(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(
//                   vertical: AppSizes.minPadding,
//                   horizontal: AppSizes.maxPadding,
//                 ),
//                 child: Text(
//                   AppLocalizations.text(LangKey.continueString)!,
//                   style: AppTextStyles.style14PrimaryBold,
//                 ),
//               ),
//               onTap: onContinue,
//             )
//           ],
//         ),
//         CustomSurveyProgress(model!.totalQuestions ?? 0, model!.numQuestionsCompleted ?? 0)
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(model == null){
//       return _buildSkeleton();
//     }

//     return InkWell(
//       child: CustomContainerList(child: Column(
//         children: [
//           _buildHeader(model!.surveyBanner, model!.accumulationPoint),
//           _buildContent(),
//           if(model!.isInProcess == 1)
//             _buildFooter(),
//         ],
//       )),
//       onTap: onTap,
//     );
//   }
// }

// class CustomSurveyHistory extends StatelessWidget {

//   final SurveyListHistoryModel? model;
//   final GestureTapCallback? onTap;

//   const CustomSurveyHistory({Key? key, this.model, this.onTap}) : super(key: key);

//   Widget _buildContent(){
//     return CustomListView(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: [
//         Text(
//           model!.surveyName ?? "",
//           style: AppTextStyles.style16BlackBold,
//         ),
//         Row(
//           children: [
//             Icon(
//               Icons.check_circle_outline,
//               color: AppColors.blackColor,
//               size: 16.0,
//             ),
//             Container(width: AppSizes.minPadding,),
//             Expanded(
//               child: _buildRow(
//                   "${AppLocalizations.text(LangKey.made_on)}: ",
//                   parseAndFormatDate(model!.finishedAt, format: AppFormat.formatDateTime),
//               ),
//             ),
//           ],
//         ),
//         if(model!.totalPoint != null)
//           _buildRow(
//               "${AppLocalizations.text(LangKey.total_score)}: ",
//               model!.totalPoint,
//               titleStyle: AppTextStyles.style14BlackBold,
//               contentStyle: AppTextStyles.style14DarkRedBold
//           )
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(model == null){
//       return _buildSkeleton();
//     }

//     return InkWell(
//       child: CustomContainerList(child: Column(
//         children: [
//           _buildHeader(model!.surveyBanner, model!.accumulationPoint),
//           _buildContent(),
//         ],
//       )),
//       onTap: onTap,
//     );
//   }
// }