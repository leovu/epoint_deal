class TimeBookingResponseModel {
  String? date;
  List<TimeBookingModel>? times;

  TimeBookingResponseModel({this.date, this.times});

  TimeBookingResponseModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    if (json['times'] != null) {
      times = <TimeBookingModel>[];
      json['times'].forEach((v) {
        times!.add(new TimeBookingModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.times != null) {
      data['times'] = this.times!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TimeBookingModel {
  String? time;
  bool? rule;
  bool? selected;

  TimeBookingModel({this.time, this.rule});

  TimeBookingModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    rule = json['rule'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['rule'] = this.rule;
    return data;
  }
}
