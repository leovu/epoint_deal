class WardRequestModel {
  int? districtId;

  WardRequestModel({this.districtId});

  WardRequestModel.fromJson(Map<String, dynamic> json) {
    districtId = json['district_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['district_id'] = this.districtId;
    return data;
  }
}
