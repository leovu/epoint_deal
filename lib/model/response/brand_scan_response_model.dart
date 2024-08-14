class BrandScanResponseModel {
  int? brandId;
  String? brandName;
  String? brandCode;
  String? clientKey;
  String? logo;

  BrandScanResponseModel({this.brandId, this.brandName, this.brandCode, this.clientKey, this.logo});

  BrandScanResponseModel.fromJson(Map<String, dynamic> json) {
    brandId = json['brand_id'];
    brandName = json['brand_name'];
    brandCode = json['brand_code'];
    clientKey = json['client_key'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_id'] = this.brandId;
    data['brand_name'] = this.brandName;
    data['brand_code'] = this.brandCode;
    data['client_key'] = this.clientKey;
    data['logo'] = this.logo;
    return data;
  }
}
