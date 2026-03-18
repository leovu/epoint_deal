class CreateQRCodeRequestModel {
  String? objectType;
  int? objectId;
  String? paymentMethodCode;
  double? money;

  CreateQRCodeRequestModel(
      {this.objectType, this.objectId, this.paymentMethodCode, this.money});

  CreateQRCodeRequestModel.fromJson(Map<String, dynamic> json) {
    objectType = json['object_type'];
    objectId = json['object_id'];
    paymentMethodCode = json['payment_method_code'];
    money = double.tryParse((json['money'] ?? 0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    data['payment_method_code'] = this.paymentMethodCode;
    data['money'] = this.money;
    return data;
  }
}