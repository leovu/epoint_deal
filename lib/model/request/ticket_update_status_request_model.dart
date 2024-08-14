class TicketUpdateStatusRequestModel {
  int? ticketId;
  int? ticketStatusId;

  TicketUpdateStatusRequestModel({this.ticketId, this.ticketStatusId});

  TicketUpdateStatusRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    ticketStatusId = json['ticket_status_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['ticket_status_id'] = this.ticketStatusId;
    return data;
  }
}
