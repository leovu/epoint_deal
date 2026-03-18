class TimeoffdaysActivityRequestModel {
  int? timeOffDaysId;
  int? isApprovce;
  String? timeOffDaysActivityApproveNote;

  TimeoffdaysActivityRequestModel(
      {this.timeOffDaysId,
        this.isApprovce,
        this.timeOffDaysActivityApproveNote});

  TimeoffdaysActivityRequestModel.fromJson(Map<String, dynamic> json) {
    timeOffDaysId = json['time_off_days_id'];
    isApprovce = json['is_approvce'];
    timeOffDaysActivityApproveNote =
    json['time_off_days_activity_approve_note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_off_days_id'] = this.timeOffDaysId;
    data['is_approvce'] = this.isApprovce;
    data['time_off_days_activity_approve_note'] =
        this.timeOffDaysActivityApproveNote;
    return data;
  }
}
