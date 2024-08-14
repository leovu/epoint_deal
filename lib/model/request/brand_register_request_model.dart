class BrandRegisterRequestModel {
  String? brandName;
  String? fullName;
  String? email;
  String? phone;

  BrandRegisterRequestModel({this.brandName, this.fullName, this.email, this.phone});

  BrandRegisterRequestModel.fromJson(Map<String, dynamic> json) {
    brandName = json['brand_name'];
    fullName = json['full_name'];
    email = json['email'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_name'] = this.brandName;
    data['full_name'] = this.fullName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    return data;
  }
}
