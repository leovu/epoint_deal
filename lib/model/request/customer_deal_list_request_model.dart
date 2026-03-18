class CustomerDealListRequestModel {
  String? customerCode;

  CustomerDealListRequestModel({this.customerCode});

  CustomerDealListRequestModel.fromJson(Map<String, dynamic> json) {
    customerCode = json['customer_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_code'] = this.customerCode;
    return data;
  }
}
