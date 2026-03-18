

import 'package:epoint_deal_plugin/model/response/ticket_upload_file_response_model.dart';

class TicketAcceptanceRecordCreateRequestModel {
  int? ticketId;
  String? title;
  List<TicketUploadFileResponseModel>? attached;
  List<TicketAcceptanceRecordCreateProposedModel>? proposedMaterials;
  List<TicketAcceptanceRecordCreateIncurredModel>? incurredMaterials;

  TicketAcceptanceRecordCreateRequestModel(
      {this.ticketId,
        this.title,
        this.attached,
        this.proposedMaterials,
        this.incurredMaterials});

  TicketAcceptanceRecordCreateRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    title = json['title'];
    if (json['attached'] != null) {
      attached = <TicketUploadFileResponseModel>[];
      json['attached'].forEach((v) {
        attached!.add(new TicketUploadFileResponseModel.fromJson(v));
      });
    }
    if (json['proposed-materials'] != null) {
      proposedMaterials = <TicketAcceptanceRecordCreateProposedModel>[];
      json['proposed-materials'].forEach((v) {
        proposedMaterials!.add(new TicketAcceptanceRecordCreateProposedModel.fromJson(v));
      });
    }
    if (json['incurred-materials'] != null) {
      incurredMaterials = <TicketAcceptanceRecordCreateIncurredModel>[];
      json['incurred-materials'].forEach((v) {
        incurredMaterials!.add(new TicketAcceptanceRecordCreateIncurredModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['title'] = this.title;
    if (this.attached != null) {
      data['attached'] = this.attached!.map((v) => v.toJson()).toList();
    }
    if (this.proposedMaterials != null) {
      data['proposed-materials'] =
          this.proposedMaterials!.map((v) => v.toJson()).toList();
    }
    if (this.incurredMaterials != null) {
      data['incurred-materials'] =
          this.incurredMaterials!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketAcceptanceRecordCreateProposedModel {
  int? ticketRequestMaterialDetailId;
  int? productId;
  int? quantityReality;

  TicketAcceptanceRecordCreateProposedModel(
      {this.ticketRequestMaterialDetailId,
        this.productId,
        this.quantityReality});

  TicketAcceptanceRecordCreateProposedModel.fromJson(Map<String, dynamic> json) {
    ticketRequestMaterialDetailId = json['ticket_request_material_detail_id'];
    productId = json['product_id'];
    quantityReality = json['quantity_reality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_request_material_detail_id'] =
        this.ticketRequestMaterialDetailId;
    data['product_id'] = this.productId;
    data['quantity_reality'] = this.quantityReality;
    return data;
  }
}

class TicketAcceptanceRecordCreateIncurredModel {
  int? productId;
  String? productCode;
  String? productName;
  int? quantity;
  int? money;
  String? unitName;

  TicketAcceptanceRecordCreateIncurredModel(
      {this.productId,
        this.productCode,
        this.productName,
        this.quantity,
        this.money,
        this.unitName});

  TicketAcceptanceRecordCreateIncurredModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    quantity = json['quantity'];
    money = json['money'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['money'] = this.money;
    data['unit_name'] = this.unitName;
    return data;
  }
}