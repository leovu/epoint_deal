import 'package:epoint_deal_plugin/model/request/product_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/response/product_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';

class ProductDetailBloc extends BaseBloc {

  ProductDetailBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamImage.close();
    _streamModel.close();
    super.dispose();
  }

  final _streamImage = BehaviorSubject<String?>();
  ValueStream<String?> get outputImage => _streamImage.stream;
  setImage(String? event) => set(_streamImage, event);

  final _streamModel = BehaviorSubject<ProductDetailResponseModel?>();
  ValueStream<ProductDetailResponseModel?> get outputModel => _streamModel.stream;
  setModel(ProductDetailResponseModel event) => set(_streamModel, event);

  productDetail(ProductDetailRequestModel model, bool isRefresh) async {
    ResponseModel response = await repository.productDetail(context, model);
    if(response.success!){
      var responseModel = ProductDetailResponseModel.fromJson(response.data!);

      setModel(responseModel);
    }
    else{
      if(!isRefresh){
        setModel(ProductDetailResponseModel());
      }
    }
  }
}