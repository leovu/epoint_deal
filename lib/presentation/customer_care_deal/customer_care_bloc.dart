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

   List<WorkUploadFileResponseModel> _files = [];


  final _streamFiles = BehaviorSubject<List<WorkUploadFileResponseModel>>();
  ValueStream<List<WorkUploadFileResponseModel>> get outputFiles => _streamFiles.stream;
  setFiles(List<WorkUploadFileResponseModel> event) => set(_streamFiles, event);


  workUploadFile(MultipartFileModel model) async {
    DealConnection.showLoading(context);
    var result = await DealConnection.workUploadFile(context, model);
    Navigator.of(context).pop();
    if(result != null){
      WorkUploadFileResponseModel response = result;

      _files.add(response);
      setFiles(_files);
    }
  }

  removeFile(WorkUploadFileResponseModel model){
    _files.remove(model);
    setFiles(_files);
  }
}