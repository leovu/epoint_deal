class TicketListStaffRequestModel {
  int? ticketQueueId;

  TicketListStaffRequestModel({this.ticketQueueId});

  TicketListStaffRequestModel.fromJson(Map<String, dynamic> json) {
    ticketQueueId = json['ticket_queue_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_queue_id'] = this.ticketQueueId;
    return data;
  }
}