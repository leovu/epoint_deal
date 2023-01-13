import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/product_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/response/product_detail_response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/streams.dart';

class ProductDetailBloc extends BaseBloc {

  ProductDetailBloc(BuildContext context){
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

  final _streamImage = BehaviorSubject<String>();
  ValueStream<String> get outputImage => _streamImage.stream;
  setImage(String event) => set(_streamImage, event);

  final _streamModel = BehaviorSubject<ProductDetailResponseModel>();
  ValueStream<ProductDetailResponseModel> get outputModel => _streamModel.stream;
  setModel(ProductDetailResponseModel event) => set(_streamModel, event);

  final _streamQuantity = BehaviorSubject<int>();
  ValueStream<int> get outputQuantity => _streamQuantity.stream;
  setQuantity(int event) => set(_streamQuantity, event);

  productDetail(ProductDetailRequestModel model, bool isRefresh) async {
    ProductDetailModel response = await DealConnection.productDetail(context, model);
    if(response != null){
     ProductDetailResponseModel responseModel = response.data;

      setModel(responseModel ?? ProductDetailResponseModel());
    }
    else{
      if(!isRefresh){
        setModel(ProductDetailResponseModel());
      }
    }
  }
}