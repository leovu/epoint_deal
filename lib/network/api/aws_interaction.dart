import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/network/http/aws_connection.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/material.dart';

class AWSInteraction extends AWSConnection<ResponseModel> {

  final BuildContext? context;
  final AWSFileModel file;
  final bool showError;

  AWSInteraction({
    this.context,
    required this.file,
    this.showError = true,
  });


  @override
  // TODO: implement accessKey
  String get accessKey => "AKIAUO66DKWUKVBVJCJK";

  @override
  // TODO: implement bucket
  String get bucket => "epoint-bucket";

  @override
  // TODO: implement region
  String get region => "ap-southeast-1";

  @override
  // TODO: implement secretKey
  String get secretKey => "tVfiARnRpHC51C/4O1OrZg3dNsTOVP0Fntf2MHAq";

  @override
  Future<ResponseModel> handleError(ResponseModel model) async {
    // TODO: implement handleError
    if (showError)
      await CustomNavigator.showCustomAlertDialog(context!,
          AppLocalizations.text(LangKey.notification), model.errorDescription ?? "");
    return model;
  }

  @override
  Future<ResponseModel> handleResponse(ResponseModel response) async {
    // TODO: implement handleResponse
    return response;
  }

  @override
  ResponseModel getError(String? error, {int? errorCode}) {
    // TODO: implement getError
    return ResponseModel(errorDescription: error, errorCode: errorCode);
  }
}