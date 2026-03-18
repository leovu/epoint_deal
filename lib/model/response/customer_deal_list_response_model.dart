import 'customer_deal_response_model.dart';

class CustomerDealListResponseModel {
  List<CustomerDealModel>? data;

  CustomerDealListResponseModel({this.data});

  CustomerDealListResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerDealModel>[];
      json.forEach((v) {
        data!.add(new CustomerDealModel.fromJson(v));
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