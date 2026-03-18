class WorkListPhaseResponseModel {
  List<WorkListPhaseModel>? data;

  WorkListPhaseResponseModel({this.data});

  WorkListPhaseResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListPhaseModel>[];
      json.forEach((v) {
        data!.add(new WorkListPhaseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkListPhaseModel {
  int? manageProjectPhaseId;
  int? manageProjectId;
  String? name;
  String? dateStart;
  String? dateEnd;
  int? isDefault;

  WorkListPhaseModel(
      {this.manageProjectPhaseId,
        this.manageProjectId,
        this.name,
        this.dateStart,
        this.dateEnd,
        this.isDefault});

  WorkListPhaseModel.fromJson(Map<String, dynamic> json) {
    manageProjectPhaseId = json['manage_project_phase_id'];
    manageProjectId = json['manage_project_id'];
    name = json['name'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_phase_id'] = this.manageProjectPhaseId;
    data['manage_project_id'] = this.manageProjectId;
    data['name'] = this.name;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['is_default'] = this.isDefault;
    return data;
  }
}
