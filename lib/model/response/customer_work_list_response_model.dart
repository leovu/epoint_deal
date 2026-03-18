import 'customer_work_response_model.dart';

class CustomerWorkListResponseModel {
  List<CustomerWorkModel>? data;

  CustomerWorkListResponseModel({this.data});

  CustomerWorkListResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerWorkModel>[];
      json.forEach((v) {
        data!.add(new CustomerWorkModel.fromJson(v));
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