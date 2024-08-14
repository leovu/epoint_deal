

import 'package:epoint_deal_plugin/model/page_info_model.dart';

import 'order_response_model.dart';

class HistoryOrderResponseModel {
  PageInfoModel? pageInfo;
  List<OrderModel>? items;

  HistoryOrderResponseModel({this.pageInfo, this.items});

  HistoryOrderResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <OrderModel>[];
      json['Items'].forEach((v) {
        items!.add(new OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}