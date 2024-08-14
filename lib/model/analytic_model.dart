class AnalyticModel {
  String? userName;
  String? fullName;
  int? userId;
  String? brandCode;
  String? branchCode;
  String? screenName;

  AnalyticModel({this.userName, this.fullName, this.userId, this.brandCode, this.branchCode, this.screenName});

  AnalyticModel.fromJson(Map<String, dynamic> json) {
    userName = json['user_name'];
    fullName = json['full_name'];
    userId = json['user_id'];
    brandCode = json['brand_code'];
    branchCode = json['branch_code'];
    screenName = json['screen_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_name'] = this.userName;
    data['full_name'] = this.fullName;
    data['user_id'] = this.userId;
    data['brand_code'] = this.brandCode;
    data['branch_code'] = this.branchCode;
    data['screen_name'] = this.screenName;
    return data;
  }
}
