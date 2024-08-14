class TicketMaterialsDetailRequestModel {
  int? ticketRequestMaterialId;

  TicketMaterialsDetailRequestModel({this.ticketRequestMaterialId});

  TicketMaterialsDetailRequestModel.fromJson(Map<String, dynamic> json) {
    ticketRequestMaterialId = json['ticket_request_material_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_request_material_id'] = this.ticketRequestMaterialId;
    return data;
  }
}