class WorkApproveRequestModel {
  int? manageWorkId;
  String? type;

  WorkApproveRequestModel({this.manageWorkId, this.type});

  WorkApproveRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['type'] = this.type;
    return data;
  }
}