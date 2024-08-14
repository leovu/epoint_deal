class CheckVersionRequestModel {
  String? platform;
  String? version;
  String? releaseDate;

  CheckVersionRequestModel({this.platform, this.version, this.releaseDate});

  CheckVersionRequestModel.fromJson(Map<String, dynamic> json) {
    platform = json['platform'];
    version = json['version'];
    releaseDate = json['release_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['platform'] = this.platform;
    data['version'] = this.version;
    data['release_date'] = this.releaseDate;
    return data;
  }
}