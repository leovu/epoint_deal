class DestroyOrderRequestModel {
  String? brandCode;
  int? orderId;
  String? type;

  DestroyOrderRequestModel({this.brandCode, this.orderId, this.type});

  DestroyOrderRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    orderId = json['order_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['order_id'] = this.orderId;
    data['type'] = this.type;
    return data;
  }
}