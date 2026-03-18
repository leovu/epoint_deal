class TicketLocationAddRequestModel {
  int? ticketId;
  String? lat;
  String? lng;
  String? description;

  TicketLocationAddRequestModel({this.ticketId, this.lat, this.lng, this.description});

  TicketLocationAddRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    lat = json['lat'];
    lng = json['lng'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['description'] = this.description;
    return data;
  }
}
