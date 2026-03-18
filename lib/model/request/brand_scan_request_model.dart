class BrandScanRequestModel {
  String? brandCustomerCode;

  BrandScanRequestModel({this.brandCustomerCode});

  BrandScanRequestModel.fromJson(Map<String, dynamic> json) {
    brandCustomerCode = json['brand_customer_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_customer_code'] = this.brandCustomerCode;
    return data;
  }
}
