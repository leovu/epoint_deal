class TicketRatingDetailRequestModel {
  int? ticketId;

  TicketRatingDetailRequestModel({this.ticketId});

  TicketRatingDetailRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    return data;
  }
}