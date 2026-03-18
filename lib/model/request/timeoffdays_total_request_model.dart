class TimeoffdaysTotalRequestModel {
  int? timeOffTypeId;

  TimeoffdaysTotalRequestModel({this.timeOffTypeId});

  TimeoffdaysTotalRequestModel.fromJson(Map<String, dynamic> json) {
    timeOffTypeId = json['time_off_type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_off_type_id'] = this.timeOffTypeId;
    return data;
  }
}
