class TimeOffDaysLogResponseModel {
  List<TimeOffDaysLogModel>? data;

  TimeOffDaysLogResponseModel({this.data});

  TimeOffDaysLogResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TimeOffDaysLogModel>[];
      json.forEach((v) {
        data!.add(new TimeOffDaysLogModel.fromJson(v));
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

class TimeOffDaysLogModel {
  int? timeOffDaysLogId;
  String? timeOffDaysAction;
  String? timeOffDaysContent;
  int? timeOffDaysId;
  String? createdAt;

  TimeOffDaysLogModel(
      {this.timeOffDaysLogId,
        this.timeOffDaysAction,
        this.timeOffDaysContent,
        this.timeOffDaysId,
        this.createdAt});

  TimeOffDaysLogModel.fromJson(Map<String, dynamic> json) {
    timeOffDaysLogId = json['time_off_days_log_id'];
    timeOffDaysAction = json['time_off_days_action'];
    timeOffDaysContent = json['time_off_days_content'];
    timeOffDaysId = json['time_off_days_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_off_days_log_id'] = this.timeOffDaysLogId;
    data['time_off_days_action'] = this.timeOffDaysAction;
    data['time_off_days_content'] = this.timeOffDaysContent;
    data['time_off_days_id'] = this.timeOffDaysId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
