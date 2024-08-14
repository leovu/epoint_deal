

import 'package:epoint_deal_plugin/model/response/order_response_model.dart';

class CustomerOrderListResponseModel {
  List<OrderModel>? data;

  CustomerOrderListResponseModel({this.data});

  CustomerOrderListResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <OrderModel>[];
      json.forEach((v) {
        data!.add(new OrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}