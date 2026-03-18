class TicketEditRequestModel {
  int? ticketId;
  int? ticketIssueId;
  String? title;
  String? description;
  String? customerAddress;
  String? dateEstimated;
  int? ticketStatusId;
  int? ticketQueueId;
  int? staffHostId;
  List<TicketEditStaffModel>? staffHandler;

  TicketEditRequestModel(
      {this.ticketId,
        this.ticketIssueId,
        this.title,
        this.description,
        this.customerAddress,
        this.dateEstimated,
        this.ticketStatusId,
        this.ticketQueueId,
        this.staffHostId,
        this.staffHandler});

  TicketEditRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    ticketIssueId = json['ticket_issue_id'];
    title = json['title'];
    description = json['description'];
    customerAddress = json['customer_address'];
    dateEstimated = json['date_estimated'];
    ticketStatusId = json['ticket_status_id'];
    ticketQueueId = json['ticket_queue_id'];
    staffHostId = json['staff_host_id'];
    if (json['staff_handler'] != null) {
      staffHandler = <TicketEditStaffModel>[];
      json['staff_handler'].forEach((v) {
        staffHandler!.add(new TicketEditStaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['ticket_issue_id'] = this.ticketIssueId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['customer_address'] = this.customerAddress;
    data['date_estimated'] = this.dateEstimated;
    data['ticket_status_id'] = this.ticketStatusId;
    data['ticket_queue_id'] = this.ticketQueueId;
    data['staff_host_id'] = this.staffHostId;
    if (this.staffHandler != null) {
      data['staff_handler'] = this.staffHandler!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketEditStaffModel {
  int? staffId;

  TicketEditStaffModel({this.staffId});

  TicketEditStaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    return data;
  }
}