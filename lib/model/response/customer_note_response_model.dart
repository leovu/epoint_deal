

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CustomerNoteResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerNoteModel>? items;

  CustomerNoteResponseModel({this.pageInfo, this.items});

  CustomerNoteResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerNoteModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerNoteModel.fromJson(v));
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

class CustomerNoteModel {
  int? customerNoteId;
  int? customerId;
  String? customerName;
  String? customerTypeName;
  String? phone;
  String? note;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? createdAt;
  String? updatedAt;
  int? order;

  CustomerNoteModel(
      {this.customerNoteId,
        this.customerId,
        this.customerName,
        this.customerTypeName,
        this.phone,
        this.note,
        this.createdBy,
        this.updatedBy,
        this.staffCreatedName,
        this.staffUpdatedName,
        this.createdAt,
        this.updatedAt,
        this.order});

  CustomerNoteModel.fromJson(Map<String, dynamic> json) {
    customerNoteId = json['customer_note_id'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerTypeName = json['customer_type_name'];
    phone = json['phone'];
    note = json['note'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    order = json['order'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_note_id'] = this.customerNoteId;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_type_name'] = this.customerTypeName;
    data['phone'] = this.phone;
    data['note'] = this.note;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['order'] = this.order;
    return data;
  }
}
