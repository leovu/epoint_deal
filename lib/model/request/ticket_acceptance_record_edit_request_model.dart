import 'package:epoint_deal_plugin/model/response/ticket_upload_file_response_model.dart';

class TicketAcceptanceRecordEditRequestModel {
  int? ticketAcceptanceId;
  int? ticketId;
  String? title;
  String? signBy;
  String? signDate;
  String? status;
  List<TicketUploadFileResponseModel>? attached;
  List<TicketAcceptanceRecordEditProposedModel>? proposedMaterials;
  List<TicketAcceptanceRecordEditIncurredModel>? incurredMaterials;

  TicketAcceptanceRecordEditRequestModel(
      {this.ticketAcceptanceId,
        this.ticketId,
        this.title,
        this.signBy,
        this.signDate,
        this.status,
        this.attached,
        this.proposedMaterials,
        this.incurredMaterials});

  TicketAcceptanceRecordEditRequestModel.fromJson(Map<String, dynamic> json) {
    ticketAcceptanceId = json['ticket_acceptance_id'];
    ticketId = json['ticket_id'];
    title = json['title'];
    signBy = json['sign_by'];
    signDate = json['sign_date'];
    status = json['status'];
    if (json['attached'] != null) {
      attached = <TicketUploadFileResponseModel>[];
      json['attached'].forEach((v) {
        attached!.add(new TicketUploadFileResponseModel.fromJson(v));
      });
    }
    if (json['proposed-materials'] != null) {
      proposedMaterials = <TicketAcceptanceRecordEditProposedModel>[];
      json['proposed-materials'].forEach((v) {
        proposedMaterials!.add(new TicketAcceptanceRecordEditProposedModel.fromJson(v));
      });
    }
    if (json['incurred-materials'] != null) {
      incurredMaterials = <TicketAcceptanceRecordEditIncurredModel>[];
      json['incurred-materials'].forEach((v) {
        incurredMaterials!.add(new TicketAcceptanceRecordEditIncurredModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_acceptance_id'] = this.ticketAcceptanceId;
    data['ticket_id'] = this.ticketId;
    data['title'] = this.title;
    data['sign_by'] = this.signBy;
    data['sign_date'] = this.signDate;
    data['status'] = this.status;
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

class TicketAcceptanceRecordEditProposedModel {
  int? ticketRequestMaterialDetailId;
  int? productId;
  int? quantityReality;

  TicketAcceptanceRecordEditProposedModel(
      {this.ticketRequestMaterialDetailId,
        this.productId,
        this.quantityReality});

  TicketAcceptanceRecordEditProposedModel.fromJson(Map<String, dynamic> json) {
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

class TicketAcceptanceRecordEditIncurredModel {
  int? ticketAcceptanceIncurredId;
  int? productId;
  String? productCode;
  String? productName;
  int? quantity;
  int? money;
  String? unitName;

  TicketAcceptanceRecordEditIncurredModel(
      {this.ticketAcceptanceIncurredId,
        this.productId,
        this.productCode,
        this.productName,
        this.quantity,
        this.money,
        this.unitName});

  TicketAcceptanceRecordEditIncurredModel.fromJson(Map<String, dynamic> json) {
    ticketAcceptanceIncurredId = json['ticket_acceptance_incurred_id'];
    productId = json['product_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    quantity = json['quantity'];
    money = json['money'];
    unitName = json['unit_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_acceptance_incurred_id'] = this.ticketAcceptanceIncurredId;
    data['product_id'] = this.productId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['quantity'] = this.quantity;
    data['money'] = this.money;
    data['unit_name'] = this.unitName;
    return data;
  }
}