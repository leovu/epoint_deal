class TimekeepingShiftResponseModel {
  int? branchId;
  String? branchName;
  int? timeWorkingStaffId;
  String? workingDay;
  String? workingTime;
  String? workingEndDay;
  String? workingEndTime;
  int? shiftId;
  String? shiftName;
  String? startWorkTime;
  String? endWorkTime;
  int? isCheckIn;
  int? isCheckOut;
  int? checkInLogId;
  String? checkInDay;
  String? checkInTime;
  double? numberLateTime;
  int? checkOutLogId;
  String? checkOutDay;
  String? checkOutTime;
  double? numberTimeBackSoon;
  String? message;
  String? wifiName;

  TimekeepingShiftResponseModel(
      {this.branchId,
        this.branchName,
        this.timeWorkingStaffId,
        this.workingDay,
        this.workingTime,
        this.workingEndDay,
        this.workingEndTime,
        this.shiftId,
        this.shiftName,
        this.startWorkTime,
        this.endWorkTime,
        this.isCheckIn,
        this.isCheckOut,
        this.checkInLogId,
        this.checkInDay,
        this.checkInTime,
        this.numberLateTime,
        this.checkOutLogId,
        this.checkOutDay,
        this.checkOutTime,
        this.numberTimeBackSoon,
        this.message,
        this.wifiName});

  TimekeepingShiftResponseModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    timeWorkingStaffId = json['time_working_staff_id'];
    workingDay = json['working_day'];
    workingTime = json['working_time'];
    workingEndDay = json['working_end_day'];
    workingEndTime = json['working_end_time'];
    shiftId = json['shift_id'];
    shiftName = json['shift_name'];
    startWorkTime = json['start_work_time'];
    endWorkTime = json['end_work_time'];
    isCheckIn = json['is_check_in'];
    isCheckOut = json['is_check_out'];
    checkInLogId = json['check_in_log_id'];
    checkInDay = json['check_in_day'];
    checkInTime = json['check_in_time'];
    numberLateTime = json['number_late_time'] == null? null: double.tryParse(json['number_late_time'].toString());
    checkOutLogId = json['check_out_log_id'];
    checkOutDay = json['check_out_day'];
    checkOutTime = json['check_out_time'];
    numberTimeBackSoon = json['number_time_back_soon'] == null? null: double.tryParse(json['number_time_back_soon'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['time_working_staff_id'] = this.timeWorkingStaffId;
    data['working_day'] = this.workingDay;
    data['working_time'] = this.workingTime;
    data['working_end_day'] = this.workingEndDay;
    data['working_end_time'] = this.workingEndTime;
    data['shift_id'] = this.shiftId;
    data['shift_name'] = this.shiftName;
    data['start_work_time'] = this.startWorkTime;
    data['end_work_time'] = this.endWorkTime;
    data['is_check_in'] = this.isCheckIn;
    data['is_check_out'] = this.isCheckOut;
    data['check_in_log_id'] = this.checkInLogId;
    data['check_in_day'] = this.checkInDay;
    data['check_in_time'] = this.checkInTime;
    data['number_late_time'] = this.numberLateTime;
    data['check_out_log_id'] = this.checkOutLogId;
    data['check_out_day'] = this.checkOutDay;
    data['check_out_time'] = this.checkOutTime;
    data['number_time_back_soon'] = this.numberTimeBackSoon;
    return data;
  }
}