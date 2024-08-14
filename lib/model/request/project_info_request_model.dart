class ProjectInfoRequestModel {
  String? projectId;
  String? search;

  ProjectInfoRequestModel({this.projectId, this.search});

  ProjectInfoRequestModel.fromJson(Map<String, dynamic> json) {
    projectId = json['manage_project_id'];
    search = json['search'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_id'] = this.projectId;
    data['search'] = this.search;
    return data;
  }
}