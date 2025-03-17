import 'dart:io';

import 'package:aws_s3_upload_lite/aws_s3_upload_lite.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/connection/network_connectivity.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:path/path.dart';

abstract class AWSConnection<T> {
  late AWSFileModel file;
  String get secretKey;
  String get region;
  String get accessKey;
  String get bucket;

  Future<T> upload() async {
    T? data = await _checkConnectivity();
    if (data != null) {
      return await handleError(data);
    }

    final url = await AwsS3.uploadFile(
      accessKey: accessKey,
      secretKey: secretKey,
      file: file.file!,
      bucket: bucket,
      region: region,
      destDir: "",
      filename: basename(file.file!.path)
    );

    if (url.isEmpty) {
      return await handleError(getError(
        AppLocalizations.text(LangKey.server_error),
      ));
    }

    return await handleResponse(
        ResponseModel(url: url, success: true));
  }

  Future<T?> _checkConnectivity() async {
    if (!(await NetworkConnectivity.isConnected())) {
      return getError(AppLocalizations.text(LangKey.connection_error));
    }
    return null;
  }

  T getError(String? error, {int? errorCode});

  Future<T> handleError(T model);

  Future<T> handleResponse(ResponseModel response);
}

class AWSFileModel {
  String? fileName;
  File? file;
  AWSFileModel({this.fileName, this.file});
}