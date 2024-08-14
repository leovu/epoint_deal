class CustomerServiceCardDetailRequestModel {
  int? customerServiceCardId;
  int? customerId;

  CustomerServiceCardDetailRequestModel({this.customerServiceCardId, this.customerId});

  CustomerServiceCardDetailRequestModel.fromJson(Map<String, dynamic> json) {
    customerServiceCardId = json['customer_service_card_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_service_card_id'] = this.customerServiceCardId;
    data['customer_id'] = this.customerId;
    return data;
  }
}
