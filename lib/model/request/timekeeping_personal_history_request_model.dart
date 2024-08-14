class TimekeepingPersonalHistoryRequestModel {
  String? fromDate;
  String? toDate;

  TimekeepingPersonalHistoryRequestModel({this.fromDate, this.toDate});

  TimekeepingPersonalHistoryRequestModel.fromJson(Map<String, dynamic> json) {
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}