class TicketLocationDeleteRequestModel {
  int? ticketLocationId;

  TicketLocationDeleteRequestModel({this.ticketLocationId});

  TicketLocationDeleteRequestModel.fromJson(Map<String, dynamic> json) {
    ticketLocationId = json['ticket_location_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_location_id'] = this.ticketLocationId;
    return data;
  }
}
