class WorkListHistoryResponseModel {
  List<WorkListHistoryModel>? data;

  WorkListHistoryResponseModel({this.data});

  WorkListHistoryResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListHistoryModel>[];
      json.forEach((v) {
        data!.add(new WorkListHistoryModel.fromJson(v));
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

class WorkListHistoryModel {
  int? manageHistoryId;
  int? staffId;
  String? staffName;
  String? message;
  String? createdAt;

  WorkListHistoryModel(
      {this.manageHistoryId,
        this.staffId,
        this.staffName,
        this.message,
        this.createdAt});

  WorkListHistoryModel.fromJson(Map<String, dynamic> json) {
    manageHistoryId = json['manage_history_id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    message = json['message'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_history_id'] = this.manageHistoryId;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['message'] = this.message;
    data['created_at'] = this.createdAt;
    return data;
  }
}