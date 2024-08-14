class ChatNotificationUserResponseModel {
  int? total;

  ChatNotificationUserResponseModel({this.total});

  ChatNotificationUserResponseModel.fromJson(Map<String, dynamic> json) {
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    return data;
  }
}
