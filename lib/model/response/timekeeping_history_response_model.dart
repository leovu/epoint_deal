

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class TimekeepingHistoryResponseModel {
  PageInfoModel? pageInfo;
  List<TimekeepingHistoryModel?>? items;

  TimekeepingHistoryResponseModel({this.pageInfo, this.items});

  TimekeepingHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <TimekeepingHistoryModel?>[];
      json['Items'].forEach((v) {
        items!.add(new TimekeepingHistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class TimekeepingHistoryModel {
  String? timekeepingDate;
  int? checkInTotal;
  int? checkOutTotal;
  int? checkInCount;
  int? checkOutCount;
  List<TimekeepingLogsModel>? timekeepingLogs;
  String? backGround;
  bool? expand;

  TimekeepingHistoryModel(
      {this.timekeepingDate,
        this.checkInTotal,
        this.checkOutTotal,
        this.checkInCount,
        this.checkOutCount,
        this.timekeepingLogs,
        this.backGround});

  TimekeepingHistoryModel.fromJson(Map<String, dynamic> json) {
    timekeepingDate = json['timekeeping_date'];
    checkInTotal = json['check_in_total'];
    checkOutTotal = json['check_out_total'];
    checkInCount = json['check_in_count'];
    checkOutCount = json['check_out_count'];
    if (json['timekeeping_logs'] != null) {
      timekeepingLogs = <TimekeepingLogsModel>[];
      json['timekeeping_logs'].forEach((v) {
        timekeepingLogs!.add(new TimekeepingLogsModel.fromJson(v));
      });
    }
    backGround = json['back_ground'];
    expand = (timekeepingLogs?.length ?? 0) == 0? false: true;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timekeeping_date'] = this.timekeepingDate;
    data['check_in_total'] = this.checkInTotal;
    data['check_out_total'] = this.checkOutTotal;
    data['check_in_count'] = this.checkInCount;
    data['check_out_count'] = this.checkOutCount;
    if (this.timekeepingLogs != null) {
      data['timekeeping_logs'] =
          this.timekeepingLogs!.map((v) => v.toJson()).toList();
    }
    data['back_ground'] = this.backGround;
    return data;
  }
}

class TimekeepingLogsModel {
  int? shiftId;
  String? shiftName;
  String? startWorkTime;
  String? endWorkTime;
  String? workingDay;
  String? workingTime;
  String? workingEndDay;
  String? workingEndTime;
  String? checkInDay;
  String? checkInTime;
  int? staffId;
  String? fullName;
  String? staffAvatar;
  String? checkOutDay;
  String? checkOutTime;
  double? numberLateTime;
  double? numberTimeBackSoon;
  String? createdType;
  int? isCheckIn;
  int? isCheckOut;
  String? typeCheckIn;
  String? typeCheckOut;
  String? backGround;
  int? isOt;

  TimekeepingLogsModel(
      {this.shiftId,
        this.shiftName,
        this.startWorkTime,
        this.endWorkTime,
        this.workingDay,
        this.workingTime,
        this.workingEndDay,
        this.workingEndTime,
        this.checkInDay,
        this.checkInTime,
        this.staffId,
        this.fullName,
        this.staffAvatar,
        this.checkOutDay,
        this.checkOutTime,
        this.numberLateTime,
        this.numberTimeBackSoon,
        this.createdType,
        this.isCheckIn,
        this.isCheckOut,
        this.typeCheckIn,
        this.typeCheckOut,
        this.backGround,
        this.isOt});

  TimekeepingLogsModel.fromJson(Map<String, dynamic> json) {
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startWorkTime = json['start_work_time'];
    endWorkTime = json['end_work_time'];
    workingDay = json['working_day'];
    workingTime = json['working_time'];
    workingEndDay = json['working_end_day'];
    workingEndTime = json['working_end_time'];
    checkInDay = json['check_in_day'];
    checkInTime = json['check_in_time'];
    staffId = json['staff_id'];
    fullName = json['full_name'];
    staffAvatar = json['staff_avatar'];
    checkOutDay = json['check_out_day'];
    checkOutTime = json['check_out_time'];
    numberLateTime = json['number_late_time'] == null? null: double.tryParse(json['number_late_time'].toString());
    numberTimeBackSoon = json['number_time_back_soon'] == null? null: double.tryParse(json['number_time_back_soon'].toString());
    createdType = json['created_type'];
    isCheckIn = json['is_check_in'];
    isCheckOut = json['is_check_out'];
    typeCheckIn = json['type_check_in'];
    typeCheckOut = json['type_check_out'];
    backGround = json['back_ground'];
    isOt = json['is_ot'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['start_work_time'] = this.startWorkTime;
    data['end_work_time'] = this.endWorkTime;
    data['working_day'] = this.workingDay;
    data['working_time'] = this.workingTime;
    data['working_end_day'] = this.workingEndDay;
    data['working_end_time'] = this.workingEndTime;
    data['check_in_day'] = this.checkInDay;
    data['check_in_time'] = this.checkInTime;
    data['staff_id'] = this.staffId;
    data['full_name'] = this.fullName;
    data['staff_avatar'] = this.staffAvatar;
    data['check_out_day'] = this.checkOutDay;
    data['check_out_time'] = this.checkOutTime;
    data['number_late_time'] = this.numberLateTime;
    data['number_time_back_soon'] = this.numberTimeBackSoon;
    data['created_type'] = this.createdType;
    data['is_check_in'] = this.isCheckIn;
    data['is_check_out'] = this.isCheckOut;
    data['type_check_in'] = this.typeCheckIn;
    data['type_check_out'] = this.typeCheckOut;
    data['back_ground'] = this.backGround;
    data['is_ot'] = this.isOt;
    return data;
  }
}