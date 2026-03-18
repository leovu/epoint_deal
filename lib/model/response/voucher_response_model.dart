class CheckVoucherResponseModel {
  String? voucherCode;
  double? discount;

  CheckVoucherResponseModel({this.voucherCode, this.discount});

  CheckVoucherResponseModel.fromJson(Map<String, dynamic> json) {
    voucherCode = json['voucher_code'];
    discount = double.tryParse(json['discount'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voucher_code'] = this.voucherCode;
    data['discount'] = this.discount;
    return data;
  }
}
