class StatusVNPayRequestModel {
  String? paymentTransactionCode;

  StatusVNPayRequestModel({this.paymentTransactionCode});

  StatusVNPayRequestModel.fromJson(Map<String, dynamic> json) {
    paymentTransactionCode = json['payment_transaction_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_transaction_code'] = this.paymentTransactionCode;
    return data;
  }
}