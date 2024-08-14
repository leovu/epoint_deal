// part of widget;

// class CustomTimekeeping extends StatelessWidget {

//   final TimekeepingShiftResponseModel? model;
//   final GestureTapCallback? onCheckIn;
//   final GestureTapCallback? onCheckOut;

//   CustomTimekeeping({this.model, this.onCheckIn, this.onCheckOut});

//   Widget _buildRow(String? title, String? content){
//     if(title == null){
//       return Row(
//         children: [
//           CustomSkeleton(width: AppSizes.maxWidth/ 4,),
//           Container(width: AppSizes.minPadding,),
//           Expanded(child: CustomSkeleton(),)
//         ],
//       );
//     }
//     return RichText(
//       text: TextSpan(
//           text: title,
//           style: AppTextStyles.style15BlackBold,
//           children: [
//             TextSpan(
//                 text: content,
//                 style: AppTextStyles.style15BlackNormal
//             )
//           ]
//       ),
//     );
//   }

//   Widget _buildContainer(List<Widget> children){
//     return CustomListView(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: EdgeInsets.all(AppSizes.minPadding ?? 0.0),
//       children: children,
//     );
//   }

//   Widget _buildButton({Widget? child, Color? backgroundColor, GestureTapCallback? onTap}){
//     return CustomButton(
//       child: child,
//       backgroundColor: backgroundColor,
//       height: AppSizes.sizeOnTapCheckIn,
//       onTap: onTap,
//     );
//   }

//   Widget _buildText(String text){
//     return Center(
//       child: Text(
//         text,
//         style: AppTextStyles.style15WhiteBold,
//         textAlign: TextAlign.center,
//       ),
//     );
//   }

//   Widget _buildColumn(String? title, String? content){
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           title ?? "",
//           style: AppTextStyles.style13HintNormal,
//         ),
//         Container(height: AppSizes.minPadding/ 2,),
//         Text(
//           content ?? "",
//           style: AppTextStyles.style16BlackBold,)
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(model == null){
//       return CustomShimmer(
//         child: _buildContainer([
//           Center(
//             child: CustomSkeleton(width: AppSizes.maxWidth/ 3,),
//           ),
//           _buildRow(null, null),
//           _buildRow(null, null),
//         ]),
//       );
//     }

//     return ListView(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       children: [
//         Row(
//           children: [
//             Container(width: AppSizes.maxPadding* 2,),
//             Expanded(
//               child: Text(
//                 model!.branchName ?? "",
//                 style: AppTextStyles.style15PrimaryBold,
//                 textAlign: TextAlign.center,
//               ),
//             ),
//             InkWell(
//               child: Padding(
//                 padding: EdgeInsets.all(AppSizes.minPadding),
//                 child: CustomImageIcon(
//                   icon: Assets.iconCalendar,
//                   size: AppSizes.maxPadding,
//                 ),
//               ),
//               onTap: () => CustomNavigator.push(context, TimekeepingCalendarScreen()),
//             )
//           ],
//         ),
//         CustomListView(
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           padding: EdgeInsets.only(
//             bottom: AppSizes.minPadding,
//             right: AppSizes.minPadding,
//             left: AppSizes.minPadding,
//           ),
//           children: [
//             _buildRow(
//                 "${model!.shiftName ?? ""}: ",
//                 "${parseAndFormatDate(model!.workingDay, parse: AppFormat.formatDateCreate)} ${model!.workingTime} - ${model!.workingDay == model!.workingEndDay ? "" : "${parseAndFormatDate(model!.workingEndDay, parse: AppFormat.formatDateCreate)} "}${model!.workingEndTime}"
//             ),
//             if(Globals.model!.checkInLimit == 0 || Globals.model!.isCheckinWifi == 1)
//               _buildRow(
//                   "${AppLocalizations.text(LangKey.network_information)}: ",
//                   model!.wifiName ?? AppLocalizations.text(LangKey.unknown)
//               ),
//             model!.isCheckIn != 1? _buildButton(
//               child: _buildText(AppLocalizations.text(LangKey.check_in)!,),
//               backgroundColor: AppColors.red500,
//               onTap: onCheckIn,
//             ): Row(
//               children: [
//                 Expanded(
//                   child: _buildButton(
//                     child: _buildColumn(
//                         AppLocalizations.text(LangKey.checked_in),
//                         model!.checkInTime,
//                     ),
//                     backgroundColor: model!.numberLateTime == 0
//                         ? AppColors.checkInSoon
//                         : AppColors.checkInLate,
//                   ),
//                 ),
//                 Container(width: AppSizes.minPadding,),
//                 Expanded(
//                   child: model!.isCheckOut != 1? _buildButton(
//                     child: _buildText(AppLocalizations.text(LangKey.check_out)!,),
//                     backgroundColor: AppColors.red500,
//                     onTap: onCheckOut,
//                   ): _buildButton(
//                     child: _buildColumn(
//                         AppLocalizations.text(LangKey.checked_out),
//                         model!.checkOutTime,
//                     ),
//                     backgroundColor: model!.numberTimeBackSoon == 0
//                         ? AppColors.checkInSoon
//                         : AppColors.checkInLate,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         )
//       ],
//     );
//   }
// }

// class CustomTimekeepingLog extends StatelessWidget {

//   final TimekeepingLogsModel? model;
//   final bool isPersonal;

//   const CustomTimekeepingLog({this.model, this.isPersonal = true});

//   Widget _buildTime(String? title, String? content){
//     return Flexible(
//       child: RichText(
//         text: TextSpan(
//             text: title ?? "",
//             style: AppTextStyles.style15BlackNormal,
//             children: [
//               TextSpan(
//                 text: " (${content ?? "--:--"})",
//                 style: AppTextStyles.style13BlackBold,
//               ),
//             ]
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: HexColor(model!.backGround ?? "#FFFFFF"),
//         borderRadius: BorderRadius.circular(5.0),
//         border: model!.isOt == 1 ? Border.all(
//           color: AppColors.red500
//         ) : null
//       ),
//       padding: EdgeInsets.all(AppSizes.minPadding),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if(!isPersonal)
//             ...[
//               CustomAvatar(
//                 url: model!.staffAvatar,
//                 name: model!.fullName,
//                 size: AppSizes.sizeOnTap,
//               ),
//               Container(width: AppSizes.minPadding,),
//             ],
//           Expanded(child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               if(!isPersonal)
//                 ...[
//                   Text(
//                     model!.fullName ?? "",
//                     style: AppTextStyles.style17BlackBold,
//                   ),
//                   Container(height: AppSizes.minPadding/ 2,),
//                 ],
//               Text(
//                 model!.shiftName ?? "",
//                 style: AppTextStyles.style15BlackBold,
//               ),
//               Container(height: AppSizes.minPadding/ 2,),
//               Text(
//                 "${parseAndFormatDate(model!.workingDay, parse: AppFormat.formatDateCreate)} ${model!.workingTime} - ${model!.workingDay == model!.workingEndDay ? "" : "${parseAndFormatDate(model!.workingEndDay, parse: AppFormat.formatDateCreate)} "}${model!.workingEndTime}",
//                 style: AppTextStyles.style13BlackNormal,
//               ),
//               Container(height: AppSizes.minPadding/ 2,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildTime(AppLocalizations.text(LangKey.in_shift), model!.checkInTime),
//                   Container(width: AppSizes.minPadding,),
//                   _buildTime(AppLocalizations.text(LangKey.out_shift), model!.checkOutTime),
//                 ],
//               ),
//             ],
//           )),
//         ],
//       ),
//     );
//   }
// }
