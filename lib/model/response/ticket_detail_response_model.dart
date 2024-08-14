import 'ticket_list_status_response_model.dart';

class TicketDetailResponseModel {
  int? ticketId;
  String? ticketCode;
  String? locationName;
  String? ticketType;
  int? ticketIssueGroupId;
  String? ticketIssueGroupName;
  int? ticketIssueId;
  String? ticketIssueName;
  int? issuleLevel;
  String? priority;
  String? title;
  String? description;
  String? manageWorkCustomerType;
  int? customerId;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? dateIssue;
  String? dateExpected;
  String? dateEstimated;
  String? dateFinished;
  String? dateRequest;
  int? queueProcessId;
  String? queueName;
  int? ticketStatusId;
  String? statusName;
  String? staffNotiName;
  int? staffHostId;
  String? staffHostName;
  List<StaffHandler>? staffHandler;
  List<AttachedModel>? attached;
  List<TicketListStatusModel>? listStatus;
  int? ticketAlertId;
  int? editTicket;

  TicketDetailResponseModel(
      {this.ticketId,
        this.ticketCode,
        this.locationName,
        this.ticketType,
        this.ticketIssueGroupId,
        this.ticketIssueGroupName,
        this.ticketIssueId,
        this.ticketIssueName,
        this.issuleLevel,
        this.priority,
        this.title,
        this.description,
        this.manageWorkCustomerType,
        this.customerId,
        this.customerName,
        this.customerPhone,
        this.customerAddress,
        this.dateIssue,
        this.dateExpected,
        this.dateEstimated,
        this.dateFinished,
        this.dateRequest,
        this.queueName,
        this.ticketStatusId,
        this.queueProcessId,
        this.statusName,
        this.staffNotiName,
        this.staffHostId,
        this.staffHostName,
        this.staffHandler,
        this.attached,
        this.listStatus,
        this.ticketAlertId,
        this.editTicket});

  TicketDetailResponseModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    ticketCode = json['ticket_code'];
    locationName = json['location_name'];
    ticketType = json['ticket_type'];
    ticketIssueGroupId = json['ticket_issue_group_id'];
    ticketIssueGroupName = json['ticket_issue_group_name'];
    ticketIssueId = json['ticket_issue_id'];
    ticketIssueName = json['ticket_issue_name'];
    issuleLevel = json['issule_level'];
    priority = json['priority'];
    title = json['title'];
    description = json['description'];
    manageWorkCustomerType = json['manage_work_customer_type'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerPhone = json['customer_phone'];
    customerAddress = json['customer_address'];
    dateIssue = json['date_issue'];
    dateExpected = json['date_expected'];
    dateEstimated = json['date_estimated'];
    dateFinished = json['date_finished'];
    dateRequest = json['date_request'];
    queueName = json['queue_name'];
    ticketStatusId = json['ticket_status_id'];
    queueProcessId = json['queue_process_id'];
    statusName = json['status_name'];
    staffNotiName = json['staff_noti_name'];
    staffHostId = json['staff_host_id'];
    staffHostName = json['staff_host_name'];
    if (json['staff_handler'] != null) {
      staffHandler = <StaffHandler>[];
      json['staff_handler'].forEach((v) {
        staffHandler!.add(new StaffHandler.fromJson(v));
      });
    }
    if (json['attached'] != null) {
      attached = <AttachedModel>[];
      json['attached'].forEach((v) {
        attached!.add(new AttachedModel.fromJson(v));
      });
    }
    if (json['list_status'] != null) {
      listStatus = <TicketListStatusModel>[];
      json['list_status'].forEach((v) {
        listStatus!.add(new TicketListStatusModel.fromJson(v));
      });
    }
    ticketAlertId = json['ticket_alert_id'];
    editTicket = json['edit_ticket'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['ticket_code'] = this.ticketCode;
    data['location_name'] = this.locationName;
    data['ticket_type'] = this.ticketType;
    data['ticket_issue_group_id'] = this.ticketIssueGroupId;
    data['ticket_issue_group_name'] = this.ticketIssueGroupName;
    data['ticket_issue_id'] = this.ticketIssueId;
    data['ticket_issue_name'] = this.ticketIssueName;
    data['issule_level'] = this.issuleLevel;
    data['priority'] = this.priority;
    data['title'] = this.title;
    data['description'] = this.description;
    data['manage_work_customer_type'] = this.manageWorkCustomerType;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_phone'] = this.customerPhone;
    data['customer_address'] = this.customerAddress;
    data['date_issue'] = this.dateIssue;
    data['date_expected'] = this.dateExpected;
    data['date_estimated'] = this.dateEstimated;
    data['date_finished'] = this.dateFinished;
    data['date_request'] = this.dateRequest;
    data['queue_process_id'] = this.queueProcessId;
    data['queue_name'] = this.queueName;
    data['ticket_status_id'] = this.ticketStatusId;
    data['status_name'] = this.statusName;
    data['staff_noti_name'] = this.staffNotiName;
    data['staff_host_id'] = this.staffHostId;
    data['staff_host_name'] = this.staffHostName;
    if (this.staffHandler != null) {
      data['staff_handler'] = this.staffHandler!.map((v) => v.toJson()).toList();
    }
    if (this.attached != null) {
      data['attached'] = this.attached!.map((v) => v.toJson()).toList();
    }
    if (this.listStatus != null) {
      data['list_status'] = this.listStatus!.map((v) => v.toJson()).toList();
    }
    data['ticket_alert_id'] = this.ticketAlertId;
    data['edit_ticket'] = this.editTicket;
    return data;
  }
}

class StaffHandler {
  int? staffId;
  String? userName;
  String? staffAvatar;

  StaffHandler({this.staffId, this.userName, this.staffAvatar});

  StaffHandler.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    userName = json['user_name'];
    staffAvatar = json['staff_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['user_name'] = this.userName;
    data['staff_avatar'] = this.staffAvatar;
    return data;
  }
}

class AttachedModel {
  String? path;
  String? type;

  AttachedModel({this.path, this.type});

  AttachedModel.fromJson(Map<String, dynamic> json) {
    path = json['path'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['path'] = this.path;
    data['type'] = this.type;
    return data;
  }
}