class TimekeepingUpdateGPSRequestModel {
  int? id;
  String? type;
  String? latitude;
  String? longitude;

  TimekeepingUpdateGPSRequestModel({this.id, this.type, this.latitude, this.longitude});

  TimekeepingUpdateGPSRequestModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}
