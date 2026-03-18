class RefreshTokenRequestModel {
  String? brandCode;
  String? refreshToken;
  String? imei;
  String? platform;
  String? deviceToken;

  RefreshTokenRequestModel(
      {this.brandCode,
        this.refreshToken,
        this.imei,
        this.platform,
        this.deviceToken});

  RefreshTokenRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    refreshToken = json['refresh_token'];
    imei = json['imei'];
    platform = json['platform'];
    deviceToken = json['device_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['refresh_token'] = this.refreshToken;
    data['imei'] = this.imei;
    data['platform'] = this.platform;
    data['device_token'] = this.deviceToken;
    return data;
  }
}