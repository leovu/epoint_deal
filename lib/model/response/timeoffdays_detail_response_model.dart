import 'package:epoint_deal_plugin/model/response/timeoffdays_shifts_list_response_model.dart';
import 'package:epoint_deal_plugin/model/response/timeoffdays_staffs_list_response_model.dart';

class TimeoffdaysDetailResponseModel {
  int? timeOffDaysId;
  int? timeOffTypeId;
  String? timeOffTypeCode;
  String? timeOffTypeDescription;
  String? timeOffDaysStart;
  String? timeOffDaysEnd;
  String? timeOffNote;
  String? createdAt;
  int? timeOffDaysTime;
  String? timeOffDaysTimeText;
  String? timeOffTypeName;
  int? isApprovce;
  String? staffAvatar;
  String? fullName;
  String? departmentName;
  String? dateTypeSelect;
  int? isUpdate;
  List<TimeOffDaysFilesModel>? timeOffDaysFiles;
  List<TimeoffdaysShiftsListModel>? timeOffDaysShifts;
  List<TimeoffdaysStaffsListModel>? staffs;

  TimeoffdaysDetailResponseModel(
      {this.timeOffDaysId,
        this.timeOffTypeId,
        this.timeOffTypeCode,
        this.timeOffTypeDescription,
        this.timeOffDaysStart,
        this.timeOffDaysEnd,
        this.timeOffNote,
        this.createdAt,
        this.timeOffDaysTime,
        this.timeOffDaysTimeText,
        this.timeOffTypeName,
        this.isApprovce,
        this.staffAvatar,
        this.fullName,
        this.departmentName,
        this.dateTypeSelect,
        this.isUpdate,
        this.timeOffDaysFiles,
        this.timeOffDaysShifts,
        this.staffs});

  TimeoffdaysDetailResponseModel.fromJson(Map<String, dynamic> json) {
    timeOffDaysId = json['time_off_days_id'];
    timeOffTypeId = json['time_off_type_id'];
    timeOffTypeCode = json['time_off_type_code'];
    timeOffTypeDescription = json['time_off_type_description'];
    timeOffDaysStart = json['time_off_days_start'];
    timeOffDaysEnd = json['time_off_days_end'];
    timeOffNote = json['time_off_note'];
    createdAt = json['created_at'];
    timeOffDaysTime = json['time_off_days_time'];
    timeOffDaysTimeText = json['time_off_days_time_text'];
    timeOffTypeName = json['time_off_type_name'];
    isApprovce = json['is_approvce'];
    staffAvatar = json['staff_avatar'];
    fullName = json['full_name'];
    departmentName = json['department_name'];
    dateTypeSelect = json['date_type_select'];
    isUpdate = json['is_update'];
    if (json['time_off_days_files'] != null) {
      timeOffDaysFiles = <TimeOffDaysFilesModel>[];
      json['time_off_days_files'].forEach((v) {
        timeOffDaysFiles!.add(new TimeOffDaysFilesModel.fromJson(v));
      });
    }
    if (json['time_off_days_shifts'] != null) {
      timeOffDaysShifts = <TimeoffdaysShiftsListModel>[];
      json['time_off_days_shifts'].forEach((v) {
        timeOffDaysShifts!.add(new TimeoffdaysShiftsListModel.fromJson(v));
      });
    }
    if (json['staffs'] != null) {
      staffs = <TimeoffdaysStaffsListModel>[];
      json['staffs'].forEach((v) {
        staffs!.add(new TimeoffdaysStaffsListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_off_days_id'] = this.timeOffDaysId;
    data['time_off_type_id'] = this.timeOffTypeId;
    data['time_off_type_code'] = this.timeOffTypeCode;
    data['time_off_type_description'] = this.timeOffTypeDescription;
    data['time_off_days_start'] = this.timeOffDaysStart;
    data['time_off_days_end'] = this.timeOffDaysEnd;
    data['time_off_note'] = this.timeOffNote;
    data['created_at'] = this.createdAt;
    data['time_off_days_time'] = this.timeOffDaysTime;
    data['time_off_days_time_text'] = this.timeOffDaysTimeText;
    data['time_off_type_name'] = this.timeOffTypeName;
    data['is_approvce'] = this.isApprovce;
    data['staff_avatar'] = this.staffAvatar;
    data['full_name'] = this.fullName;
    data['department_name'] = this.departmentName;
    data['date_type_select'] = this.dateTypeSelect;
    data['is_update'] = this.isUpdate;
    if (this.timeOffDaysFiles != null) {
      data['time_off_days_files'] =
          this.timeOffDaysFiles!.map((v) => v.toJson()).toList();
    }
    if (this.timeOffDaysShifts != null) {
      data['time_off_days_shifts'] =
          this.timeOffDaysShifts!.map((v) => v.toJson()).toList();
    }
    if (this.staffs != null) {
      data['staffs'] = this.staffs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeOffDaysFilesModel {
  int? timeOffDaysFilesId;
  String? timeOffDaysFilesName;
  int? timeOffDaysId;

  TimeOffDaysFilesModel(
      {this.timeOffDaysFilesId, this.timeOffDaysFilesName, this.timeOffDaysId});

  TimeOffDaysFilesModel.fromJson(Map<String, dynamic> json) {
    timeOffDaysFilesId = json['time_off_days_files_id'];
    timeOffDaysFilesName = json['time_off_days_files_name'];
    timeOffDaysId = json['time_off_days_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_off_days_files_id'] = this.timeOffDaysFilesId;
    data['time_off_days_files_name'] = this.timeOffDaysFilesName;
    data['time_off_days_id'] = this.timeOffDaysId;
    return data;
  }
}