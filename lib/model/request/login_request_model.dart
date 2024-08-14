class LoginRequestModel {
  String? userName;
  String? password;
  String? platform;
  String? deviceToken;
  String? imei;
  String? brandName;
  String? brandCode;

  LoginRequestModel(
      {this.userName,
        this.password,
        this.platform,
        this.deviceToken,
        this.imei,
        this.brandName,
        this.brandCode});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    password = json['password'];
    platform = json['platform'];
    deviceToken = json['device_token'];
    imei = json['imei'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['platform'] = this.platform;
    data['device_token'] = this.deviceToken;
    data['imei'] = this.imei;
    data['brand_code'] = this.brandCode;
    return data;
  }
}