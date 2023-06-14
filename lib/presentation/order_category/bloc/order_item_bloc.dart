
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/product_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_request_model.dart';
import 'package:epoint_deal_plugin/model/response/product_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

abstract class OrderItemBase {
  getProduct();
  getService();
}

class OrderItemBloc extends BaseBloc {
  bool isLoading = false;
  final _streamService = BehaviorSubject<ServiceResponseModel?>();
  final _streamProduct = BehaviorSubject<ProductResponseModel?>();

  ValueStream<ServiceResponseModel?> get outputService => _streamService.stream;
  ValueStream<ProductResponseModel?> get outputProduct => _streamProduct.stream;

  setService(ServiceResponseModel? event) => set(_streamService, event);
  setProduct(ProductResponseModel? event) => set(_streamProduct, event);

  OrderItemBloc(BuildContext context) {
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamService.close();
    _streamProduct.close();
    super.dispose();
  }

  getService(ServiceRequestModel? model, {bool isLoadMore = false , bool isSearch = false}) async {
    if (isLoading) return;
    if (isLoadMore) {
      ServiceResponseModel current = _streamService.value!;
      if (current.pageInfo == null) {
        return;
      }
      if (current.pageInfo!.nextPage == null) {
        return;
      }
      model!.page = current.pageInfo!.nextPage;
    } else {
      if(!isSearch) {
       CustomNavigator.showProgressDialog(context);
      }
    }
    isLoading = true;
    ListServiceResponseModel? result = await DealConnection.getService(context, model!);
    CustomNavigator.hideProgressDialog();
    isLoading = false;
    if (result != null) {

      ServiceResponseModel? response = result.data;
      if (model.page == 1) {
        if(((response!.pageInfo?.currentPage??0) < ((response.pageInfo?.lastPage)??0))
            && response.items != null && response.items!.length != 0){
          response.items!.add(null);
        }
        setService(response);
      } else {
        ServiceResponseModel current = _streamService.value!;
        if((current.items ?? <ServiceModel>[]).last == null){
          current.items!.removeLast();
        }
        current.pageInfo = response!.pageInfo;
        if (response.items == null) {
          current.items = null;
        } else {
          if (current.items != null) {
            current.items!.addAll(response.items!);
          } else {
            current.items = response.items;
          }
        }

        if((((current.pageInfo?.currentPage??0)) < ((current.pageInfo?.lastPage)??0))){
          current.items!.add(null);
        }

        setService(current);
      }
    }
  }

  getProduct(ProductRequestModel? model, {bool isLoadMore = false , bool isSearch = false}) async {
    if (isLoading) return;
    if (isLoadMore) {
      ProductResponseModel current = _streamProduct.value!;
      if (current.pageInfo == null) {
        return;
      }
      if (current.pageInfo!.nextPage == null) {
        return;
      }
      model!.page = current.pageInfo!.nextPage;
    } else {
      if(!isSearch) {
      CustomNavigator.showProgressDialog(context);
      }
    }
    isLoading = true;
    ListProductResponseModel? result = await DealConnection.getProduct(context, model!);
    CustomNavigator.hideProgressDialog();
    isLoading = false;
    if (result != null) {

      ProductResponseModel? response = result.data;

      if (model.page == 1) {
        if(((response!.pageInfo?.currentPage??0) < ((response.pageInfo?.lastPage)??0))
            && response.items != null && response.items!.length != 0){
          response.items!.add(null);
        }
        setProduct(response);
      } else {
        ProductResponseModel current = _streamProduct.value!;
        if((current.items ?? <ProductModel>[]).last == null){
          current.items!.removeLast();
        }
        current.pageInfo = response!.pageInfo;
        if (response.items == null) {
          current.items = null;
        } else {
          current.pageInfo = response.pageInfo;
          if (response.items == null) {
            current.items = null;
          } else {
            if (current.items != null) {
              current.items!.addAll(response.items!);
            } else {
              current.items = response.items;
            }
          }

          if((((current.pageInfo?.currentPage??0)) < ((current.pageInfo?.lastPage)??0))){
            current.items!.add(null);
          }

          setProduct(current);
        }
      }
    }
  }
}
