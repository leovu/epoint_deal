
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/presentation/list_deal/list_deal_screen.dart';
import 'package:flutter/material.dart';

class MaintenanceDetailResponseModel {
  int? maintenanceId;
  String? maintenanceCode;
  String? warrantyCode;
  String? packedCode;
  String? packedName;
  String? customerCode;
  int? customerId;
  String? customerName;
  String? email;
  String? phone;
  String? birthday;
  String? customerAvatar;
  String? groupName;
  String? fullAddress;
  String? status;
  double? maintenanceCost;
  String? dateExpired;
  double? warrantyValue;
  double? warrantyValueApply;
  double? insurancePay;
  double? amountPay;
  double? totalAmountPay;
  String? createdAt;
  String? dateEstimateDelivery;
  String? objectType;
  String? objectTypeId;
  String? objectCode;
  String? objectSerial;
  String? objectStatus;
  String? maintenanceContent;
  int? staffId;
  String? staffName;
  String? statusName;
  String? statusColor;
  Color? color;
  List<MaintenanceStatusUpdateModel>? statusUpdate;
  String? objectName;
  List<MaintenanceDetailCostModel>? listCost;
  List<MaintenanceImageModel>? listImage;
  List<MaintenanceImageModel>? listImageBefore;
  List<MaintenanceImageModel>? listImageAfter;
  List<MaintenanceDetailReceiptModel>? receiptDetail;
  double? totalAmountReceipt;
  int? isUpdate;
  int? isPayment;
  double? finalMoney;

  MaintenanceDetailResponseModel(
      {this.maintenanceId,
        this.maintenanceCode,
        this.warrantyCode,
        this.packedCode,
        this.packedName,
        this.customerCode,
        this.customerId,
        this.customerName,
        this.email,
        this.phone,
        this.birthday,
        this.customerAvatar,
        this.groupName,
        this.fullAddress,
        this.status,
        this.maintenanceCost,
        this.dateExpired,
        this.warrantyValue,
        this.warrantyValueApply,
        this.insurancePay,
        this.amountPay,
        this.totalAmountPay,
        this.createdAt,
        this.dateEstimateDelivery,
        this.objectType,
        this.objectTypeId,
        this.objectCode,
        this.objectSerial,
        this.objectStatus,
        this.maintenanceContent,
        this.staffId,
        this.staffName,
        this.statusName,
        this.statusColor,
        this.statusUpdate,
        this.objectName,
        this.listCost,
        this.listImage,
        this.receiptDetail,
        this.totalAmountReceipt,
        this.isUpdate,
        this.isPayment});

