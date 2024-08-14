// part of widget;

// class ContainerMaintenance extends StatelessWidget {

//   final MaintenanceResponseModel? model;
//   final Function? onLoadmore;
//   final Function? onRefresh;

//   const ContainerMaintenance({this.model, this.onLoadmore, this.onRefresh, Key? key}) : super(key: key);


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
//       return _buildContainer(List.generate(1, (index) => CustomMaintenance()).toList());
//     }

//     return _buildContainer(
//         List.generate(model!.items!.length, (index) => CustomMaintenance(
//           model: model!.items![index],
//           onRefresh: onRefresh,
//         )).toList(),
//         onLoadmore: onLoadmore,
//         showLoadmore: model!.pageInfo?.enableLoadmore
//     );
//   }
// }

// class CustomMaintenance extends StatelessWidget {

//   final MaintenanceModel? model;
//   final Function? onRefresh;

//   const CustomMaintenance({this.model, this.onRefresh, Key? key}) : super(key: key);

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
//         child: _buildContainer(List.generate(6, (index) => CustomRowWithoutTitleInformation()).toList()),
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
//                   text: model!.maintenanceCode ?? "",
//                   textStyle: AppTextStyles.style14PrimaryBold,
//                 ),
//               ),
//               CustomChip(
//                 text: model!.statusName,
//                 backgroundColor: model!.color,
//                 style: AppTextStyles.style14WhiteBold,
//               )
//             ],
//           ),
//           CustomRowWithoutTitleInformation(
//               icon: Assets.iconPerson,
//               text: model!.customerName ?? ""
//           ),
//           CustomRowWithoutTitleInformation(
//               icon: Assets.iconProtect,
//               text: model!.objectName ?? ""
//           ),
//           CustomRowWithoutTitleInformation(
//               icon: Assets.iconMoney,
//               text: formatMoney(model!.totalAmountPay)
//           ),
//           CustomRowInformation(
//               icon: Assets.iconCalendar,
//               title: AppLocalizations.text(LangKey.maintenance_day),
//               content: parseAndFormatDate(model!.createdAt, format: AppFormat.formatDateTime)
//           ),
//           CustomRowInformation(
//               icon: Assets.iconCalendar,
//               title: AppLocalizations.text(LangKey.estimated_delivery_date),
//               content: parseAndFormatDate(model!.dateEstimateDelivery, format: AppFormat.formatDateTime)
//           ),
//         ]),
//       ),
//       onTap: () async {
//         bool? event = await CustomNavigator.push(context, MaintenanceDetailScreen(model!.maintenanceCode));
//         if((event ?? false) && onRefresh != null){
//           onRefresh!();
//         }
//       },
//     );
//   }
// }
