class NotificationReadRequestModel {
  int? staffNotificationId;
  String? brandCode;

  NotificationReadRequestModel({this.staffNotificationId, this.brandCode});

  NotificationReadRequestModel.fromJson(Map<String, dynamic> json) {
    staffNotificationId = json['staff_notification_id'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_notification_id'] = this.staffNotificationId;
    data['brand_code'] = this.brandCode;
    return data;
  }
}