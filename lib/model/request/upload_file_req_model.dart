class UploadFileReqModel {
  int? dealId;
  String? fileName;
  String? path;
  String? content;

  UploadFileReqModel({this.dealId, this.fileName, this.path, this.content});

  UploadFileReqModel.fromJson(Map<String, dynamic> json) {
    dealId = json['deal_id'];
    fileName = json['file_name'];
    path = json['path'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_id'] = this.dealId;
    data['file_name'] = this.fileName;
    data['path'] = this.path;
    data['content'] = this.content;
    return data;
  }
}
