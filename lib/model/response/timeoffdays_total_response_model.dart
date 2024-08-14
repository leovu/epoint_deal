class TimeoffdaysTotalResponseModel {
  List<TimeoffdaysTotalModel>? data;

  TimeoffdaysTotalResponseModel({this.data});

  TimeoffdaysTotalResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TimeoffdaysTotalModel>[];
      json.forEach((v) {
        data!.add(new TimeoffdaysTotalModel.fromJson(v));
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

class TimeoffdaysTotalModel {
  String? key;
  String? value;

  TimeoffdaysTotalModel({this.key, this.value});

  TimeoffdaysTotalModel.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['value'] = this.value;
    return data;
  }
}
