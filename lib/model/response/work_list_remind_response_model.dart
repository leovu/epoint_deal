class WorkListRemindResponseModel {
  List<WorkListRemindModel>? data;

  WorkListRemindResponseModel({this.data});

  WorkListRemindResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListRemindModel>[];
      json.forEach((v) {
        data!.add(new WorkListRemindModel.fromJson(v));
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

class WorkListRemindModel {
  int? manageRemindId;
  int? manageWorkId;
  String? title;
  String? dateRemind;
  String? description;
  String? staffName;
  String? staffAvatar;
  int? isSent;
  bool? isSelected;

  WorkListRemindModel({
    this.manageRemindId,
    this.manageWorkId,
    this.title,
    this.dateRemind,
    this.description,
    this.staffAvatar,
    this.isSent
  });

  WorkListRemindModel.fromJson(Map<String, dynamic> json) {
    manageRemindId = json['manage_remind_id'];
    manageWorkId = json['manage_work_id'];
    title = json['title'];
    dateRemind = json['date_remind'];
    description = json['description'];
    staffName = json['staff_name'];
    staffAvatar = json['staff_avatar'];
    isSent = json['is_sent'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_remind_id'] = this.manageRemindId;
    data['manage_work_id'] = this.manageWorkId;
    data['title'] = this.title;
    data['date_remind'] = this.dateRemind;
    data['description'] = this.description;
    data['staff_name'] = this.staffName;
    data['staff_avatar'] = this.staffAvatar;
    data['is_sent'] = this.isSent;
    return data;
  }
}