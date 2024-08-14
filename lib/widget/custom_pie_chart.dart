// part of widget;

// class CustomPieChart extends StatefulWidget {

//   final Function(DateTime?, DateTime?)? onFilter;
//   final WorkJobOverviewResponseModel? model;
//   final Function(int?)? onListStatus;

//   CustomPieChart({this.onFilter, this.model, this.onListStatus});

//   @override
//   CustomPieChartState createState() => CustomPieChartState();
// }

// class CustomPieChartState extends State<CustomPieChart> {

//   WorkJobOverviewRequestModel _model = WorkJobOverviewRequestModel(
//     id: AppLocalizations.text(LangKey.today)
//   );

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//   }

//   _filter() async {
//     WorkJobOverviewRequestModel? result = await CustomNavigator.push(context, OverviewFilterScreen(model: _model,));
//     if(result != null){
//       _model = result;
//       widget.onFilter!(_model.fromDate, _model.toDate);
//       setState(() {});
//     }
//   }

//   Widget _buildNote(CustomPieChartModel? model){
//     if(model == null){
//       return Row(
//         children: [
//           CustomSkeleton(
//             width: 5.0,
//             height: 5.0,
//             radius: 0.0,
//           ),
//           Container(width: AppSizes.minPadding,),
//           Expanded(child: CustomSkeleton())
//         ],
//       );
//     }
//     return InkWell(
//       child: Padding(
//         padding: EdgeInsets.symmetric(vertical: AppSizes.minPadding/ 2),
//         child: Row(
//           children: [
//             Container(
//               width: 5.0,
//               height: 5.0,
//               color: model.isChart?(model.color ?? Colors.transparent): Colors.transparent,
//             ),
//             Container(width: AppSizes.minPadding,),
//             Expanded(child: Text(
//               model.isChart?"${model.value ?? 0} ${model.text ?? ""}": model.text ?? "",
//               style: AppTextStyles.style14BlackNormal.copyWith(
//                 color: model.color ?? AppColors.blackColor,
//                 decoration: model.isChart?TextDecoration.underline:null
//               ),
//             ))
//           ],
//         ),
//       ),
//       onTap: model.isChart?() => widget.onListStatus!(model.id):null,
//     );
//   }

//   Widget _buildSkeleton(){
//     return CustomShimmer(
//       child: CustomListView(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         padding: EdgeInsets.zero,
//         children: List.generate(6, (index) {
//           return _buildNote(null);
//         }).toList(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(widget.model == null){
//       return _buildSkeleton();
//     }

//     final models = (widget.model!.total ?? <WorkJobTotalModel>[]).map((e) => CustomPieChartModel(
//         id: e.id,
//         color: (e.color ?? "").isEmpty?null:HexColor(e.color),
//         text: e.title,
//         value: e.total,
//         isChart: e.isChart == 1
//     )).toList();

