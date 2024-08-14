class TimeoffdaysSearchRequestModel {
  int? page;
  List<int?>? timeOffTypeId;
  List<int>? isApprovce;
  String? timeOffDaysStart;
  String? timeOffDaysEnd;
  int? createdBy;

  TimeoffdaysSearchRequestModel(
      {this.page,
        this.timeOffTypeId,
        this.isApprovce,
        this.timeOffDaysStart,
        this.timeOffDaysEnd,
        this.createdBy});

  TimeoffdaysSearchRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    timeOffTypeId = json['time_off_type_id']?.cast<int>();
    isApprovce = json['is_approvce']?.cast<int>();
    timeOffDaysStart = json['time_off_days_start'];
    timeOffDaysEnd = json['time_off_days_end'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['time_off_type_id'] = this.timeOffTypeId;
    data['is_approvce'] = this.isApprovce;
    data['time_off_days_start'] = this.timeOffDaysStart;
    data['time_off_days_end'] = this.timeOffDaysEnd;
    data['created_by'] = this.createdBy;
    return data;
  }
}
