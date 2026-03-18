class BranchResponseModel {
  List<BranchModel>? data;

  BranchResponseModel({this.data});

  BranchResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <BranchModel>[];
      json.forEach((v) {
        data!.add(new BranchModel.fromJson(v));
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

class BranchModel {
  int? branchId;
  String? branchName;
  int? isRepresentative;
  String? provinceName;
  String? districtName;
  String? wardName;
  String? address;
  String? latitude;
  String? longitude;
  String? fullAddress;
  bool? selected;

  BranchModel(
      {this.branchId,
        this.branchName,
        this.isRepresentative,
        this.provinceName,
        this.districtName,
        this.wardName,
        this.address,
        this.latitude,
        this.longitude,
        this.fullAddress});

  BranchModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    isRepresentative = json['is_representative'];
    provinceName = json['province_name'];
    districtName = json['district_name'];
    wardName = json['ward_name'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    fullAddress = json['full_address'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['is_representative'] = this.isRepresentative;
    data['province_name'] = this.provinceName;
    data['district_name'] = this.districtName;
    data['ward_name'] = this.wardName;
    data['address'] = this.address;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['full_address'] = this.fullAddress;
    return data;
  }
}