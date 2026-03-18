class OrderServiceCardDetailRequestModel {
  int? serviceCardId;

  OrderServiceCardDetailRequestModel({this.serviceCardId});

  OrderServiceCardDetailRequestModel.fromJson(Map<String, dynamic> json) {
    serviceCardId = json['service_card_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_card_id'] = this.serviceCardId;
    return data;
  }
}
