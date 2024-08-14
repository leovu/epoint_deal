class ProvinceResponseModel {
  List<ProvinceModel>? data;

  ProvinceResponseModel({this.data});

  ProvinceResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProvinceModel>[];
      json.forEach((v) {
        data!.add(new ProvinceModel.fromJson(v));
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

class ProvinceModel {
  int? provinceid;
  String? name;
  bool? selected;

  ProvinceModel({this.provinceid, this.name});

  ProvinceModel.fromJson(Map<String, dynamic> json) {
    provinceid = json['provinceid'];
    name = json['name'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['provinceid'] = this.provinceid;
    data['name'] = this.name;
    return data;
  }
}