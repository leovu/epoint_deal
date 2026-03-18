class StatusVNPayResponseModel {
  String? objectType;
  int? objectId;
  String? paymentTransactionCode;
  int? status;

  StatusVNPayResponseModel(
      {this.objectType,
        this.objectId,
        this.paymentTransactionCode,
        this.status});

  StatusVNPayResponseModel.fromJson(Map<String, dynamic> json) {
    objectType = json['object_type'];
    objectId = json['object_id'];
    paymentTransactionCode = json['payment_transaction_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    data['payment_transaction_code'] = this.paymentTransactionCode;
    data['status'] = this.status;
    return data;
  }
}