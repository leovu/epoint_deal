import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/connection/http_connection.dart';
import 'package:epoint_deal_plugin/model/request/work_create_comment_request_model.dart';
import 'package:epoint_deal_plugin/model/request/work_list_comment_request_model.dart';
import 'package:epoint_deal_plugin/model/response/work_list_comment_model_response.dart';
import 'package:epoint_deal_plugin/model/response/work_upload_file_model_response.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CommentBloc extends BaseBloc {

  static HTTPConnection connection = HTTPConnection();

  CommentBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamModels.close();
    _streamCallback.close();
    _streamFile.close();
    super.dispose();
  }

  List<WorkListCommentModel> _models;

  final _streamModels = BehaviorSubject<List<WorkListCommentModel>>();
  ValueStream<List<WorkListCommentModel>> get outputModels => _streamModels.stream;
  setModels(List<WorkListCommentModel> event) => set(_streamModels, event);

  final _streamCallback = BehaviorSubject<WorkListCommentModel>();
  ValueStream<WorkListCommentModel> get outputCallback => _streamCallback.stream;
  setCallback(WorkListCommentModel event) => set(_streamCallback, event);

  final _streamFile = BehaviorSubject<String>();
  ValueStream<String> get outputFile => _streamFile.stream;
  setFile(String event) => set(_streamFile, event);

  workListComment(WorkListCommentRequestModel model) async {
    var response = await DealConnection.workListComment(context, model);
    if(response != null){

      _models = response.data ?? [];
    }
    else{
      _models = [];
    }

    setModels(_models);
  }

 workUploadFile(MultipartFileModel model) async {
    DealConnection.showLoading(context);
    ResponseData response =
        await connection.upload('/manage-work/upload-file', model);
    Navigator.of(context).pop();
    if (response.isSuccess) {
      WorkUploadFileResponseModel responseModel =
          WorkUploadFileResponseModel.fromJson(response.data);
        setFile(responseModel.data.path);
    } else {
      DealConnection.showMyDialog(context, "Lỗi máy chủ");
    }
  }



  workCreatedComment(WorkCreateCommentRequestModel model, TextEditingController controller, Function(int) onCallback) async {
    DealConnection.showLoading(context);
    WorkListCommentResponseModel response = await DealConnection.workCreatedComment(context, model);
    Navigator.of(context).pop();
    if(response.errorCode == 0){
      _models = response.data ?? [];
    } else {
      DealConnection.showMyDialog(context, response.errorDescription);
    }

    setModels(_models);
      setFile(null);
      setCallback(null);
      controller.text = "";

      if(onCallback != null){
        int total = 0;
        for(var e in _models){
          total += _getTotalComment(e);
        }

        onCallback(total);
      }
  }

  int _getTotalComment(WorkListCommentModel model){
    int total = 1;
    if((model.listObject?.length ?? 0) != 0){
      for(var e in model.listObject){
        total += _getTotalComment(e);
      }
    }
    return total;
  }
}