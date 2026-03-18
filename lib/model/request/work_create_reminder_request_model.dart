class WorkCreateReminderRequestModel {
  List<WorkCreateReminderStaffModel>? listStaff;
  String? dateRemind;
  int? time;
  String? timeType;
  String? description;
  int? manageWorkId;

  WorkCreateReminderRequestModel(
      {this.listStaff,
        this.dateRemind,
        this.time,
        this.timeType,
        this.description,
        this.manageWorkId});

  WorkCreateReminderRequestModel.fromJson(Map<String, dynamic> json) {
    if (json['list_staff'] != null) {
      listStaff = <WorkCreateReminderStaffModel>[];
      json['list_staff'].forEach((v) {
        listStaff!.add(new WorkCreateReminderStaffModel.fromJson(v));
      });
    }
    dateRemind = json['date_remind'];
    time = json['time'];
    timeType = json['time_type'];
    description = json['description'];
    manageWorkId = json['manage_work_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.listStaff != null) {
      data['list_staff'] = this.listStaff!.map((v) => v.toJson()).toList();
    }
    data['date_remind'] = this.dateRemind;
    data['time'] = this.time;
    data['time_type'] = this.timeType;
    data['description'] = this.description;
    if(this.manageWorkId != null) data['manage_work_id'] = this.manageWorkId;
    return data;
  }
}

class WorkCreateReminderStaffModel {
  int? staffId;
  String? staffName;
  String? staffAvatar;

  WorkCreateReminderStaffModel({this.staffId, this.staffName, this.staffAvatar});

  WorkCreateReminderStaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    return data;
  }
}