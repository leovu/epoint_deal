class ChatResponseModel {
  int? errorCode;
  String? errorDescription;
  Map<String, dynamic>? data;
  bool? success;

  ChatResponseModel({this.errorCode, this.errorDescription, this.data, this.success = false});

  ChatResponseModel.fromJson(Map<String, dynamic>? json) {
    data = json;
    success = data!.isNotEmpty;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data;
    }
    return data;
  }
}