class CustomerDebtRequestModel {
  int? customerId;
  String? brandCode;

  CustomerDebtRequestModel({this.customerId, this.brandCode});

  CustomerDebtRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['brand_code'] = this.brandCode;
    return data;
  }
}
