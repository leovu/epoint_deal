class CustomerOrderServiceCardRequestModel {
  int? customerId;
  int? customerServiceCardId;
  int? page;

  CustomerOrderServiceCardRequestModel({this.customerId, this.customerServiceCardId, this.page});

  CustomerOrderServiceCardRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerServiceCardId = json['customer_service_card_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_service_card_id'] = this.customerServiceCardId;
    data['page'] = this.page;
    return data;
  }
}
