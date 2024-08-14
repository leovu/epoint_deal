class ProjectEditProjectRequestModel {  int? manageProjectIssueId;  String? parentId;  int? manageProjectId;  String? content;  String? status;  ProjectEditProjectRequestModel(      {this.manageProjectIssueId,        this.parentId,        this.manageProjectId,        this.content,        this.status});  ProjectEditProjectRequestModel.fromJson(Map<String, dynamic> json) {    manageProjectIssueId = json['manage_project_issue_id'];    parentId = json['parent_id'];    manageProjectId = json['manage_project_id'];    content = json['content'];    status = json['status'];  }  Map<String, dynamic> toJson() {    final Map<String, dynamic> data = new Map<String, dynamic>();    data['manage_project_issue_id'] = this.manageProjectIssueId;    data['parent_id'] = this.parentId;    data['manage_project_id'] = this.manageProjectId;    data['content'] = this.content;    data['status'] = this.status;    return data;  }}