

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class ProjectListDocumentResponseModel {
  PageInfoModel? pageInfo;
  List<ProjectListDocumentModel>? items;

  ProjectListDocumentResponseModel(
      {this.pageInfo, this.items});

  ProjectListDocumentResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <ProjectListDocumentModel>[];
      json['Items'].forEach((v) {
        items!.add(new ProjectListDocumentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] =
          this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectListDocumentModel {
  int? documentId;
  int? manageProjectId;
  String? type;
  String? documentName;
  String? path;
  int? createdBy;
  String? creator;
  String? createdAt;
  String? updatedAt;

  ProjectListDocumentModel(
      {this.documentId,
        this.manageProjectId,
        this.type,
        this.documentName,
        this.path,
        this.createdBy,
        this.creator,
        this.createdAt,
        this.updatedAt});

  ProjectListDocumentModel.fromJson(Map<String, dynamic> json) {
    documentId = json['document_id'];
    manageProjectId = json['manage_project_id'];
    type = json['type'];
    documentName = json['document_name'];
    path = json['path'];
    createdBy = json['created_by'];
    creator = json['creator'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_id'] = this.documentId;
    data['manage_project_id'] = this.manageProjectId;
    data['type'] = this.type;
    data['document_name'] = this.documentName;
    data['path'] = this.path;
    data['created_by'] = this.createdBy;
    data['creator'] = this.creator;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class DocumentType {
  String? typeId;
  String? typeName;
  bool isSelected;
  DocumentType ({this.typeId, this.typeName, this.isSelected = false});
}