class WorkDeleteRemindRequestModel {
  List<int?>? manageRemindId;

  WorkDeleteRemindRequestModel({this.manageRemindId});

  WorkDeleteRemindRequestModel.fromJson(Map<String, dynamic> json) {
    manageRemindId = json['manage_remind_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_remind_id'] = this.manageRemindId;
    return data;
  }
}
