class CreateQRCodeResponseModel {
  VnPayModel? vnPay;

  CreateQRCodeResponseModel({this.vnPay});

  CreateQRCodeResponseModel.fromJson(Map<String, dynamic> json) {
    vnPay = json['vn_pay'] != null ? new VnPayModel.fromJson(json['vn_pay']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.vnPay != null) {
      data['vn_pay'] = this.vnPay!.toJson();
    }
    return data;
  }
}

class VnPayModel {
  String? paymentTransactionCode;
  String? paymentTransactionUuid;
  String? paymentUrl;
  String? tmnCode;
  String? objectType;
  int? objectId;

  VnPayModel(
      {this.paymentTransactionCode,
        this.paymentTransactionUuid,
        this.paymentUrl,
        this.tmnCode,
        this.objectType,
        this.objectId});

  VnPayModel.fromJson(Map<String, dynamic> json) {
    paymentTransactionCode = json['payment_transaction_code'];
    paymentTransactionUuid = json['payment_transaction_uuid'];
    paymentUrl = json['payment_url'];
    tmnCode = json['Tmn_Code'];
    objectType = json['object_type'];
    objectId = json['object_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_transaction_code'] = this.paymentTransactionCode;
    data['payment_transaction_uuid'] = this.paymentTransactionUuid;
    data['payment_url'] = this.paymentUrl;
    data['Tmn_Code'] = this.tmnCode;
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    return data;
  }
}