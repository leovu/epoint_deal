import 'timeoffdays_staffs_list_response_model.dart';

class TimeoffdaysSearchResponseModel {
  int? currentPage;
  List<TimeoffdaysSearchModel>? data;
  int? lastPage;
  bool? enableLoadmore;

  TimeoffdaysSearchResponseModel(
      {this.currentPage,
        this.data,
        this.lastPage,
        this.enableLoadmore = false});

  TimeoffdaysSearchResponseModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TimeoffdaysSearchModel>[];
      json['data'].forEach((v) {
        data!.add(new TimeoffdaysSearchModel.fromJson(v));
      });
    }
    lastPage = json['last_page'];
    enableLoadmore = (currentPage ?? 0) < (lastPage ?? 0);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = this.lastPage;
    return data;
  }
}

class TimeoffdaysSearchModel {
  int? timeOffDaysId;
  int? timeOffTypeId;
  String? timeOffDaysStart;
  String? timeOffDaysEnd;
  int? timeOffDaysTime;
  String? timeOffDaysTimeText;
  String? timeOffNote;
  String? createdAt;
  int? isApprovce;
  int? isUpdate;
  String? staffAvatar;
  String? fullName;
  String? timeOffTypeName;
  String? departmentName;
  List<TimeoffdaysStaffsListModel>? staff;

  TimeoffdaysSearchModel(
      {this.timeOffDaysId,
        this.timeOffTypeId,
        this.timeOffDaysStart,
        this.timeOffDaysEnd,
        this.timeOffDaysTime,
        this.timeOffDaysTimeText,
        this.timeOffNote,
        this.createdAt,
        this.isApprovce,
        this.isUpdate,
        this.staffAvatar,
        this.fullName,
        this.timeOffTypeName,
        this.departmentName,
        this.staff});

  TimeoffdaysSearchModel.fromJson(Map<String, dynamic> json) {
    timeOffDaysId = json['time_off_days_id'];
    timeOffTypeId = json['time_off_type_id'];
    timeOffDaysStart = json['time_off_days_start'];
    timeOffDaysEnd = json['time_off_days_end'];
    timeOffDaysTime = json['time_off_days_time'];
    timeOffDaysTimeText = json['time_off_days_time_text'];
    timeOffNote = json['time_off_note'];
    createdAt = json['created_at'];
    isUpdate = json['is_update'];
    isApprovce = json['is_approvce'];
    staffAvatar = json['staff_avatar'];
    fullName = json['full_name'];
    timeOffTypeName = json['time_off_type_name'];
    departmentName = json['department_name'];
    if (json['staff'] != null) {
      staff = <TimeoffdaysStaffsListModel>[];
      json['staff'].forEach((v) {
        staff!.add(new TimeoffdaysStaffsListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_off_days_id'] = this.timeOffDaysId;
    data['time_off_type_id'] = this.timeOffTypeId;
    data['time_off_days_start'] = this.timeOffDaysStart;
    data['time_off_days_end'] = this.timeOffDaysEnd;
    data['time_off_days_time_text'] = this.timeOffDaysTimeText;
    data['time_off_days_time'] = this.timeOffDaysTime;
    data['time_off_note'] = this.timeOffNote;
    data['created_at'] = this.createdAt;
    data['is_approvce'] = this.isApprovce;
    data['is_update'] = this.isUpdate;
    data['staff_avatar'] = this.staffAvatar;
    data['full_name'] = this.fullName;
    data['time_off_type_name'] = this.timeOffTypeName;
    data['department_name'] = this.departmentName;
    if (this.staff != null) {
      data['staff'] = this.staff!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}