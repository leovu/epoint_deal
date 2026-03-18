class TicketIssueRequestModel {
  int? ticketIssueGroupId;

  TicketIssueRequestModel({this.ticketIssueGroupId});

  TicketIssueRequestModel.fromJson(Map<String, dynamic> json) {
    ticketIssueGroupId = json['ticket_issue_group_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_issue_group_id'] = this.ticketIssueGroupId;
    return data;
  }
}