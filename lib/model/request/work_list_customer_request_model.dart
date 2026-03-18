class WorkListCustomerRequestModel {
  String? manageWorkCustomerType;

  WorkListCustomerRequestModel({this.manageWorkCustomerType});

  WorkListCustomerRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkCustomerType = json['manage_work_customer_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_customer_type'] = this.manageWorkCustomerType;
    return data;
  }
}