class TimeoffdaysShiftsListRequestModel {
  String? workingDayStart;
  String? workingDayEnd;

  TimeoffdaysShiftsListRequestModel({this.workingDayStart, this.workingDayEnd});

  TimeoffdaysShiftsListRequestModel.fromJson(Map<String, dynamic> json) {
    workingDayStart = json['working_day_start'];
    workingDayEnd = json['working_day_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['working_day_start'] = this.workingDayStart;
    data['working_day_end'] = this.workingDayEnd;
    return data;
  }
}
