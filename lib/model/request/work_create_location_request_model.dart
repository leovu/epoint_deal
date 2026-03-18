class WorkCreateLocationRequestModel {
  int? manageWorkId;
  String? lat;
  String? lng;
  String? description;

  WorkCreateLocationRequestModel({this.manageWorkId, this.lat, this.lng, this.description});

  WorkCreateLocationRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    lat = json['lat'];
    lng = json['lng'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['description'] = this.description;
    return data;
  }
}
