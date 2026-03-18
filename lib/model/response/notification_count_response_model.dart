class NotificationCountResponseModel {
  int? number;

  NotificationCountResponseModel({this.number});

  NotificationCountResponseModel.fromJson(Map<String, dynamic> json) {
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    return data;
  }
}