class WorkListTypeResponseModel {
  List<WorkListTypeModel>? data;

  WorkListTypeResponseModel({this.data});

  WorkListTypeResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListTypeModel>[];
      json.forEach((v) {
        data!.add(new WorkListTypeModel.fromJson(v));
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

class WorkListTypeModel {
  int? manageTypeWorkId;
  String? manageTypeWorkName;
  String? manageTypeWorkIcon;

  WorkListTypeModel(
      {this.manageTypeWorkId,
        this.manageTypeWorkName,
        this.manageTypeWorkIcon});

  WorkListTypeModel.fromJson(Map<String, dynamic> json) {
    manageTypeWorkId = json['manage_type_work_id'];
    manageTypeWorkName = json['manage_type_work_name'];
    manageTypeWorkIcon = json['manage_type_work_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['manage_type_work_name'] = this.manageTypeWorkName;
    data['manage_type_work_icon'] = this.manageTypeWorkIcon;
    return data;
  }
}