// import 'dart:io';

// import 'package:epoint_deal_plugin/common/constant.dart';
// import 'package:epoint_deal_plugin/common/lang_key.dart';
// import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
// import 'package:epoint_deal_plugin/common/theme.dart';
// import 'package:epoint_deal_plugin/model/customer_order_photo_model.dart';
// import 'package:epoint_deal_plugin/model/request/order_upload_image_request_model.dart';
// import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
// import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
// import 'package:epoint_deal_plugin/widget/custom_line.dart';
// import 'package:epoint_deal_plugin/widget/custom_listview.dart';
// import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
// import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
// import 'package:epoint_deal_plugin/widget/widget.dart';
// import 'package:flutter/material.dart';

// import '../bloc/order_photo_upload_bloc.dart';

// class OrderPhotoUploadScreen extends StatefulWidget {
//   final String? orderCode;
//   final List<OrderImageModel>? imageBefore;
//   final List<OrderImageModel>? imageAfter;

//   OrderPhotoUploadScreen(this.orderCode, this.imageBefore, this.imageAfter);
//   @override
//   _OrderPhotoUploadScreenState createState() => _OrderPhotoUploadScreenState();
// }

// class _OrderPhotoUploadScreenState extends State<OrderPhotoUploadScreen> {
//   List<OrderImageModel>? _imageBefore;
//   List<OrderImageModel>? _imageAfter;

//   late OrderPhotoUploadBloc _bloc;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _bloc = OrderPhotoUploadBloc(context);
//     _imageAfter = widget.imageAfter ?? [];
//     _imageBefore = widget.imageBefore ?? [];
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _bloc.dispose();
//     super.dispose();
//   }

//   _update() {
//     List<OrderUploadImageModel> images = _imageBefore!
//         .map((e) => OrderUploadImageModel(
//             orderImageId: e.orderImageId, type: imageTypeBefore, link: e.link))
//         .toList();
//     images.addAll(_imageAfter!
//         .map((e) => OrderUploadImageModel(
//             orderImageId: e.orderImageId, type: imageTypeAfter, link: e.link))
//         .toList());
//     _bloc.uploadPhotoOrder(OrderUploadImageRequestModel(
//         orderCode: widget.orderCode, listImages: images));
//   }

//   _removeImage(int index, {bool isBefore = true}) {
//     if (isBefore) {
//       _imageBefore!.removeAt(index);
//       _bloc.setImageBefore(_imageBefore);
//     } else {
//       _imageAfter!.removeAt(index);
//       _bloc.setImageAfter(_imageAfter);
//     }
//   }

//   _addImage(List<File> files, {bool isBefore = true}) async {
//     CustomNavigator.pop(context);
//     CustomNavigator.showProgressDialog(context);
//     String? error;
//     for (var e in files) {
//       await _bloc.uploadFile(
//           AWSFileModel(
//             file: e,
//           ), (url) {
//         if (isBefore) {
//           _imageBefore!.add(OrderImageModel(link: url));
//         } else {
//           _imageAfter!.add(OrderImageModel(link: url));
//         }
//       }, (e) => error = e);
//     }
//     CustomNavigator.hideProgressDialog();

//     if (isBefore) {
//       _bloc.setImageBefore(_imageBefore);
//     } else {
//       _bloc.setImageAfter(_imageAfter);
//     }

//     if (error != null) {
//       CustomNavigator.showCustomAlertDialog(
//           context, AppLocalizations.text(LangKey.notification), error);
//     }
//   }

//   Widget _buildFrontImage() {
//     return CustomColumnInformation(
//       title: AppLocalizations.text(LangKey.pictures_before_use),
//       child: StreamBuilder(
//           stream: _bloc.outputImageBefore,
//           initialData: _imageBefore,
//           builder: (_, snapshot) {
//             return CustomImageList(
//               models: _imageBefore!.map((e) => CustomerOrderPhotoModel(
//                   url: e.link
//               )).toList(),
//               onAdd: (files) => _addImage(files),
//               onRemove: (index) => _removeImage(index),
//             );
//           }),
//     );
//   }

//   Widget _buildAfterImage() {
//     return CustomColumnInformation(
//       title: AppLocalizations.text(LangKey.pictures_after_use),
//       child: StreamBuilder(
//           stream: _bloc.outputImageAfter,
//           initialData: _imageAfter,
//           builder: (_, snapshot) {
//             return CustomImageList(
//               models: _imageAfter!.map((e) => CustomerOrderPhotoModel(
//                   url: e.link
//               )).toList(),
//               onAdd: (files) => _addImage(files, isBefore: false),
//               onRemove: (index) => _removeImage(index, isBefore: false),
//             );
//           }),
//     );
//   }

//   Widget _buildContent() {
//     return CustomListView(
//       separator: Column(
//         children: [
//           SizedBox(
//             height: AppSizes.minPadding,
//           ),
//           CustomLine(),
//           SizedBox(
//             height: AppSizes.minPadding,
//           ),
//         ],
//       ),
//       children: [_buildFrontImage(), _buildAfterImage()],
//     );
//   }

//   Widget _buildBottom() {
//     return CustomBottom(
//       text: AppLocalizations.text(LangKey.update),
//       onTap: _update,
//     );
//   }

//   Widget _buildBody() {
//     return Column(
//       children: [Expanded(child: _buildContent()), _buildBottom()],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CustomScaffold(
//       title: AppLocalizations.text(LangKey.update_order_photo),
//       body: _buildBody(),
//     );
//   }
// }
