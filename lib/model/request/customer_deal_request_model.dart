class CustomerDealRequestModel {
  String? customerCode;
  int? page;
  String? status;

  CustomerDealRequestModel({this.customerCode, this.page, this.status});

  CustomerDealRequestModel.fromJson(Map<String, dynamic> json) {
    customerCode = json['customer_code'];
    page = json['page'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_code'] = this.customerCode;
    data['page'] = this.page;
    data['status'] = this.status;
    return data;
  }
}
