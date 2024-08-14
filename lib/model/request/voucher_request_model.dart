class CheckVoucherRequestModel {
  String? brandCode;
  int? customerId;
  String? totalAmount;
  String? voucherCode;
  List<ArrObject>? arrObject;
  String? objectType;

  CheckVoucherRequestModel(
      {this.brandCode,
        this.customerId,
        this.totalAmount,
        this.voucherCode,
        this.arrObject,
        this.objectType});

  CheckVoucherRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    customerId = json['customer_id'];
    totalAmount = json['total_amount'];
    voucherCode = json['voucher_code'];
    if (json['arr_object'] != null) {
      arrObject = <ArrObject>[];
      json['arr_object'].forEach((v) {
        arrObject!.add(new ArrObject.fromJson(v));
      });
    }
    objectType = json['object_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['customer_id'] = this.customerId;
    data['total_amount'] = this.totalAmount;
    data['voucher_code'] = this.voucherCode;
    if (this.arrObject != null) {
      data['arr_object'] = this.arrObject!.map((v) => v.toJson()).toList();
    }
    data['object_type'] = this.objectType;
    return data;
  }
}

class ArrObject {
  int? objectId;
  String? objectType;

  ArrObject({this.objectId, this.objectType});

  ArrObject.fromJson(Map<String, dynamic> json) {
    objectId = json['object_id'];
    objectType = json['object_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_id'] = this.objectId;
    data['object_type'] = this.objectType;
    return data;
  }
}