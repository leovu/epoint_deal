
import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:flutter/material.dart';

class MaintenanceResponseModel {
  PageInfoModel? pageInfo;
  List<MaintenanceModel>? items;

  MaintenanceResponseModel({this.pageInfo, this.items});

  MaintenanceResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <MaintenanceModel>[];
      json['Items'].forEach((v) {
        items!.add(new MaintenanceModel.fromJson(v));
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

class MaintenanceModel {
  int? maintenanceId;
  String? maintenanceCode;
  String? customerName;
  String? status;
  double? totalAmountPay;
  String? createdAt;
  String? dateEstimateDelivery;
  String? objectType;
  String? objectTypeId;
  String? objectCode;
  String? statusName;
  String? statusColor;
  Color? color;
  String? objectName;
  int? isUpdate;
  int? isPayment;

  MaintenanceModel(
      {this.maintenanceId,
        this.maintenanceCode,
        this.customerName,
        this.status,
        this.totalAmountPay,
        this.createdAt,
        this.dateEstimateDelivery,
        this.objectType,
        this.objectTypeId,
        this.objectCode,
        this.statusName,
        this.statusColor,
        this.objectName,
        this.isUpdate,
        this.isPayment});

  MaintenanceModel.fromJson(Map<String, dynamic> json) {
    maintenanceId = json['maintenance_id'];
    maintenanceCode = json['maintenance_code'];
    customerName = json['customer_name'];
    status = json['status'];
    totalAmountPay = double.tryParse((json['total_amount_pay'] ?? 0).toString());
    createdAt = json['created_at'];
    dateEstimateDelivery = json['date_estimate_delivery'];
    objectType = json['object_type'];
    objectTypeId = json['object_type_id'];
    objectCode = json['object_code'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
    color = HexColor(statusColor ?? "000000");
    objectName = json['object_name'];
    isUpdate = json['is_update'];
    isPayment = json['is_payment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_id'] = this.maintenanceId;
    data['maintenance_code'] = this.maintenanceCode;
    data['customer_name'] = this.customerName;
    data['status'] = this.status;
    data['total_amount_pay'] = this.totalAmountPay;
    data['created_at'] = this.createdAt;
    data['date_estimate_delivery'] = this.dateEstimateDelivery;
    data['object_type'] = this.objectType;
    data['object_type_id'] = this.objectTypeId;
    data['object_code'] = this.objectCode;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    data['object_name'] = this.objectName;
    data['is_update'] = this.isUpdate;
    data['is_payment'] = this.isPayment;
    return data;
  }
}
