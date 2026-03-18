class CustomerServiceCardRequestModel {
  int? status;
  int? customerId;
  int? page;

  CustomerServiceCardRequestModel({this.status, this.customerId, this.page});

  CustomerServiceCardRequestModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    customerId = json['customer_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['customer_id'] = this.customerId;
    data['page'] = this.page;
    return data;
  }
}
