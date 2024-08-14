class TicketStaffQueueResponseModel {
  List<TicketStaffQueueModel>? staffHost;
  List<TicketStaffQueueModel>? staffHandler;

  TicketStaffQueueResponseModel({this.staffHost, this.staffHandler});

  TicketStaffQueueResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['staff_host'] != null) {
      staffHost = <TicketStaffQueueModel>[];
      json['staff_host'].forEach((v) {
        staffHost!.add(new TicketStaffQueueModel.fromJson(v));
      });
    }
    if (json['staff_handler'] != null) {
      staffHandler = <TicketStaffQueueModel>[];
      json['staff_handler'].forEach((v) {
        staffHandler!.add(new TicketStaffQueueModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.staffHost != null) {
      data['staff_host'] = this.staffHost!.map((v) => v.toJson()).toList();
    }
    if (this.staffHandler != null) {
      data['staff_handler'] = this.staffHandler!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketStaffQueueModel {
  int? staffId;
  String? userName;
  String? staffAvatar;
  int? ticketRoleQueueId;
  String? ticketRoleQueueName;
  bool? isSelected;

  TicketStaffQueueModel(
      {this.staffId,
        this.userName,
        this.staffAvatar,
        this.ticketRoleQueueId,
        this.ticketRoleQueueName});

  TicketStaffQueueModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    userName = json['user_name'];
    staffAvatar = json['staff_avatar'];
    ticketRoleQueueId = json['ticket_role_queue_id'];
    ticketRoleQueueName = json['ticket_role_queue_name'];
    isSelected = json['is_selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['user_name'] = this.userName;
    data['staff_avatar'] = this.staffAvatar;
    data['ticket_role_queue_id'] = this.ticketRoleQueueId;
    data['ticket_role_queue_name'] = this.ticketRoleQueueName;
    data['is_selected'] = this.isSelected;
    return data;
  }
}
