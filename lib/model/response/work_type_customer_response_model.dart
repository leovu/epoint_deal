class WorkTypeCustomerResponseModel {
  List<WorkTypeCustomerModel>? data;

  WorkTypeCustomerResponseModel({this.data});

  WorkTypeCustomerResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkTypeCustomerModel>[];
      json.forEach((v) {
        data!.add(new WorkTypeCustomerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkTypeCustomerModel {
  String? manageWorkCustomerType;
  String? manageWorkCustomerTypeText;

  WorkTypeCustomerModel({this.manageWorkCustomerType, this.manageWorkCustomerTypeText});

  WorkTypeCustomerModel.fromJson(Map<String, dynamic> json) {
    manageWorkCustomerType = json['manage_work_customer_type'];
    manageWorkCustomerTypeText = json['manage_work_customer_type_text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_customer_type'] = this.manageWorkCustomerType;
    data['manage_work_customer_type_text'] = this.manageWorkCustomerTypeText;
    return data;
  }
}