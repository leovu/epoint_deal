class WorkAddProjectRequestModel {
  String? manageProjectName;

  WorkAddProjectRequestModel({this.manageProjectName});

  WorkAddProjectRequestModel.fromJson(Map<String, dynamic> json) {
    manageProjectName = json['manage_project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_name'] = this.manageProjectName;
    return data;
  }
}