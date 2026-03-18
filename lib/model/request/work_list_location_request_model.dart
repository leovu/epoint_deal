class WorkListLocationRequestModel {
  int? manageWorkId;

  WorkListLocationRequestModel({this.manageWorkId});

  WorkListLocationRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    return data;
  }
}
