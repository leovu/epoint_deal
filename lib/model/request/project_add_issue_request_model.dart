class ProjectAddIssueRequestModel {  int? manageProjectId;  String? parentId;  String? content;  String? status;  ProjectAddIssueRequestModel(      {this.manageProjectId, this.parentId, this.content, this.status});  ProjectAddIssueRequestModel.fromJson(Map<String, dynamic> json) {    manageProjectId = json['manage_project_id'];    parentId = json['parent_id'];    content = json['content'];    status = json['status'];  }  Map<String, dynamic> toJson() {    final Map<String, dynamic> data = new Map<String, dynamic>();    data['manage_project_id'] = this.manageProjectId;    data['parent_id'] = this.parentId;    data['content'] = this.content;    data['status'] = this.status;    return data;  }}