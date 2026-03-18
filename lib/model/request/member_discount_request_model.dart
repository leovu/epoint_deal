class MemberDiscountRequestModel {
  double? amount;
  int? customerId;
  String? brandCode;

  MemberDiscountRequestModel({this.amount, this.customerId, this.brandCode});

  MemberDiscountRequestModel.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    customerId = json['customer_id'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['customer_id'] = this.customerId;
    data['brand_code'] = this.brandCode;
    return data;
  }
}