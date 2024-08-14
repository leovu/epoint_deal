class ProjectStatisticalTabResponseModel {

  List<ProjectStatisticalTabModel>? data;

  ProjectStatisticalTabResponseModel({this.data});

  ProjectStatisticalTabResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProjectStatisticalTabModel>[];
      json.forEach((v) {
        data!.add(new ProjectStatisticalTabModel.fromJson(v));
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

class ProjectStatisticalTabModel {
  int? manageProjectId;
  String? statisticalType;
  String? tabName;
  int? statusId;
  bool? isSelected;

  ProjectStatisticalTabModel({this.manageProjectId, this.statisticalType, this.tabName,this.statusId, this.isSelected = false,});

  ProjectStatisticalTabModel.fromJson(Map<String, dynamic> json) {
    manageProjectId = json['manage_project_id'];
    statisticalType = json['statistical_type'];
    tabName = json['tab_name'];
    statusId = json['status_id'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_id'] = this.manageProjectId;
    data['statistical_type'] = this.statisticalType;
    data['tab_name'] = this.tabName;
    data['status_id'] = this.statusId;
    return data;
  }
}