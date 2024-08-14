class WorkRemoveLocationRequestModel {
  int? manageWorkLocationId;

  WorkRemoveLocationRequestModel({this.manageWorkLocationId});

  WorkRemoveLocationRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkLocationId = json['manage_work_location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_location_id'] = this.manageWorkLocationId;
    return data;
  }
}
