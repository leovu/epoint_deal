class LogoutRequestModel {
  String? brandCode;
  String? platform;
  String? imei;

  LogoutRequestModel({this.brandCode, this.platform, this.imei});

  LogoutRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    platform = json['platform'];
    imei = json['imei'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['platform'] = this.platform;
    data['imei'] = this.imei;
    return data;
  }
}