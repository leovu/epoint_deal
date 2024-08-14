class CustomerOrderListRequestModel {
  int? customerId;

  CustomerOrderListRequestModel({this.customerId});

  CustomerOrderListRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    return data;
  }
}
