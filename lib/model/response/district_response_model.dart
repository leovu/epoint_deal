class DistrictResponseModel {
  List<DistrictModel>? data;

  DistrictResponseModel({this.data});

  DistrictResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <DistrictModel>[];
      json.forEach((v) {
        data!.add(new DistrictModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DistrictModel {
  int? districtid;
  String? name;
  bool? selected;

  DistrictModel({this.districtid, this.name});

  DistrictModel.fromJson(Map<String, dynamic> json) {
    districtid = json['districtid'];
    name = json['name'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['districtid'] = this.districtid;
    data['name'] = this.name;
    return data;
  }
}