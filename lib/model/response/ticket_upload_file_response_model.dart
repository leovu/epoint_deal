class TicketUploadFileResponseModel {
  String? path;

  TicketUploadFileResponseModel({this.path});

  TicketUploadFileResponseModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    return data;
  }
}