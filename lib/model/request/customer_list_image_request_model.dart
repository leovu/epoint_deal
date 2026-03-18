class CustomerListImageRequestModel {
  String? brandCode;
  int? customerId;
  int? page;

  CustomerListImageRequestModel({this.brandCode, this.customerId, this.page});

  CustomerListImageRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    customerId = json['customer_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['customer_id'] = this.customerId;
    data['page'] = this.page;
    return data;
  }
}
