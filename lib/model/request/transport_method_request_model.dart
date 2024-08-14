class TransportMethodRequestModel {
  String? customerContactCode;
  int? customerId;

  TransportMethodRequestModel({this.customerContactCode, this.customerId});

  TransportMethodRequestModel.fromJson(Map<String, dynamic> json) {
    customerContactCode = json['customer_contact_code'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_contact_code'] = this.customerContactCode;
    data['customer_id'] = this.customerId;
    return data;
  }
}