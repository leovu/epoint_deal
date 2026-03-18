class ProjectStatisticalResponseModel {

  List<ProjectStatisticalModel>? data;

  ProjectStatisticalResponseModel({this.data});

  ProjectStatisticalResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProjectStatisticalModel>[];
      json.forEach((v) {
        data!.add(new ProjectStatisticalModel.fromJson(v));
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

class ProjectStatisticalModel {
  String? departmentName;
  int? workAmount;
  String? color;

  ProjectStatisticalModel({this.departmentName, this.workAmount, this.color});

  ProjectStatisticalModel.fromJson(Map<String, dynamic> json) {
    departmentName = json['name'];
    workAmount = json['amount'];
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.departmentName;
    data['amount'] = this.workAmount;
    data['color'] = this.color;
    return data;
  }
}