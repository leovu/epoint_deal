import 'timekeeping_history_response_model.dart';

class TimekeepingPersonalHistoryResponseModel {
  List<TimekeepingHistoryModel>? data;

  TimekeepingPersonalHistoryResponseModel({this.data});

  TimekeepingPersonalHistoryResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TimekeepingHistoryModel>[];
      json.forEach((v) {
        data!.add(new TimekeepingHistoryModel.fromJson(v));
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