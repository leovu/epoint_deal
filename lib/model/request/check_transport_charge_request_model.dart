class CheckTransportChargeRequestModel {
  String? brandCode;
  String? customerContactCode;
  int? customerId;

  CheckTransportChargeRequestModel({this.brandCode, this.customerContactCode, this.customerId});

  CheckTransportChargeRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    customerContactCode = json['customer_contact_code'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['customer_contact_code'] = this.customerContactCode;
    data['customer_id'] = this.customerId;
    return data;
  }
}