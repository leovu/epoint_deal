
// import 'package:epoint_deal_plugin/common/lang_key.dart';
// import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
// import 'package:epoint_deal_plugin/model/request/order_upload_image_request_model.dart';
// import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
// import 'package:epoint_deal_plugin/model/response_model.dart';
// import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
// import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
// import 'package:flutter/material.dart';
// import 'package:rxdart/rxdart.dart';

// class OrderPhotoUploadBloc extends BaseBloc {
//   OrderPhotoUploadBloc(BuildContext context) {
//     setContext(context);
//   }

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     _streamImageBefore.close();
//     _streamImageAfter.close();
//     super.dispose();
//   }

//   final _streamImageBefore = BehaviorSubject<List<OrderImageModel>?>();
//   ValueStream<List<OrderImageModel>?> get outputImageBefore =>
//       _streamImageBefore.stream;
//   setImageBefore(List<OrderImageModel>? event) => set(_streamImageBefore, event);

//   final _streamImageAfter = BehaviorSubject<List<OrderImageModel>?>();
//   ValueStream<List<OrderImageModel>?> get outputImageAfter =>
//       _streamImageAfter.stream;
//   setImageAfter(List<OrderImageModel>? event) => set(_streamImageAfter, event);

//   uploadFile(AWSFileModel model, Function(String) onSuccess,
//       Function(String?) onError) async {
//     ResponseModel response =
//         await repository.upload(context, model, showError: false);
//     if (response.success!) {
//       onSuccess(response.url ?? "");
//     } else {
//       onError(response.errorDescription);
//     }
//   }

//   uploadPhotoOrder(OrderUploadImageRequestModel model) async {
//     CustomNavigator.showProgressDialog(context);
//     ResponseModel response = await repository.uploadPhotoOrder(context, model);
//     CustomNavigator.hideProgressDialog();
//     if (response.success!) {
//       await CustomNavigator.showCustomAlertDialog(
//           context!,
//           AppLocalizations.text(LangKey.notification),
//           response.errorDescription);
//       CustomNavigator.pop(context!, object: true);
//     }
//   }
// }
