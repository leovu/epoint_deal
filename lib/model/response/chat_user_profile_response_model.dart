class ChatUserProfileResponseModel {

  ChatUserProfileModel? data;

  ChatUserProfileResponseModel({this.data});

  ChatUserProfileResponseModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new ChatUserProfileModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class ChatUserProfileModel {
  int? roomAlert;

  ChatUserProfileModel({this.roomAlert});

  ChatUserProfileModel.fromJson(Map<String, dynamic> json) {
    roomAlert = json['roomAlert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['roomAlert'] = this.roomAlert;
    return data;
  }
}