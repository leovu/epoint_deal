import 'package:flutter/material.dart';

import 'ticket_detail_response_model.dart';

class TicketAcceptanceRecordResponseModel {
  int? ticketAcceptanceId;
  String? ticketAcceptanceCode;
  String? title;
  String? signBy;
  String? signDate;
  int? customerId;
  String? status;
  String? customerName;
  String? acceptanceNameDefault;
  List<TicketAcceptanceRecordProposedModel>? proposedMaterials;
  List<TicketAcceptanceRecordIncurredModel>? incurredMaterials;
  List<AttachedModel>? attached;

  TicketAcceptanceRecordResponseModel(
      {this.ticketAcceptanceId,
        this.ticketAcceptanceCode,
        this.title,
        this.signBy,
        this.signDate,
        this.customerId,
        this.status,
        this.customerName,
        this.acceptanceNameDefault,
        this.proposedMaterials,
        this.incurredMaterials,
        this.attached});

  TicketAcceptanceRecordResponseModel.fromJson(Map<String, dynamic> json) {
    ticketAcceptanceId = json['ticket_acceptance_id'];
    ticketAcceptanceCode = json['ticket_acceptance_code'];
    title = json['title'];
    signBy = json['sign_by'];
    signDate = json['sign_date'];
    customerId = json['customer_id'];
    status = json['status'];
    customerName = json['customer_name'];
    acceptanceNameDefault = json['acceptance_name_default'];
    if (json['proposed-materials'] != null) {
      proposedMaterials = <TicketAcceptanceRecordProposedModel>[];
      json['proposed-materials'].forEach((v) {
        proposedMaterials!.add(new TicketAcceptanceRecordProposedModel.fromJson(v));
      });
    }
    if (json['incurred-materials'] != null) {
      incurredMaterials = <TicketAcceptanceRecordIncurredModel>[];
      json['incurred-materials'].forEach((v) {
        incurredMaterials!.add(new TicketAcceptanceRecordIncurredModel.fromJson(v));
      });
    }
    if (json['attached'] != null) {
      attached = <AttachedModel>[];
      json['attached'].forEach((v) {
        attached!.add(new AttachedModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_acceptance_id'] = this.ticketAcceptanceId;
    data['ticket_acceptance_code'] = this.ticketAcceptanceCode;
    data['title'] = this.title;
    data['sign_by'] = this.signBy;
    data['sign_date'] = this.signDate;
    data['customer_id'] = this.customerId;
    data['status'] = this.status;
    data['customer_name'] = this.customerName;
    data['acceptance_name_default'] = this.acceptanceNameDefault;
    if (this.proposedMaterials != null) {
      data['proposed-materials'] =
          this.proposedMaterials!.map((v) => v.toJson()).toList();
    }
    if (this.incurredMaterials != null) {
      data['incurred-materials'] =
          this.incurredMaterials!.map((v) => v.toJson()).toList();
    }
    if (this.attached != null) {
      data['attached'] = this.attached!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketAcceptanceRecordProposedModel {
  int? ticketRequestMaterialDetailId;
  int? productId;
  int? quantity;
  int? quantityApprove;
  int? quantityReturn;
  int? quantityReality;
  String? status;
  String? productName;
  String? productCode;
  String? unitName;
  TextEditingController? controller;

  TicketAcceptanceRecordProposedModel(
      {this.ticketRequestMaterialDetailId,
        this.productId,
        this.quantity,
        this.quantityApprove,
        this.quantityReturn,
        this.quantityReality,
        this.status,
        this.productName,
        this.productCode,
        this.unitName,
        this.controller});

  TicketAcceptanceRecordProposedModel.fromJson(Map<String, dynamic> json) {
    ticketRequestMaterialDetailId = json['ticket_request_material_detail_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    quantityApprove = json['quantity_approve'];
    quantityReturn = json['quantity_return'];
    quantityReality = json['quantity_reality'];
    status = json['status'];
    productName = json['product_name'];
    productCode = json['product_code'];
    unitName = json['unit_name'];
    controller = TextEditingController(text: (quantity ?? 1).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_request_material_detail_id'] =
        this.ticketRequestMaterialDetailId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['quantity_approve'] = this.quantityApprove;
    data['quantity_return'] = this.quantityReturn;
    data['quantity_reality'] = this.quantityReality;
    data['status'] = this.status;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['unit_name'] = this.unitName;
    return data;
  }
}

class TicketAcceptanceRecordIncurredModel {
  int? ticketAcceptanceIncurredId;
  int? productId;
  int? quantity;
  String? money;
  String? status;
  String? productName;
  String? productCode;
  String? unitName;

  TicketAcceptanceRecordIncurredModel(
      {this.ticketAcceptanceIncurredId,
        this.productId,
        this.quantity,
        this.money,
        this.status,
        this.productName,
        this.productCode,
        this.unitName});

  TicketAcceptanceRecordIncurredModel.fromJson(Map<String, dynamic> json) {
    ticketAcceptanceIncurredId = json['ticket_acceptance_incurred_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    money = json['money'];
    status = json['status'];
    productName = json['product_name'];
    productCode = json['product_code'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_acceptance_incurred_id'] = this.ticketAcceptanceIncurredId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['money'] = this.money;
    data['status'] = this.status;
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['unit_name'] = this.unitName;
    return data;
  }
}