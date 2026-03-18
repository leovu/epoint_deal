class WorkEditRepeatRequestModel {
  int? manageWorkId;
  String? repeatType;
  String? repeatName;
  String? repeatEnd;
  String? repeatEndFullTime;
  String? repeatTime;
  List<WorkEditRepeatDateModel>? listDate;

  WorkEditRepeatRequestModel(
      {this.manageWorkId,
        this.repeatType,
        this.repeatName,
        this.repeatEnd,
        this.repeatEndFullTime,
        this.repeatTime,
        this.listDate});

  WorkEditRepeatRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    repeatType = json['repeat_type'];
    repeatEnd = json['repeat_end'];
    repeatEndFullTime = json['repeat_end_full_time'];
    repeatTime = json['repeat_time'];
    if (json['list_date'] != null) {
      listDate = <WorkEditRepeatDateModel>[];
      json['list_date'].forEach((v) {
        listDate!.add(new WorkEditRepeatDateModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['repeat_type'] = this.repeatType;
    data['repeat_end'] = this.repeatEnd;
    data['repeat_end_full_time'] = this.repeatEndFullTime;
    data['repeat_time'] = this.repeatTime;
    if (this.listDate != null) {
      data['list_date'] = this.listDate!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkEditRepeatDateModel {
  int? date;

  WorkEditRepeatDateModel({this.date});

  WorkEditRepeatDateModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    return data;
  }
}