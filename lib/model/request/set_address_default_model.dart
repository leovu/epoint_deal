class SetAddressDefaultModel {
  String? brandCode;
  int? customerId;
  int? customerContactId;

  SetAddressDefaultModel({this.brandCode, this.customerId, this.customerContactId});

  SetAddressDefaultModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    customerId = json['customer_id'];
    customerContactId = json['customer_contact_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['customer_id'] = this.customerId;
    data['customer_contact_id'] = this.customerContactId;
    return data;
  }
}