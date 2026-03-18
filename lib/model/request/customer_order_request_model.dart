class CustomerOrderRequestModel {
  int? customerId;
  int? page;
  String? status;

  CustomerOrderRequestModel({this.customerId, this.page, this.status});

  CustomerOrderRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    page = json['page'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['page'] = this.page;
    data['status'] = this.status;
    return data;
  }
}
