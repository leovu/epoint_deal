

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CustomerFileResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerFileModel>? items;

  CustomerFileResponseModel({this.pageInfo, this.items});

  CustomerFileResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerFileModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerFileModel.fromJson(v));
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
    return data;
  }
}

class CustomerFileModel {
  int? customerFileId;
  String? type;
  String? link;
  String? fileName;
  String? note;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? createdAt;
  String? updatedAt;

  CustomerFileModel(
      {this.customerFileId,
        this.type,
        this.link,
        this.fileName,
        this.note,
        this.createdBy,
        this.updatedBy,
        this.staffCreatedName,
        this.staffUpdatedName,
        this.createdAt,
        this.updatedAt});

  CustomerFileModel.fromJson(Map<String, dynamic> json) {
    customerFileId = json['customer_file_id'];
    type = json['type'];
    link = json['link'];
    fileName = json['file_name'];
    note = json['note'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_file_id'] = this.customerFileId;
    data['type'] = this.type;
    data['link'] = this.link;
    data['file_name'] = this.fileName;
    data['note'] = this.note;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
