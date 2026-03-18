

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CustomerWorkResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerWorkModel>? items;
  List<CustomerWorkStatusModel>? status;

  CustomerWorkResponseModel({this.pageInfo, this.items, this.status});

  CustomerWorkResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerWorkModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerWorkModel.fromJson(v));
      });
    }
    if (json['status'] != null) {
      status = <CustomerWorkStatusModel>[];
      json['status'].forEach((v) {
        status!.add(new CustomerWorkStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerWorkModel {
  int? manageWorkId;
  String? manageWorkCode;
  int? manageTypeWorkId;
  String? manageTypeWorkName;
  String? customerName;
  String? branchName;
  int? manageStatusId;
  String? manageStatusName;
  String? manageStatusColor;
  String? processor;
  String? manageWorkTitle;
  String? dateStart;
  String? dateEnd;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? description;
  int? manageResultId;
  String? manageResultName;
  List<CustomerWorkDocumentModel>? listDocument;

  CustomerWorkModel(
      {this.manageWorkId,
      this.manageWorkCode,
      this.manageTypeWorkId,
      this.manageTypeWorkName,
      this.customerName,
      this.branchName,
      this.manageStatusId,
      this.manageStatusName,
      this.manageStatusColor,
      this.processor,
      this.manageWorkTitle,
      this.dateStart,
      this.dateEnd,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.staffCreatedName,
      this.staffUpdatedName,
      this.description,
      this.manageResultId,
      this.manageResultName,
      this.listDocument});

  CustomerWorkModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    manageWorkCode = json['manage_work_code'];
    manageTypeWorkId = json['manage_type_work_id'];
    manageTypeWorkName = json['manage_type_work_name'];
    customerName = json['customer_name'];
    branchName = json['branch_name'];
    manageStatusId = json['manage_status_id'];
    manageStatusName = json['manage_status_name'];
    manageStatusColor = json['manage_status_color'];
    processor = json['processor'];
    manageWorkTitle = json['manage_work_title'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    description = json['description'];
    manageResultId = json['manage_result_id'];
    manageResultName = json['manage_result_name'];
    if (json['list_document'] != null) {
      listDocument = <CustomerWorkDocumentModel>[];
      json['list_document'].forEach((v) {
        listDocument!.add(new CustomerWorkDocumentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['manage_work_code'] = this.manageWorkCode;
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['manage_type_work_name'] = this.manageTypeWorkName;
    data['customer_name'] = this.customerName;
    data['branch_name'] = this.branchName;
    data['manage_status_id'] = this.manageStatusId;
    data['manage_status_name'] = this.manageStatusName;
    data['manage_status_color'] = this.manageStatusColor;
    data['processor'] = this.processor;
    data['manage_work_title'] = this.manageWorkTitle;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['description'] = this.description;
    data['manage_result_id'] = this.manageResultId;
    data['manage_result_name'] = this.manageResultName;
    if (this.listDocument != null) {
      data['list_document'] =
          this.listDocument!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerWorkStatusModel {
  int? manageStatusId;
  int? manageStatusValue;
  String? manageStatusName;
  String? manageStatusColor;
  String? statusName;

  CustomerWorkStatusModel(
      {this.manageStatusId,
      this.manageStatusValue,
      this.manageStatusName,
      this.manageStatusColor,
      this.statusName});

  CustomerWorkStatusModel.fromJson(Map<String, dynamic> json) {
    manageStatusId = json['manage_status_id'];
    manageStatusValue = json['manage_status_value'];
    manageStatusName = json['manage_status_name'];
    manageStatusColor = json['manage_status_color'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_status_id'] = this.manageStatusId;
    data['manage_status_value'] = this.manageStatusValue;
    data['manage_status_name'] = this.manageStatusName;
    data['manage_status_color'] = this.manageStatusColor;
    data['status_name'] = this.statusName;
    return data;
  }
}

class CustomerWorkDocumentModel {
  int? manageDocumentFileId;
  String? fileName;
  String? path;

  CustomerWorkDocumentModel(
      {this.manageDocumentFileId, this.fileName, this.path});

  CustomerWorkDocumentModel.fromJson(Map<String, dynamic> json) {
    manageDocumentFileId = json['manage_document_file_id'];
    fileName = json['file_name'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_document_file_id'] = this.manageDocumentFileId;
    data['file_name'] = this.fileName;
    data['path'] = this.path;
    return data;
  }
}
