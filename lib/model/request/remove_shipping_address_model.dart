class RemoveShippingAddressRequestModel {
  String? brandCode;
  int? customerContactId;

  RemoveShippingAddressRequestModel({this.brandCode, this.customerContactId});

  RemoveShippingAddressRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    customerContactId = json['customer_contact_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['customer_contact_id'] = this.customerContactId;
    return data;
  }
}
