class WorkListWorkRequestModel {
  int? manageProjectId;
  String? manageWorkTitle;
  int? page;

  WorkListWorkRequestModel({this.manageProjectId, this.manageWorkTitle, this.page});

  WorkListWorkRequestModel.fromJson(Map<String, dynamic> json) {
    manageProjectId = json['manage_project_id'];
    manageWorkTitle = json['manage_work_title'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_id'] = this.manageProjectId;
    data['manage_work_title'] = this.manageWorkTitle;
    data['page'] = this.page;
    return data;
  }
}
