class WorkDeleteDocumentFileRequestModel {
  int? manageDocumentFileId;

  WorkDeleteDocumentFileRequestModel({this.manageDocumentFileId});

  WorkDeleteDocumentFileRequestModel.fromJson(Map<String, dynamic> json) {
    manageDocumentFileId = json['manage_document_file_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_document_file_id'] = this.manageDocumentFileId;
    return data;
  }
}