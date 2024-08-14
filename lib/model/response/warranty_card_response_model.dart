
import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:epoint_deal_plugin/presentation/list_deal/list_deal_screen.dart';
import 'package:flutter/material.dart';

class WarrantyCardResponseModel {
  PageInfoModel? pageInfo;
  List<WarrantyCardModel>? items;

  WarrantyCardResponseModel({this.pageInfo, this.items});

  WarrantyCardResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <WarrantyCardModel>[];
      json['Items'].forEach((v) {
        items!.add(new WarrantyCardModel.fromJson(v));
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

class WarrantyCardModel {
  int? warrantyCardId;
  String? warrantyCardCode;
  int? quota;
  String? customerCode;
  String? customerName;
  String? dateExpired;
  String? dateExpiredName;
  String? createdAt;
  String? status;
  String? statusName;
  String? statusColor;
  Color? color;
  String? objectType;
  String? objectTypeId;
  String? objectCode;
  String? objectName;
  String? objectSerial;
  int? isUpdate;
  double? warrantyValueApply;

  WarrantyCardModel(
      {this.warrantyCardId,
        this.warrantyCardCode,
        this.quota,
        this.customerCode,
        this.customerName,
        this.dateExpired,
        this.dateExpiredName,
        this.createdAt,
        this.status,
        this.statusName,
        this.statusColor,
        this.objectType,
        this.objectTypeId,
        this.objectCode,
        this.objectName,
        this.objectSerial,
        this.isUpdate,
        this.warrantyValueApply});

  WarrantyCardModel.fromJson(Map<String, dynamic> json) {
    warrantyCardId = json['warranty_card_id'];
    warrantyCardCode = json['warranty_card_code'];
    quota = json['quota'];
    customerCode = json['customer_code'];
    customerName = json['customer_name'];
    dateExpired = json['date_expired'];
    dateExpiredName = json['date_expired_name'];
    createdAt = json['created_at'];
    status = json['status'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
    color = HexColor(statusColor ?? "000000");
    objectType = json['object_type'];
    objectTypeId = json['object_type_id'];
    objectCode = json['object_code'];
    objectName = json['object_name'];
    objectSerial = json['object_serial'];
    isUpdate = json['is_update'];
    warrantyValueApply = double.tryParse((json['warranty_value_apply'] ?? 0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_card_id'] = this.warrantyCardId;
    data['warranty_card_code'] = this.warrantyCardCode;
    data['quota'] = this.quota;
    data['customer_code'] = this.customerCode;
    data['customer_name'] = this.customerName;
    data['date_expired'] = this.dateExpired;
    data['date_expired_name'] = this.dateExpiredName;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    data['object_type'] = this.objectType;
    data['object_type_id'] = this.objectTypeId;
    data['object_code'] = this.objectCode;
    data['object_name'] = this.objectName;
    data['object_serial'] = this.objectSerial;
    data['is_update'] = this.isUpdate;
    data['warranty_value_apply'] = this.warrantyValueApply;
    return data;
  }
}
