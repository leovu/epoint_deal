import 'ticket_acceptance_record_response_model.dart';

class TicketInfoMaterialsResponseModel {
  List<TicketInfoMaterialsRequestFormModel>? requestForm;
  List<TicketInfoMaterialsProposedModel>? proposedMaterials;
  List<TicketAcceptanceRecordIncurredModel>? incurredMaterials;

  TicketInfoMaterialsResponseModel({
    this.requestForm,
    this.proposedMaterials,
    this.incurredMaterials,
  });

  TicketInfoMaterialsResponseModel.fromJson(Map<String, dynamic> json) {
    requestForm = <TicketInfoMaterialsRequestFormModel>[];
    if (json['request_form'] != null) {
      json['request_form'].forEach((v) {
        requestForm!.add(new TicketInfoMaterialsRequestFormModel.fromJson(v));
      });
    }
    if (json['proposed-materials'] != null) {
      proposedMaterials = <TicketInfoMaterialsProposedModel>[];
      json['proposed-materials'].forEach((v) {
        proposedMaterials!.add(new TicketInfoMaterialsProposedModel.fromJson(v));
      });
    }
    if (json['incurred-materials'] != null) {
      incurredMaterials = <TicketAcceptanceRecordIncurredModel>[];
      json['incurred-materials'].forEach((v) {
        incurredMaterials!.add(new TicketAcceptanceRecordIncurredModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestForm != null) {
      data['request_form'] = this.requestForm!.map((v) => v.toJson()).toList();
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

class TicketInfoMaterialsRequestFormModel {
  int? ticketRequestMaterialId;
  String? ticketRequestMaterialCode;
  int? ticketId;
  int? proposerBy;
  String? proposerName;
  String? proposerDate;
  int? approvedBy;
  String? approvedName;
  String? approvedDate;
  String? description;
  String? status;
  String? statusName;

  TicketInfoMaterialsRequestFormModel(
      {this.ticketRequestMaterialId,
        this.ticketRequestMaterialCode,
        this.ticketId,
        this.proposerBy,
        this.proposerName,
        this.proposerDate,
        this.approvedBy,
        this.approvedName,
        this.approvedDate,
        this.description,
        this.status,
        this.statusName});

  TicketInfoMaterialsRequestFormModel.fromJson(Map<String, dynamic> json) {
    ticketRequestMaterialId = json['ticket_request_material_id'];
    ticketRequestMaterialCode = json['ticket_request_material_code'];
    ticketId = json['ticket_id'];
    proposerBy = json['proposer_by'];
    proposerName = json['proposer_name'];
    proposerDate = json['proposer_date'];
    approvedBy = json['approved_by'];
    approvedName = json['approved_name'];
    approvedDate = json['approved_date'];
    description = json['description'];
    status = json['status'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_request_material_id'] = this.ticketRequestMaterialId;
    data['ticket_request_material_code'] = this.ticketRequestMaterialCode;
    data['ticket_id'] = this.ticketId;
    data['proposer_by'] = this.proposerBy;
    data['proposer_name'] = this.proposerName;
    data['proposer_date'] = this.proposerDate;
    data['approved_by'] = this.approvedBy;
    data['approved_name'] = this.approvedName;
    data['approved_date'] = this.approvedDate;
    data['description'] = this.description;
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    return data;
  }
}

class TicketInfoMaterialsProposedModel {
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

  TicketInfoMaterialsProposedModel(
      {this.ticketRequestMaterialDetailId,
        this.productId,
        this.quantity,
        this.quantityApprove,
        this.quantityReturn,
        this.quantityReality,
        this.status,
        this.productName,
        this.productCode,
        this.unitName});

  TicketInfoMaterialsProposedModel.fromJson(Map<String, dynamic> json) {
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