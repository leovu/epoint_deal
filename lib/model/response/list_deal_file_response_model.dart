class ListDealFilesResponseModel {
  int? errorCode;
  String? errorDescription;
  List<DealFilesModel>? data;

  ListDealFilesResponseModel({this.errorCode, this.errorDescription, this.data});

  ListDealFilesResponseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    if (json['Data'] != null) {
      data = <DealFilesModel>[];
      json['Data'].forEach((v) {
        data!.add(new DealFilesModel.fromJson(v));
      });
    }
  }

  ListDealFilesResponseModel.fromList(List<dynamic>? json) {
    if (json != null) {
      data = <DealFilesModel>[];
      json.forEach((v) {
        data!.add(new DealFilesModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DealFilesModel {
  int? dealFileId;
  int? dealId;
  String? fileName;
  String? path;
  String? content;
  String? createdAt;
  String? updatedAt;
  String? createdBy;
  String? updatedBy;

  DealFilesModel(
      {this.dealFileId,
      this.dealId,
      this.fileName,
      this.path,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy});

  DealFilesModel.fromJson(Map<String, dynamic> json) {
    dealFileId = json['deal_file_id'];
    dealId = json['deal_id'];
    fileName = json['file_name'];
    path = json['path'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_file_id'] = this.dealFileId;
    data['deal_id'] = this.dealId;
    data['file_name'] = this.fileName;
    data['path'] = this.path;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    return data;
  }
}
