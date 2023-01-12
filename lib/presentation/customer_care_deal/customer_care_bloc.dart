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

   List<WorkUploadFileResponse> _files = [];


  final _streamFiles = BehaviorSubject<List<WorkUploadFileResponse>>();
  ValueStream<List<WorkUploadFileResponse>> get outputFiles => _streamFiles.stream;
  setFiles(List<WorkUploadFileResponse> event) => set(_streamFiles, event);


  workUploadFile(MultipartFileModel model) async {
    DealConnection.showLoading(context);
    WorkUploadFileResponseModel result = await DealConnection.workUploadFile(context, model);
    Navigator.of(context).pop();
    if(result != null){
      WorkUploadFileResponse response = result.data;

      _files.add(response);
      setFiles(_files);
    }
  }

  removeFile(WorkUploadFileResponse model){
    _files.remove(model);
    setFiles(_files);
  }
}