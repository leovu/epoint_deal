class WorkAddTypeRequestModel {
  String? manageTypeWorkName;
  String? manageTypeWorkIcon;

  WorkAddTypeRequestModel({this.manageTypeWorkName, this.manageTypeWorkIcon});

  WorkAddTypeRequestModel.fromJson(Map<String, dynamic> json) {
    manageTypeWorkName = json['manage_type_work_name'];
    manageTypeWorkIcon = json['manage_type_work_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_type_work_name'] = this.manageTypeWorkName;
    data['manage_type_work_icon'] = this.manageTypeWorkIcon;
    return data;
  }
}