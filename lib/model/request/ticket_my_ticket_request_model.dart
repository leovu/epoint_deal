class TicketMyTicketRequestModel {
  String? typeTicket;
  int? ticketStatusId;
  String? ticketType;
  int? issuleLevel;
  String? priority;
  String? time;
  String? createdFrom;
  String? createdTo;
  int? ticketQueueId;
  int? overdueTicketCheck;
  int? page;

  TicketMyTicketRequestModel(
      {this.typeTicket,
        this.ticketStatusId,
        this.ticketType,
        this.issuleLevel,
        this.priority,
        this.time,
        this.createdFrom,
        this.createdTo,
        this.page,
        this.ticketQueueId,
        this.overdueTicketCheck});

  TicketMyTicketRequestModel.fromJson(Map<String, dynamic> json) {
    typeTicket = json['type_ticket'];
    ticketStatusId = json['ticket_status_id'];
    ticketType = json['ticket_type'];
    issuleLevel = json['issule_level'];
    priority = json['priority'];
    createdFrom = json['created_from'];
    createdTo = json['created_to'];
    ticketQueueId = json['ticket_queue_id'];
    page = json['page'];
    overdueTicketCheck = json['overdue_ticket_check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if(this.typeTicket != null) data['type_ticket'] = this.typeTicket;
    if(this.ticketStatusId != null) data['ticket_status_id'] = this.ticketStatusId;
    if(this.ticketType != null) data['ticket_type'] = this.ticketType;
    if(this.issuleLevel != null) data['issule_level'] = this.issuleLevel;
    if(this.priority != null) data['priority'] = this.priority;
    if(this.createdFrom != null) data['created_from'] = this.createdFrom;
    if(this.createdTo != null) data['created_to'] = this.createdTo;
    if(this.ticketQueueId != null) data['ticket_queue_id'] = this.ticketQueueId;
    if(this.page != null) data['page'] = this.page;
    data['overdue_ticket_check'] = this.overdueTicketCheck;
    return data;
  }
}