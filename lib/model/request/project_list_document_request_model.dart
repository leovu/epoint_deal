

import 'package:epoint_deal_plugin/model/response/project_list_document_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_list_staff_response_model.dart';

class ProjectListDocumentRequestModel{
  int? manageProjectId;
  String? search;
  int? page;
  String? fileName;
  String? type;
  int? creator;
  String? updatedAt;

  ProjectListDocumentRequestModel(
      {this.manageProjectId,
        this.search,
        this.page,
        this.fileName,
        this.type,
        this.creator,
        this.updatedAt});

  ProjectListDocumentRequestModel.fromJson(Map<String, dynamic> json) {
    manageProjectId = json['manage_project_id'];
    search = json['search'];
    page = json['page'];
    fileName = json['file_name'];
    type = json['type'];
    creator = json['creator'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_id'] = this.manageProjectId;
    data['search'] = this.search;
    data['page'] = this.page;
    data['file_name'] = this.fileName;
    data['type'] = this.type;
    data['creator'] = this.creator;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProjectDeleteDocumentRequestModel {
  int? documentId;
  ProjectDeleteDocumentRequestModel({this.documentId});
  ProjectDeleteDocumentRequestModel.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_id'] = this.documentId;
    return data;
  }
}

class ProjectFilterDocumentRequestModel {
  DocumentType? type;
  ProjectStaffModel? creator;
  String? fromDate;
  String? toDate;

  ProjectFilterDocumentRequestModel({this.type, this.creator, this.fromDate, this.toDate});
}
