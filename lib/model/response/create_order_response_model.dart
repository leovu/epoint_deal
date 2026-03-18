

import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';

class CreateOrderResponseModel {
  int? orderId;
  int? orderCreateTicket;
  OrderDetailResponseModel? orderInfo;

  CreateOrderResponseModel({this.orderId, this.orderCreateTicket, this.orderInfo});

  CreateOrderResponseModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderCreateTicket = json['order_create_ticket'];
    orderInfo = json['order_info'] != null ? new OrderDetailResponseModel.fromJson(json['order_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_create_ticket'] = this.orderCreateTicket;
    if (this.orderInfo != null) {
      data['order_info'] = this.orderInfo!.toJson();
    }
    return data;
  }
}