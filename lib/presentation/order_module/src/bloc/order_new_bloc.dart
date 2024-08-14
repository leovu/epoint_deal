
import 'package:epoint_deal_plugin/model/request/order_request_model.dart';
import 'package:epoint_deal_plugin/model/response/order_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OrderNewBloc extends BaseBloc {

  OrderNewBloc(BuildContext context) {
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamModel.close();
    super.dispose();
  }

  OrderRequestModel? _requestModel;
  OrderResponseModel? _model;

  final _streamModel = BehaviorSubject<OrderResponseModel?>();
  ValueStream<OrderResponseModel?> get outputModel => _streamModel.stream;
  setModel(OrderResponseModel? event) => set(_streamModel, event);

  getOrder({OrderRequestModel? requestModel, bool isRefresh = true, bool isLoadmore = false}) async {
    if(isLoadmore && !(_model?.pageInfo?.enableLoadmore ?? false)){
      return;
    }

    if(!isRefresh){
      setModel(null);
    }

    OrderRequestModel model;
    model = requestModel ?? (_requestModel == null
        ? OrderRequestModel()
        : OrderRequestModel.fromJson(_requestModel!.toJson()));
    if(isLoadmore){
      model.page = model.page! + 1;
    }
    else{
      model.page = 1;
    }
    ResponseModel response = await repository.getOrder(context, model);
    if(response.success!){
      var modelResponse = OrderResponseModel.fromJson(response.data!);

      _requestModel = model;
      if(isLoadmore){
        if(_model!.pageInfo?.currentPage != modelResponse.pageInfo?.currentPage){
          if(_model!.items == null){
            _model!.items = [];
          }
          _model!.items!.addAll(modelResponse.items ?? []);
        }
        _model!.pageInfo = modelResponse.pageInfo;
      }
      else{
        _model = modelResponse;
      }

      setModel(_model);
    }
    else{
      if(!isLoadmore && !isRefresh){
        setModel(OrderResponseModel(items: []));
      }
    }
  }
}