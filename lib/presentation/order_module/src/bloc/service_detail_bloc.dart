import 'package:epoint_deal_plugin/model/request/service_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/response/service_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class ServiceDetailBloc extends BaseBloc {

  ServiceDetailBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamImage.close();
    _streamModel.close();
    _streamQuantity.close();
    super.dispose();
  }

  final _streamImage = BehaviorSubject<String?>();
  ValueStream<String?> get outputImage => _streamImage.stream;
  setImage(String? event) => set(_streamImage, event);

  final _streamModel = BehaviorSubject<ServiceDetailResponseModel?>();
  ValueStream<ServiceDetailResponseModel?> get outputModel => _streamModel.stream;
  setModel(ServiceDetailResponseModel event) => set(_streamModel, event);

  final _streamQuantity = BehaviorSubject<double?>();
  ValueStream<double?> get outputQuantity => _streamQuantity.stream;
  setQuantity(double? event) => set(_streamQuantity, event);

  serviceDetail(ServiceDetailRequestModel model, bool isRefresh) async {
    ResponseModel response = await repository.serviceDetail(context, model);
    if(response.success!){
      var responseModel = ServiceDetailResponseModel.fromJson(response.data!);

      setModel(responseModel);
    }
    else{
      if(!isRefresh){
        setModel(ServiceDetailResponseModel());
      }
    }
  }
}