class TimeoffdaysShiftsListResponseModel {
  List<TimeoffdaysShiftsListModel>? data;

  TimeoffdaysShiftsListResponseModel({this.data});

  TimeoffdaysShiftsListResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TimeoffdaysShiftsListModel>[];
      json.forEach((v) {
        data!.add(new TimeoffdaysShiftsListModel.fromJson(v));
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

class TimeoffdaysShiftsListModel {
  int? timeWorkingStaffId;
  String? shiftName;
  bool? selected;

  TimeoffdaysShiftsListModel({this.timeWorkingStaffId, this.shiftName});

  TimeoffdaysShiftsListModel.fromJson(Map<String, dynamic> json) {
    timeWorkingStaffId = json['time_working_staff_id'];
    shiftName = json['shift_name'];
    selected = true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_working_staff_id'] = this.timeWorkingStaffId;
    data['shift_name'] = this.shiftName;
    return data;
  }
}
