class ProjectStatusResponseModel {

  List<ProjectStatusModel>? data;

  ProjectStatusResponseModel({this.data});

  ProjectStatusResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProjectStatusModel>[];
      json.forEach((v) {
        data!.add(new ProjectStatusModel.fromJson(v));
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

class ProjectStatusModel{
  int? manageProjectStatusId;
  String? manageProjectStatusName;
  String? manageProjectStatusColor;
  bool? isSelected;

  ProjectStatusModel({
    this.manageProjectStatusId,
    this.manageProjectStatusName,
    this.manageProjectStatusColor,
    this.isSelected = false,
  });

  ProjectStatusModel.fromJson(Map<String, dynamic> json) {
    manageProjectStatusId = json['manage_project_status_id'];
    manageProjectStatusName = json['manage_project_status_name'];
    manageProjectStatusColor = json['manage_project_status_color'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_status_id'] = this.manageProjectStatusId;
    data['manage_project_status_name'] = this.manageProjectStatusName;
    data['manage_project_status_color'] = this.manageProjectStatusColor;
    return data;
  }
}
