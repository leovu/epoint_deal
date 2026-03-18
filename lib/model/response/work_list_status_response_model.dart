class WorkListStatusResponseModel {
  List<WorkListStatusModel>? data;

  WorkListStatusResponseModel({this.data});

  WorkListStatusResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListStatusModel>[];
      json.forEach((v) {
        data!.add(new WorkListStatusModel.fromJson(v));
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

class WorkListStatusModel {
  int? manageStatusId;
  String? manageStatusName;
  String? manageStatusColor;
  bool? isCancel;

  WorkListStatusModel({
    this.manageStatusId,
    this.manageStatusName,
    this.manageStatusColor,
    this.isCancel,
  });

  WorkListStatusModel.fromJson(Map<String, dynamic> json) {
    manageStatusId = json['manage_status_id'];
    manageStatusName = json['manage_status_name'];
    manageStatusColor = json['manage_status_color'];
    isCancel = json['is_cancel'] == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_status_id'] = this.manageStatusId;
    data['manage_status_name'] = this.manageStatusName;
    data['manage_status_color'] = this.manageStatusColor;
    data['is_cancel'] = this.isCancel;
    return data;
  }
}