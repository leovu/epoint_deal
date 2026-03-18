// part of widget;

// class CustomLocation extends StatelessWidget {

//   final int? id;
//   final String? avatar;
//   final String? name;
//   final String? description;
//   final String? lat;
//   final String? lng;
//   final LatLng? latLng;
//   final int? isRemove;
//   final String? createdAt;
//   final Function? onRemove;

//   CustomLocation({
//     Key? key,
//     this.id,
//     this.avatar,
//     this.name,
//     this.description,
//     this.lat,
//     this.lng,
//     this.latLng,
//     this.isRemove,
//     this.createdAt,
//     this.onRemove
//   }) : super(key: key);

//   static const int _itemPerRow = 2;
//   final _width = (AppSizes.maxWidth- AppSizes.maxPadding* 2 - AppSizes.maxPadding* (_itemPerRow - 1) - 1) / _itemPerRow;
//   final _height = 100.0;
//   final _avatarSize = 40.0;
//   final _radius = 5.0;

//   _showOption(BuildContext context){
//     CustomNavigator.showCustomBottomDialog(context, CustomBottomSheet(
//       title: description,
//       body: CustomBottomOption(
//         options: [
//           CustomBottomOptionModel(
//               icon: Assets.iconMap,
//               textColor: AppColors.primaryColor,
//               text: AppLocalizations.text(LangKey.view_detail),
//               onTap: (){
//                 CustomNavigator.pop(context);
//                 googleMap(lat, lng);
//               }
//           ),
//           if(isRemove == 1)
//             CustomBottomOptionModel(
//                 icon: Assets.iconTrash,
//                 text: AppLocalizations.text(LangKey.delete_this_location),
//                 textColor: AppColors.red500,
//                 onTap: (){
//                   CustomNavigator.showCustomAlertDialog(
//                       context,
//                       AppLocalizations.text(LangKey.confirm),
//                       AppLocalizations.text(LangKey.delete_this_location_confirm),
//                       enableCancel: true,
//                       textSubmitted: AppLocalizations.text(LangKey.delete),
//                       onSubmitted: (){
//                         CustomNavigator.pop(context);
//                         onRemove!();
//                       }
//                   );
//                 }
//             )
//           else
//             CustomBottomOptionModel(
//               icon: Assets.iconTrash,
//               text: AppLocalizations.text(LangKey.not_allowed_delete_this_location),
//               textColor: AppColors.grey500Color,
//             ),
//         ],
//       ),
//     ));
//   }

//   Widget _buildSkeleton(){
//     return CustomShimmer(
//       child: SizedBox(
//         width: _width,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomSkeleton(
//               width: _avatarSize,
//               height: _avatarSize,
//               radius: _avatarSize,
//             ),
//             SizedBox(width: AppSizes.minPadding,),
//             Expanded(child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 CustomSkeleton(
//                   width: double.infinity,
//                   height: _height,
//                   radius: _radius,
//                 ),
//                 SizedBox(height: AppSizes.minPadding,),
//                 CustomSkeleton()
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildItem(BuildContext context){
//     return InkWell(
//       child: SizedBox(
//         width: _width,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             CustomAvatar(
//               size: _avatarSize,
//               url: avatar,
//               name: name,
//             ),
//             SizedBox(width: AppSizes.minPadding,),
//             Expanded(child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(_radius),
//                   child: Stack(
//                     alignment: Alignment.bottomCenter,
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         height: _height,
//                         child: AbsorbPointer(
//                             absorbing: true,
//                             child: GoogleMap(
//                               initialCameraPosition: CameraPosition(
//                                   target: latLng!,
//                                   zoom: 18.0
//                               ),
//                               compassEnabled: false,
//                               mapToolbarEnabled: false,
//                               myLocationButtonEnabled: false,
//                               zoomControlsEnabled: false,
//                               markers: Set.of([Marker(
//                                 markerId: MarkerId("1"),
//                                 position: latLng!,
//                               )]),
//                             )
//                         ),
//                       ),
//                       Container(
//                         width: double.infinity,
//                         color: AppColors.blueLight,
//                         padding: EdgeInsets.all(AppSizes.minPadding),
//                         child: Text(
//                           description ?? "",
//                           style: AppTextStyles.style14BlackNormal,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: AppSizes.minPadding,),
//                 Text(
//                   parseAndFormatDate(createdAt, format: AppFormat.formatDateTime),
//                   style: AppTextStyles.style14HintNormal,
//                 )
//               ],
//             ))
//           ],
//         ),
//       ),
//       onTap: () => _showOption(context),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     if(id == null){
//       return _buildSkeleton();
//     }
//     return _buildItem(context);
//   }
// }
