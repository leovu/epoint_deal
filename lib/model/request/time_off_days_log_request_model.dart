class TimeOffDaysLogRequestModel {
  int? timeOffDaysId;

  TimeOffDaysLogRequestModel({this.timeOffDaysId});

  TimeOffDaysLogRequestModel.fromJson(Map<String, dynamic> json) {
    timeOffDaysId = json['time_off_days_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_off_days_id'] = this.timeOffDaysId;
    return data;
  }
}
