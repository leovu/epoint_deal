class TimeoffdaysCreateRequestModel {
  int? timeOffDaysId;
  int? timeOffTypeId;
  String? timeOffDaysStart;
  String? timeOffDaysEnd;
  int? timeOffDaysTime;
  String? timeOffNote;
  List<String?>? timeOffDaysFiles;
  List<String>? timeOffDaysShift;
  String? dateTypeSelect;

  TimeoffdaysCreateRequestModel(
      {this.timeOffDaysId,
        this.timeOffTypeId,
        this.timeOffDaysStart,
        this.timeOffDaysEnd,
        this.timeOffDaysTime,
        this.timeOffNote,
        this.timeOffDaysFiles,
        this.timeOffDaysShift,
        this.dateTypeSelect});

  TimeoffdaysCreateRequestModel.fromJson(Map<String, dynamic> json) {
    timeOffDaysId = json['time_off_days_id'];
    timeOffTypeId = json['time_off_type_id'];
    timeOffDaysStart = json['time_off_days_start'];
    timeOffDaysEnd = json['time_off_days_end'];
    timeOffDaysTime = json['time_off_days_time'];
    timeOffNote = json['time_off_note'];
    timeOffDaysFiles = json['time_off_days_files'].cast<String>();
    timeOffDaysShift = json['time_off_days_shift'].cast<String>();
    dateTypeSelect = json['date_type_select'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_off_days_id'] = this.timeOffDaysId;
    data['time_off_type_id'] = this.timeOffTypeId;
    data['time_off_days_start'] = this.timeOffDaysStart;
    data['time_off_days_end'] = this.timeOffDaysEnd;
    data['time_off_days_time'] = this.timeOffDaysTime;
    data['time_off_note'] = this.timeOffNote;
    data['time_off_days_files'] = this.timeOffDaysFiles;
    data['time_off_days_shift'] = this.timeOffDaysShift;
    data['date_type_select'] = this.dateTypeSelect;
    return data;
  }
}