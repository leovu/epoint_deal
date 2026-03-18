class WorkListProjectResponseModel {
  List<WorkListProjectModel>? data;

  WorkListProjectResponseModel({this.data});

  WorkListProjectResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListProjectModel>[];
      json.forEach((v) {
        data!.add(new WorkListProjectModel.fromJson(v));
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

class WorkListProjectModel {
  int? manageProjectId;
  String? manageProjectName;

  WorkListProjectModel({this.manageProjectId, this.manageProjectName});

  WorkListProjectModel.fromJson(Map<String, dynamic> json) {
    manageProjectId = json['manage_project_id'];
    manageProjectName = json['manage_project_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_id'] = this.manageProjectId;
    data['manage_project_name'] = this.manageProjectName;
    return data;
  }
}