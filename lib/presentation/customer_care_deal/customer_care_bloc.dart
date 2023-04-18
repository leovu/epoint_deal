import 'dart:io';

import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/connection/http_connection.dart';
import 'package:epoint_deal_plugin/model/response/work_upload_file_model_response.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class CustomerCareBloc extends BaseBloc {

  CustomerCareBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    _streamFiles.close();
    super.dispose();
  }

   List<String> _files = [];


  final _streamFiles = BehaviorSubject<List<String>>();
  ValueStream<List<String>> get outputFiles => _streamFiles.stream;
  setFiles(List<String> event) => set(_streamFiles, event);


    workUploadFile(File model) async {
    DealConnection.showLoading(context);

    
    String result = await DealConnection.uploadFileAWS(context, model);


    Navigator.of(context).pop();
    if(result != null){
      // WorkUploadFileResponse response = result.url;

      _files.add(result);
      setFiles(_files);
    } else {
      DealConnection.handleError(context, AppLocalizations.text(LangKey.server_error));
    }
  }

  removeFile(String model){
    _files.remove(model);
    setFiles(_files);
  }
}