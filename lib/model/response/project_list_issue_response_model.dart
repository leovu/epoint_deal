


import 'package:epoint_deal_plugin/model/page_info_model.dart';

class ProjectListIssueResponseModel {
  PageInfoModel? pageInfo;
  List<ProjectListIssueModel>? items;
  IssueStatus? status;

  ProjectListIssueResponseModel({this.pageInfo, this.items, this.status});

  ProjectListIssueResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <ProjectListIssueModel>[];
      json['Items'].forEach((v) {
        items!.add(new ProjectListIssueModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectListIssueModel {
  int? projectIssueId;
  int? parentId;
  int? projectId;
  String? content;
  String? status;
  String? createdAt;
  int? staffId;
  String? staffName;
  String? staffAvatar;
  String? statusName;

  ProjectListIssueModel(
      {this.projectIssueId,
        this.parentId,
        this.projectId,
        this.content,
        this.status,
        this.createdAt,
        this.staffId,
        this.staffName,
        this.staffAvatar, this.statusName});

  ProjectListIssueModel.fromJson(Map<String, dynamic> json) {
    projectIssueId = json['project_issue_id'];
    parentId = json['parent_id'];
    projectId = json['project_id'];
    content = json['content'];
    status = json['status'];
    createdAt = json['created_at'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    staffAvatar = json['staff_avatar'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_issue_id'] = this.projectIssueId;
    data['parent_id'] = this.parentId;
    data['project_id'] = this.projectId;
    data['content'] = this.content;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['staff_avatar'] = this.staffAvatar;
    data['status_name'] = this.statusName;
    return data;
  }
}

class IssueStatus {
    String? statusId;
    String? statusName;
    bool isSelected;

    IssueStatus ({this.statusId, this.statusName, this.isSelected = false});
}