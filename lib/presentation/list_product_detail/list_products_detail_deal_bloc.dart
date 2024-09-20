import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ListProductsDetailDealBloc extends BaseBloc {

  ListProductsDetailDealBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    _streamListProductBuy.close();
    super.dispose();
  }

  List<CustomDropdownModel> listProductType = [
    CustomDropdownModel(text: "all"),
    CustomDropdownModel(text: "product"),
    CustomDropdownModel(text: "service"),
    CustomDropdownModel(text: "service_card")
  ];
  CustomDropdownModel? selectedProductType;
  List<ProductBuy>? listProductBuy;

  final _streamListProductBuy = BehaviorSubject<List<ProductBuy>?>();
  ValueStream<List<ProductBuy>?> get outputListProductBuy => _streamListProductBuy.stream;
  setListProductBuy(List<ProductBuy> event) => set(_streamListProductBuy, event);

  onChange(CustomDropdownModel value) {
    selectedProductType = value;
    if (value.text == "all") {
      setListProductBuy(listProductBuy ?? []);
    } else {
      setListProductBuy(listProductBuy?.where((element) => element.objectType == value.text).toList() ?? []);
    }
  }

  onRemove() {
    selectedProductType = null;
    setListProductBuy(listProductBuy ?? []);
  }



}