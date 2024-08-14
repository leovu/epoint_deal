// part of widget;

// class ContainerWarranty extends StatelessWidget {

//   final WarrantyCardResponseModel? model;
//   final Function? onLoadmore;
//   final Function? onRefresh;
//   final Function(WarrantyCardModel)? onChangeStatus;
//   final Function(WarrantyCardModel)? onTap;

//   const ContainerWarranty({this.model, this.onLoadmore, this.onRefresh, this.onChangeStatus, this.onTap, Key? key}) : super(key: key);

//   Widget _buildContainer(List<Widget> children, {Function? onLoadmore, bool? showLoadmore}){
//     return CustomListView(
//       children: children,
//       onLoadmore: onLoadmore,
//       showLoadmore: showLoadmore,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(model == null){
//       return _buildContainer(List.generate(1, (index) => CustomWarranty()).toList());
//     }

//     return _buildContainer(
//         List.generate(model!.items!.length, (index) => CustomWarranty(
//             model: model!.items![index],
//             onRefresh: onRefresh,
//             onChangeStatus: onChangeStatus == null ? null : () => onChangeStatus!(model!.items![index]),
//             onTap: onTap == null ? null : () => onTap!(model!.items![index])
//         )).toList(),
//         onLoadmore: onLoadmore,
//         showLoadmore: model!.pageInfo?.enableLoadmore
//     );
//   }
// }

// class CustomWarranty extends StatelessWidget {

//   final WarrantyCardModel? model;
//   final Function? onRefresh;
//   final GestureTapCallback? onChangeStatus;
//   final GestureTapCallback? onTap;

//   const CustomWarranty({this.model, this.onRefresh, this.onChangeStatus, this.onTap, Key? key}) : super(key: key);

//   Widget _buildContainer(List<Widget> children){
//     return CustomListView(
//       padding: EdgeInsets.all(AppSizes.minPadding),
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       children: children,
//     );
//   }

//   Widget _buildSkeleton(){
//     return CustomContainerList(
//       child: CustomShimmer(
//         child: _buildContainer(List.generate(5, (index) => CustomRowWithoutTitleInformation()).toList()),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(model == null){
//       return _buildSkeleton();
//     }
//     return InkWell(
//       child: CustomContainerList(
//         child: _buildContainer([
//           Row(
//             children: [
//               Expanded(
//                 child: CustomRowWithoutTitleInformation(
//                   icon: Assets.iconBarcode,
//                   text: model!.warrantyCardCode ?? "",
//                   textStyle: AppTextStyles.style14PrimaryBold,
//                 ),
//               ),
//               if(model!.status != null)
//                 CustomChip(
//                   text: model!.statusName,
//                   backgroundColor: model!.color,
//                   style: AppTextStyles.style14WhiteBold,
//                   onTap: onChangeStatus,
//                 )
//             ],
//           ),
//           CustomRowWithoutTitleInformation(
//               icon: Assets.iconProtect,
//               text: model!.objectName ?? ""
//           ),
//           CustomRowWithoutTitleInformation(
//               icon: Assets.iconFillProtect,
//               text: (model!.quota ?? 0) == 0 ? AppLocalizations.text(LangKey.unlimited) : model!.quota.toString()
//           ),
//           CustomRowWithoutTitleInformation(
//               icon: Assets.iconPerson,
//               text: model!.customerName ?? ""
//           ),
//           CustomRowWithoutTitleInformation(
//               icon: Assets.iconCalendar,
//               text: model!.dateExpiredName ?? ""
//           ),
//         ]),
//       ),
//       onTap: onTap ?? () async {
//         bool? event = await CustomNavigator.push(context, WarrantyDetailScreen(model!.warrantyCardCode));
//         if((event ?? false) && onRefresh != null){
//           onRefresh!();
//         }
//       },
//     );
//   }
// }

// class CustomWarrantySelected extends StatelessWidget {

//   final WarrantyCardModel? model;
//   final GestureTapCallback? onRemove;

//   const CustomWarrantySelected({this.model, this.onRemove, Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Expanded(
//           child: ContainerBooking(
//               CustomListView(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 children: [
//                   CustomRowWithoutTitleInformation(
//                     icon: Assets.iconLayers,
//                     text: model!.warrantyCardCode ?? "",
//                   ),
//                   CustomRowInformation(
//                     icon: Assets.iconCalendar,
//                     title: AppLocalizations.text(LangKey.expiration_date),
//                     content: model!.dateExpiredName
//                   )
//                 ],
//               )
//           )
//         ),
//         if(onRemove != null)
//           Padding(
//             padding: EdgeInsets.only(left: AppSizes.minPadding),
//             child: InkWell(
//               child: CustomImageIcon(
//                 icon: Assets.iconTrash,
//                 color: AppColors.red500,
//               ),
//               onTap: onRemove,
//             ),
//           )
//       ],
//     );
//   }
// }
