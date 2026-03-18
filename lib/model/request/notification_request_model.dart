class NotificationRequestModel {
  int? page;
  String? brandCode;

  NotificationRequestModel({this.page, this.brandCode});

  NotificationRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['brand_code'] = this.brandCode;
    return data;
  }
}