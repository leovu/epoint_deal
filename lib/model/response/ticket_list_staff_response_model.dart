class TicketListStaffResponseModel {
  List<TicketListStaffModel>? staffHandler;

  TicketListStaffResponseModel({this.staffHandler});

  TicketListStaffResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['staff_handler'] != null) {
      staffHandler = <TicketListStaffModel>[];
      json['staff_handler'].forEach((v) {
        staffHandler!.add(new TicketListStaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.staffHandler != null) {
      data['staff_handler'] = this.staffHandler!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketListStaffModel {
  int? staffId;
  String? userName;
  int? ticketRoleQueueId;
  String? ticketRoleQueueName;

  TicketListStaffModel(
      {this.staffId,
        this.userName,
        this.ticketRoleQueueId,
        this.ticketRoleQueueName});

  TicketListStaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    userName = json['user_name'];
    ticketRoleQueueId = json['ticket_role_queue_id'];
    ticketRoleQueueName = json['ticket_role_queue_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['user_name'] = this.userName;
    data['ticket_role_queue_id'] = this.ticketRoleQueueId;
    data['ticket_role_queue_name'] = this.ticketRoleQueueName;
    return data;
  }
}