

import 'package:epoint_deal_plugin/model/response/project_list_issue_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_list_staff_response_model.dart';

class ProjectListIssueRequestModel {
  int? manageProjectId;
  String? issueStatus;
  String? fromDate;
  String? toDate;
  int? staffId;
  String? staffName;
  int? page;

  ProjectListIssueRequestModel(
      {this.manageProjectId,
        this.issueStatus,
        this.fromDate,
        this.toDate,
        this.staffId, this.page, this.staffName});

  ProjectListIssueRequestModel.fromJson(Map<String, dynamic> json) {
    manageProjectId = json['manage_project_id'];
    issueStatus = json['issue_status'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    staffId = json['staff_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_id'] = this.manageProjectId;
    data['issue_status'] = this.issueStatus;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['staff_id'] = this.staffId;
    data['page'] = this.page;
    return data;
  }
}

class IssueFilterModel {
  IssueStatus? status;
  ProjectStaffModel? staff;
  String? fromDate;
  String? toDate;

  IssueFilterModel({this.status, this.staff, this.fromDate, this.toDate});
}