  MaintenanceDetailResponseModel.fromJson(Map<String, dynamic> json) {
    maintenanceId = json['maintenance_id'];
    maintenanceCode = json['maintenance_code'];
    warrantyCode = json['warranty_code'];
    packedCode = json['packed_code'];
    packedName = json['packed_name'];
    customerCode = json['customer_code'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    email = json['email'];
    phone = json['phone'];
    birthday = json['birthday'];
    customerAvatar = json['customer_avatar'];
    groupName = json['group_name'];
    fullAddress = json['full_address'];
    status = json['status'];
    maintenanceCost = double.tryParse((json['maintenance_cost'] ?? 0).toString());
    dateExpired = json['date_expired'];
    warrantyValue = double.tryParse((json['warranty_value'] ?? 0).toString());
    warrantyValueApply = double.tryParse((json['warranty_value_apply'] ?? 0).toString());
    insurancePay = double.tryParse((json['insurance_pay'] ?? 0).toString());
    amountPay = double.tryParse((json['amount_pay'] ?? 0).toString());
    totalAmountPay = double.tryParse((json['total_amount_pay'] ?? 0).toString());
    createdAt = json['created_at'];
    dateEstimateDelivery = json['date_estimate_delivery'];
    objectType = json['object_type'];
    objectTypeId = json['object_type_id'];
    objectCode = json['object_code'];
    objectSerial = json['object_serial'];
    objectStatus = json['object_status'];
    maintenanceContent = json['maintenance_content'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
    color = HexColor(statusColor ?? "000000");
    if (json['status_update'] != null) {
      statusUpdate = <MaintenanceStatusUpdateModel>[];
      json['status_update'].forEach((v) {
        statusUpdate!.add(new MaintenanceStatusUpdateModel.fromJson(v));
      });
    }
    objectName = json['object_name'];
    if (json['list_cost'] != null) {
      listCost = <MaintenanceDetailCostModel>[];
      json['list_cost'].forEach((v) {
        listCost!.add(new MaintenanceDetailCostModel.fromJson(v));
      });
    }
    if (json['list_image'] != null) {
      listImage = <MaintenanceImageModel>[];
      listImageBefore = <MaintenanceImageModel>[];
      listImageAfter = <MaintenanceImageModel>[];
      json['list_image'].forEach((v) {
        final model = MaintenanceImageModel.fromJson(v);
        listImage!.add(model);
        if(model.type == imageTypeAfter){
          listImageAfter!.add(model);
        }
        else{
          listImageBefore!.add(model);
        }
      });
    }
    if (json['receipt_detail'] != null) {
      receiptDetail = <MaintenanceDetailReceiptModel>[];
      json['receipt_detail'].forEach((v) {
        receiptDetail!.add(new MaintenanceDetailReceiptModel.fromJson(v));
      });
    }
    totalAmountReceipt = double.tryParse((json['total_amount_receipt'] ?? 0).toString());
    isUpdate = json['is_update'];
    isPayment = json['is_payment'];
    finalMoney = (totalAmountPay ?? 0) - (totalAmountReceipt ?? 0);
    if(finalMoney! < 0){
      finalMoney = 0;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_id'] = this.maintenanceId;
    data['maintenance_code'] = this.maintenanceCode;
    data['warranty_code'] = this.warrantyCode;
    data['packed_code'] = this.packedCode;
    data['packed_name'] = this.packedName;
    data['customer_code'] = this.customerCode;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['birthday'] = this.birthday;
    data['customer_avatar'] = this.customerAvatar;
    data['group_name'] = this.groupName;
    data['full_address'] = this.fullAddress;
    data['status'] = this.status;
    data['maintenance_cost'] = this.maintenanceCost;
    data['date_expired'] = this.dateExpired;
    data['warranty_value'] = this.warrantyValue;
    data['warranty_value_apply'] = this.warrantyValueApply;
    data['insurance_pay'] = this.insurancePay;
    data['amount_pay'] = this.amountPay;
    data['total_amount_pay'] = this.totalAmountPay;
    data['created_at'] = this.createdAt;
    data['date_estimate_delivery'] = this.dateEstimateDelivery;
    data['object_type'] = this.objectType;
    data['object_type_id'] = this.objectTypeId;
    data['object_code'] = this.objectCode;
    data['object_serial'] = this.objectSerial;
    data['object_status'] = this.objectStatus;
    data['maintenance_content'] = this.maintenanceContent;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    if (this.statusUpdate != null) {
      data['status_update'] = this.statusUpdate!.map((v) => v.toJson()).toList();
    }
    data['object_name'] = this.objectName;
    if (this.listCost != null) {
      data['list_cost'] = this.listCost!.map((v) => v.toJson()).toList();
    }
    if (this.listImage != null) {
      data['list_image'] = this.listImage!.map((v) => v.toJson()).toList();
    }
    if (this.receiptDetail != null) {
      data['receipt_detail'] =
          this.receiptDetail!.map((v) => v.toJson()).toList();
    }
    data['total_amount_receipt'] = this.totalAmountReceipt;
    data['is_update'] = this.isUpdate;
    data['is_payment'] = this.isPayment;
    return data;
  }
}

class MaintenanceStatusUpdateModel {
  String? status;
  String? statusName;
  String? statusColor;
  Color? color;

  MaintenanceStatusUpdateModel({this.status, this.statusName, this.statusColor});

  MaintenanceStatusUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
    color = HexColor(statusColor ?? "000000");
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    return data;
  }
}

class MaintenanceDetailCostModel {
  int? maintenanceCostId;
  int? maintenanceId;
  String? maintenanceCostTypeName;
  double? cost;

  MaintenanceDetailCostModel(
      {this.maintenanceCostId,
        this.maintenanceId,
        this.maintenanceCostTypeName,
        this.cost});

  MaintenanceDetailCostModel.fromJson(Map<String, dynamic> json) {
    maintenanceCostId = json['maintenance_cost_id'];
    maintenanceId = json['maintenance_id'];
    maintenanceCostTypeName = json['maintenance_cost_type_name'];
    cost = double.tryParse((json['cost'] ?? 0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_cost_id'] = this.maintenanceCostId;
    data['maintenance_id'] = this.maintenanceId;
    data['maintenance_cost_type_name'] = this.maintenanceCostTypeName;
    data['cost'] = this.cost;
    return data;
  }
}


class MaintenanceImageModel {
  int? maintenanceImageId;
  String? maintenanceCode;
  String? type;
  String? link;

  MaintenanceImageModel(
      {this.maintenanceImageId, this.maintenanceCode, this.type, this.link});

  MaintenanceImageModel.fromJson(Map<String, dynamic> json) {
    maintenanceImageId = json['maintenance_image_id'];
    maintenanceCode = json['maintenance_code'];
    type = json['type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_image_id'] = this.maintenanceImageId;
    data['maintenance_code'] = this.maintenanceCode;
    data['type'] = this.type;
    data['link'] = this.link;
    return data;
  }
}

class MaintenanceDetailReceiptModel {
  int? receiptDetailId;
  int? receiptId;
  int? cashierId;
  String? receiptType;
  double? amount;
  String? cardCode;
  String? createdAt;
  String? paymentMethodCode;
  String? paymentMethodName;

  MaintenanceDetailReceiptModel(
      {this.receiptDetailId,
        this.receiptId,
        this.cashierId,
        this.receiptType,
        this.amount,
        this.cardCode,
        this.createdAt,
        this.paymentMethodCode,
        this.paymentMethodName});

  MaintenanceDetailReceiptModel.fromJson(Map<String, dynamic> json) {
    receiptDetailId = json['receipt_detail_id'];
    receiptId = json['receipt_id'];
    cashierId = json['cashier_id'];
    receiptType = json['receipt_type'];
    amount = double.tryParse((json['amount'] ?? 0).toString());
    cardCode = json['card_code'];
    createdAt = json['created_at'];
    paymentMethodCode = json['payment_method_code'];
    paymentMethodName = json['payment_method_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_detail_id'] = this.receiptDetailId;
    data['receipt_id'] = this.receiptId;
    data['cashier_id'] = this.cashierId;
    data['receipt_type'] = this.receiptType;
    data['amount'] = this.amount;
    data['card_code'] = this.cardCode;
    data['created_at'] = this.createdAt;
    data['payment_method_code'] = this.paymentMethodCode;
    data['payment_method_name'] = this.paymentMethodName;
    return data;
  }
}