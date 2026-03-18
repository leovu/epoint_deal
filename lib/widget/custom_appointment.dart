// part of widget;

// class CustomAppointment extends StatelessWidget {
//   final BookingListModel? model;
//   final GestureTapCallback? onTap;
//   final bool showDate;

//   const CustomAppointment(
//       {this.model, Key? key, this.onTap, this.showDate = false})
//       : super(key: key);

//   final double _avatarSize = 18.0;

//   Widget _buildContainer(Widget child) {
//     return Container(
//       padding: EdgeInsets.all(AppSizes.minPadding),
//       decoration: BoxDecoration(
//           border: Border.all(color: AppColors.borderColor),
//           borderRadius: BorderRadius.circular(5.0)),
//       child: child,
//     );
//   }

//   Widget _buildSkeleton() {
//     return _buildContainer(CustomShimmer(
//       child: CustomListView(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         children: [
//           Row(
//             children: [
//               Expanded(child: CustomSkeleton()),
//               SizedBox(
//                 width: AppSizes.maxPadding,
//               ),
//               CustomSkeleton(
//                 width: 70.0,
//               )
//             ],
//           ),
//           CustomSkeleton(),
//           Row(
//             children: [
//               Expanded(
//                   child: Row(
//                 children: [
//                   CustomSkeleton(
//                     width: _avatarSize,
//                     height: _avatarSize,
//                     radius: _avatarSize,
//                   ),
//                   SizedBox(
//                     width: AppSizes.minPadding / 2,
//                   ),
//                   Expanded(
//                     child: CustomSkeleton(),
//                   ),
//                 ],
//               )),
//               SizedBox(
//                 width: AppSizes.minPadding,
//               ),
//               CustomSkeleton(
//                 width: _avatarSize,
//                 height: _avatarSize,
//                 radius: _avatarSize,
//               ),
//               SizedBox(
//                 width: AppSizes.minPadding / 2,
//               ),
//               CustomSkeleton(
//                 width: 100.0,
//               )
//             ],
//           )
//         ],
//       ),
//     ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (model == null) {
//       return _buildSkeleton();
//     }

//     return InkWell(
//       child: _buildContainer(CustomListView(
//         shrinkWrap: true,
//         physics: NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.zero,
//         children: [
//           Row(
//             children: [
//               Expanded(
//                   child: Text(
//                 model!.customerAppointmentCode ?? "",
//                 style: AppTextStyles.style14PrimaryBold,
//               )),
//               SizedBox(
//                 width: AppSizes.minPadding,
//               ),
//               CustomChip(
//                 text: model!.statusName,
//                 style: AppTextStyles.style12WhiteBold,
//                 backgroundColor: model!.colorPrimary,
//               )
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(
//                   child: Text.rich(TextSpan(
//                       text: (model!.customerTypeName ?? "").isEmpty
//                           ? ""
//                           : "${model!.customerTypeName} - ",
//                       style: AppTextStyles.style14BlackNormal,
//                       children: [
//                     TextSpan(
//                       text: model!.customerName ?? "",
//                       style: AppTextStyles.style14BlackBold,
//                     )
//                   ]))),
//               SizedBox(
//                 width: AppSizes.minPadding,
//               ),
//               Text(
//                 showDate
//                     ? parseAndFormatDate(model!.date, parse: AppFormat.formatDateCreate)
//                     : (model!.time ?? ""),
//                 style: AppTextStyles.style14BlackBold,
//               )
//             ],
//           ),
//           Row(
//             children: [
//               Expanded(child: Text(
//                 hidePhone(model!.phone,
//                     checkVisibilityKey(VisibilityWidgetName.CM000004)),
//                 style: AppTextStyles.style14BlackNormal,
//               )),
//               if(showDate)
//                 ...[
//                   SizedBox(
//                     width: AppSizes.minPadding,
//                   ),
//                   Text(
//                     model!.time ?? "",
//                     style: AppTextStyles.style14BlackBold,
//                   )
//                 ]
//             ],
//           ),
//           if ((model!.description ?? "").isNotEmpty)
//             Text(
//               model!.description!,
//               style: AppTextStyles.style14HintNormalItalic,
//             ),
//           if((model!.appointmentDetail?.length ?? 0) > 0)
//             ...[
//               CustomLine(),
//               Text(
//                 "[${model!.appointmentDetail!.first.objectCode ?? ""}] ${model!.appointmentDetail!.first.serviceName ?? ""}",
//                 style: AppTextStyles.style14BlackNormal,
//               ),
//               Row(
//                 children: [
//                   Expanded(child: Wrap(
//                     alignment: WrapAlignment.start,
//                     spacing: AppSizes.minPadding / 2,
//                     runSpacing: AppSizes.minPadding / 2,
//                     crossAxisAlignment: WrapCrossAlignment.center,
//                     children: [
//                       if(model!.appointmentDetail!.first.staffName != null)
//                         CustomAvatar(
//                           url: model!.appointmentDetail!.first.staffAvatar,
//                           name: model!.appointmentDetail!.first.staffName,
//                           size: 26,
//                         ),
//                       if(model!.appointmentDetail!.first.roomName != null)
//                         CustomChip(
//                           text: model!.appointmentDetail!.first.roomName,
//                           style: AppTextStyles.style14WhiteNormal,
//                         )
//                     ],
//                   )),
//                   SizedBox(width: AppSizes.minPadding,),
//                   Text(
//                     formatMoney(model!.appointmentDetail!.first.price),
//                     style: AppTextStyles.style14BlackNormal,
//                   )
//                 ],
//               ),
//               CustomLine()
//             ],
//           Row(
//             children: [
//               Expanded(child: CustomRowWithoutTitleInformation(
//                   icon: Assets.iconMoney,
//                   text: formatMoney(model!.total),
//                    textStyle: AppTextStyles.style14BlackBold,
//               )),
//               if((model!.appointmentDetail?.length ?? 0) > 1)
//                 ...[
//                   SizedBox(width: AppSizes.minPadding,),
//                   Text.rich(
//                     TextSpan(
//                         text: AppLocalizations.text(LangKey.and)!.toLowerCase(),
//                         style: AppTextStyles.style13HintNormal,
//                         children: [
//                           TextSpan(
//                               text: " ${model!.appointmentDetail!.length - 1} ",
//                               style: AppTextStyles.style14PrimaryBold),
//                           TextSpan(
//                             text: AppLocalizations.text(
//                                 LangKey.other_services)!
//                                 .toLowerCase(),
//                             style: AppTextStyles.style13HintNormal,
//                           )
//                         ]),
//                   )
//                 ]
//             ],
//           )
//         ],
//       )),
//       onTap: onTap,
//     );
//   }
// }
