class CustomerStaffRequestModel {
  String? brandCode;
  int? customerId;

  CustomerStaffRequestModel({this.brandCode, this.customerId});

  CustomerStaffRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['customer_id'] = this.customerId;
    return data;
  }
}
