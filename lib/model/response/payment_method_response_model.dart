import 'package:flutter/cupertino.dart';

class PaymentMethodResponseModel {
  int? paymentMethodId;
  String? paymentMethodName;
  String? paymentMethodCode;
  TextEditingController? controller;
  FocusNode? node;

  PaymentMethodResponseModel(
      {this.paymentMethodId, this.paymentMethodName, this.paymentMethodCode});

  PaymentMethodResponseModel.fromJson(Map<String, dynamic> json) {
    paymentMethodId = json['payment_method_id'];
    paymentMethodName = json['payment_method_name'];
    paymentMethodCode = json['payment_method_code'];
    controller = TextEditingController();
    node = FocusNode();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_id'] = this.paymentMethodId;
    data['payment_method_name'] = this.paymentMethodName;
    data['payment_method_code'] = this.paymentMethodCode;
    return data;
  }
}