//     return CustomListView(
//       physics: NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: EdgeInsets.zero,
//       children: [
//         if(widget.onFilter != null)
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               CustomTextDropdown(
//                 text: _model.id == AppLocalizations.text(LangKey.custom_time_frame)
//                     ? "${formatDate(_model.fromDate)} - ${formatDate(_model.toDate)}"
//                     : _model.id,
//                 onTap: _filter,
//               )
//             ],
//           ),
//         Row(
//           children: [
//             Container(
//               width: AppSizes.maxWidth/ 3,
//               height: AppSizes.maxWidth/ 3,
//               child: Stack(
//                 fit: StackFit.expand,
//                 children: [
//                   PieChart(
//                     PieChartData(
//                         borderData: FlBorderData(
//                           show: false,
//                         ),
//                         sectionsSpace: 0,
//                         centerSpaceRadius: 40,
//                         sections: models.where((element) => element.isChart).map((e) => PieChartSectionData(
//                           color: e.color??Colors.transparent,
//                           value: (e.value ?? 0).toDouble(),
//                           radius: 20.0,
//                           showTitle: false,
//                         )).toList()
//                     ),
//                   ),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       AutoSizeText(
//                         (widget.model!.totalWork ?? 0).toString(),
//                         style: AppTextStyles.style14DarkRedBold,
//                         maxLines: 1,
//                         minFontSize: 1,
//                       ),
//                       AutoSizeText(
//                         AppLocalizations.text(LangKey.work)!,
//                         style: AppTextStyles.style14DarkRedBold.copyWith(
//                             color: AppColors.darkRedColor.withOpacity(0.5)
//                         ),
//                         maxLines: 1,
//                         minFontSize: 1,
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Container(width: AppSizes.minPadding,),
//             Expanded(
//               child: Column(
//                 children: models.map(
//                         (e) => _buildNote(e))
//                     .toList(),
//               ),
//             )
//           ],
//         ),
//       ],
//     );
//   }
// }

// class CustomPieChartModel{
//   final int? id;
//   final Color? color;
//   final String? text;
//   final int? value;
//   final bool isChart;

//   CustomPieChartModel({this.id, this.color, this.text, this.value, this.isChart = true});
// }

// class CustomPieChartHome extends StatelessWidget {

//   final String? title;
//   final int? total;
//   final List<CustomPieChartModel>? models;

//   CustomPieChartHome({
//     this.title,
//     this.total,
//     this.models
//   });

//   Widget _buildNote(CustomPieChartModel? model){
//     if(model == null){
//       return Row(
//         children: [
//           CustomSkeleton(
//             width: 5.0,
//             height: 5.0,
//             radius: 0.0,
//           ),
//           Container(width: AppSizes.minPadding,),
//           Expanded(child: CustomSkeleton())
//         ],
//       );
//     }
//     return Row(
//       children: [
//         Container(
//           width: 5.0,
//           height: 5.0,
//           color: model.isChart?(model.color ?? Colors.transparent): Colors.transparent,
//         ),
//         Container(width: AppSizes.minPadding,),
//         Expanded(child: Text(
//           model.isChart?"${model.value ?? 0} ${model.text ?? ""}": model.text ?? "",
//           style: AppTextStyles.style13BlackNormal,
//         ))
//       ],
//     );
//   }

//   Widget _buildSkeleton(){
//     return CustomShimmer(
//       child: CustomListView(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         padding: EdgeInsets.zero,
//         children: List.generate(6, (index) {
//           return _buildNote(null);
//         }).toList(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(models == null){
//       return _buildSkeleton();
//     }

//     return Row(
//       children: [
//         Container(
//           width: AppSizes.maxWidth/ 3,
//           height: AppSizes.maxWidth/ 3,
//           child: Stack(
//             fit: StackFit.expand,
//             children: [
//               PieChart(
//                 PieChartData(
//                     borderData: FlBorderData(
//                       show: false,
//                     ),
//                     sectionsSpace: 0,
//                     centerSpaceRadius: 40,
//                     sections: models!.where((element) => element.isChart).map((e) => PieChartSectionData(
//                       color: e.color ?? Colors.transparent,
//                       value: (e.value ?? 0).toDouble(),
//                       radius: 20.0,
//                       showTitle: false,
//                     )).toList()
//                 ),
//               ),
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   AutoSizeText(
//                     (total ?? 0).toString(),
//                     style: AppTextStyles.style14DarkRedBold,
//                     maxLines: 1,
//                     minFontSize: 1,
//                   ),
//                   AutoSizeText(
//                     title ?? "",
//                     style: AppTextStyles.style14DarkRedBold.copyWith(
//                         color: AppColors.darkRedColor.withOpacity(0.5)
//                     ),
//                     maxLines: 1,
//                     minFontSize: 1,
//                   ),
//                 ],
//               )
//             ],
//           ),
//         ),
//         Container(width: AppSizes.minPadding,),
//         Expanded(
//           child: CustomListView(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             padding: EdgeInsets.zero,
//             children: models!.map((e) => _buildNote(e)).toList(),
//           ),
//         )
//       ],
//     );
//   }
// }
