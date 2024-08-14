class CustomerStaffTitleRequestModel {
  String? brandCode;

  CustomerStaffTitleRequestModel({this.brandCode});

  CustomerStaffTitleRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    return data;
  }
}
