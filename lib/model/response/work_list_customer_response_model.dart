class WorkListCustomerResponseModel {
  List<WorkListCustomerModel>? data;

  WorkListCustomerResponseModel({this.data});

  WorkListCustomerResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListCustomerModel>[];
      json.forEach((v) {
        data!.add(new WorkListCustomerModel.fromJson(v));
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

class WorkListCustomerModel {
  int? customerId;
  String? customerName;
  String? customerAvatar;

  WorkListCustomerModel({this.customerId, this.customerName});

  WorkListCustomerModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerAvatar = json['customer_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_avatar'] = this.customerAvatar;
    return data;
  }
}