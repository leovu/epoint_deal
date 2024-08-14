class TicketAddRequestModel {
  int? localtionId;
  int? ticketIssueId;
  int? ticketIssueGroupId;
  String? title;
  String? description;
  String? customerAddress;
  int? customerId;
  int? issuleLevel;
  String? dateEstimated;
  String? priority;
  String? dateIssue;
  int? staffNotificationId;
  int? queueProcessId;
  int? operateBy;
  List<int?>? processor;
  List<String?>? file;

  TicketAddRequestModel(
      {this.localtionId,
        this.ticketIssueId,
        this.ticketIssueGroupId,
        this.title,
        this.description,
        this.customerAddress,
        this.customerId,
        this.issuleLevel,
        this.dateEstimated,
        this.priority,
        this.dateIssue,
        this.staffNotificationId,
        this.queueProcessId,
        this.operateBy,
        this.processor,
        this.file});

  TicketAddRequestModel.fromJson(Map<String, dynamic> json) {
    localtionId = json['localtion_id'];
    ticketIssueId = json['ticket_issue_id'];
    ticketIssueGroupId = json['ticket_issue_group_id'];
    title = json['title'];
    description = json['description'];
    customerAddress = json['customer_address'];
    customerId = json['customer_id'];
    issuleLevel = json['issule_level'];
    dateEstimated = json['date_estimated'];
    priority = json['priority'];
    dateIssue = json['date_issue'];
    staffNotificationId = json['staff_notification_id'];
    queueProcessId = json['queue_process_id'];
    operateBy = json['operate_by'];
    processor = json['processor'].cast<int>();
    file = json['file'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['localtion_id'] = this.localtionId;
    data['ticket_issue_id'] = this.ticketIssueId;
    data['ticket_issue_group_id'] = this.ticketIssueGroupId;
    data['title'] = this.title;
    data['description'] = this.description;
    data['customer_address'] = this.customerAddress;
    data['customer_id'] = this.customerId;
    data['issule_level'] = this.issuleLevel;
    data['date_estimated'] = this.dateEstimated;
    data['priority'] = this.priority;
    data['date_issue'] = this.dateIssue;
    data['staff_notification_id'] = this.staffNotificationId;
    data['queue_process_id'] = this.queueProcessId;
    data['operate_by'] = this.operateBy;
    data['processor'] = this.processor;
    data['file'] = this.file;
    return data;
  }
}
