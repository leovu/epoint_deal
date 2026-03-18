class TicketAddFormRequestModel {
  int? ticketId;
  String? description;
  List<TicketAddFormMaterialModel>? material;

  TicketAddFormRequestModel({this.ticketId, this.description, this.material});

  TicketAddFormRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    description = json['description'];
    if (json['material'] != null) {
      material = <TicketAddFormMaterialModel>[];
      json['material'].forEach((v) {
        material!.add(new TicketAddFormMaterialModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['description'] = this.description;
    if (this.material != null) {
      data['material'] = this.material!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketAddFormMaterialModel {
  int? productId;
  int? quantity;

  TicketAddFormMaterialModel({this.productId, this.quantity});

  TicketAddFormMaterialModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}