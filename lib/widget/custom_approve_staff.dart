// part of widget;

// class CustomApproveStaff extends StatelessWidget {

//   final List<TimeoffdaysStaffsListModel>? models;

//   const CustomApproveStaff({Key? key, this.models}) : super(key: key);

//   final double _arrowSize = 20.0;
//   final int _maxLength = 3;

//   Widget _buildApproveAvatar(int length){
//     List<Widget> children = [];

//     for(int i = 0; i < length; i++){
//       TimeoffdaysStaffsListModel model = models![i];
//       children.add(Expanded(child: Center(
//         child: CustomApproveAvatar(
//           size: AppSizes.sizeOnTap,
//           name: model.fullName,
//           url: model.staffAvatar,
//           isApproved: model.isApprovce,
//         ),
//       )));
//       if(i == length - 1){
//         children.add(SizedBox(width: _arrowSize / 2,));
//       }
//       else{
//         children.add(CustomImageIcon(
//           icon: Assets.iconNextArrow,
//           size: _arrowSize,
//         ));
//       }
//     }

//     children.insert(0, SizedBox(width: _arrowSize / 2,));

//     return Row(
//       children: children,
//     );
//   }

//   Widget _buildApproveName(int length){
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: List.generate(length, (index) {
//         TimeoffdaysStaffsListModel model = models![index];
//         return Expanded(
//           child: Column(
//             children: [
//               Text(
//                 model.fullName ?? "",
//                 style: AppTextStyles.style14BlackBold,
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: AppSizes.minPadding,),
//               Text(
//                 model.staffTitle ?? "",
//                 style: AppTextStyles.style12BlackNormal,
//                 textAlign: TextAlign.center,
//               ),
//             ],
//           ),
//         );
//       }).toList(),
//     );
//   }

//   Widget _buildSkeleton(){
//     return CustomShimmer(
//       child: Column(
//         children: [
//           CustomSkeleton(
//             width: AppSizes.sizeOnTap,
//             height: AppSizes.sizeOnTap,
//             radius: AppSizes.sizeOnTap,
//           ),
//           SizedBox(height: AppSizes.minPadding,),
//           CustomSkeleton(width: AppSizes.maxWidth/ 3,)
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(models == null){
//       return _buildSkeleton();
//     }

//     if(models!.isEmpty){
//       return Container();
//     }

//     int length = min(models!.length, _maxLength);

//     return Column(
//       children: [
//         _buildApproveAvatar(length),
//         SizedBox(height: AppSizes.minPadding,),
//         _buildApproveName(length),
//       ],
//     );
//   }
// }
