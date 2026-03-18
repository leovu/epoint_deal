

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class ProjectListRemindResponseModel {
  PageInfoModel? pageInfo;
  List<ProjectRemindModel>? items;

  ProjectListRemindResponseModel(
      {this.pageInfo, this.items});

  ProjectListRemindResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <ProjectRemindModel>[];
      json['Items'].forEach((v) {
        items!.add(new ProjectRemindModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] =
          this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectRemindModel {
  int? manageRemindId;
  int? manageProjectId;
  String? dateRemind;
  String? title;
  String? description;
  int? manageWorkId;
  int? isSent;
  String? staffAvatar;
  String? staffName;
  String? timeRemainng;

  ProjectRemindModel(
      {this.manageRemindId,
        this.manageProjectId,
        this.dateRemind,
        this.title,
        this.description,
        this.manageWorkId,
        this.isSent,
        this.staffAvatar,
        this.staffName,
        this.timeRemainng});

  ProjectRemindModel.fromJson(Map<String, dynamic> json) {
    manageRemindId = json['manage_remind_id'];
    manageProjectId = json['manage_project_id'];
    dateRemind = json['date_remind'];
    title = json['title'];
    description = json['description'];
    manageWorkId = json['manage_work_id'];
    isSent = json['is_sent'];
    staffAvatar = json['staff_avatar'];
    staffName = json['staff_name'];
    timeRemainng = json['time_remainng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_remind_id'] = this.manageRemindId;
    data['manage_project_id'] = this.manageProjectId;
    data['date_remind'] = this.dateRemind;
    data['title'] = this.title;
    data['description'] = this.description;
    data['manage_work_id'] = this.manageWorkId;
    data['is_sent'] = this.isSent;
    data['staff_avatar'] = this.staffAvatar;
    data['staff_name'] = this.staffName;
    data['time_remainng'] = this.timeRemainng;
    return data;
  }
}