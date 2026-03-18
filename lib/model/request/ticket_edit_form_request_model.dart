class TicketEditFormRequestModel {
  int? ticketRequestMaterialId;
  String? description;
  List<TicketEditFormMaterialModel>? material;

  TicketEditFormRequestModel(
      {this.ticketRequestMaterialId, this.description, this.material});

  TicketEditFormRequestModel.fromJson(Map<String, dynamic> json) {
    ticketRequestMaterialId = json['ticket_request_material_id'];
    description = json['description'];
    if (json['material'] != null) {
      material = <TicketEditFormMaterialModel>[];
      json['material'].forEach((v) {
        material!.add(new TicketEditFormMaterialModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_request_material_id'] = this.ticketRequestMaterialId;
    data['description'] = this.description;
    if (this.material != null) {
      data['material'] = this.material!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketEditFormMaterialModel {
  int? ticketRequestMaterialDetailId;
  int? productId;
  int? quantity;

  TicketEditFormMaterialModel({this.ticketRequestMaterialDetailId, this.productId, this.quantity});

  TicketEditFormMaterialModel.fromJson(Map<String, dynamic> json) {
    ticketRequestMaterialDetailId = json['ticket_request_material_detail_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.ticketRequestMaterialDetailId != null) data['ticket_request_material_detail_id'] =
        this.ticketRequestMaterialDetailId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}