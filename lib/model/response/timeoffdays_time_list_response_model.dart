class TimeoffdaysTimeListResponseModel {
  List<TimeoffdaysTimeListModel>? data;

  TimeoffdaysTimeListResponseModel({this.data});

  TimeoffdaysTimeListResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TimeoffdaysTimeListModel>[];
      json.forEach((v) {
        data!.add(new TimeoffdaysTimeListModel.fromJson(v));
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

class TimeoffdaysTimeListModel {
  int? timeId;
  String? timeName;

  TimeoffdaysTimeListModel({this.timeId, this.timeName});

  TimeoffdaysTimeListModel.fromJson(Map<String, dynamic> json) {
    timeId = json['time_id'];
    timeName = json['time_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_id'] = this.timeId;
    data['time_name'] = this.timeName;
    return data;
  }
}
