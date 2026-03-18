class TicketNotCompletedResponseModel {
  List<TicketNotCompletedModel>? data;

  TicketNotCompletedResponseModel({this.data});

  TicketNotCompletedResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketNotCompletedModel>[];
      json.forEach((v) {
        data!.add(new TicketNotCompletedModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketNotCompletedModel {
  int? ticketQueueId;
  String? queueName;
  int? queueTotal;
  List<TicketNotCompletedItemModel>? items;
  bool? isExpanded;

  TicketNotCompletedModel({this.ticketQueueId, this.queueName, this.queueTotal, this.items});

  TicketNotCompletedModel.fromJson(Map<String, dynamic> json) {
    ticketQueueId = json['ticket_queue_id'];
    queueName = json['queue_name'];
    queueTotal = json['queue_total'];
    if (json['items'] != null) {
      items = <TicketNotCompletedItemModel>[];
      json['items'].forEach((v) {
        items!.add(new TicketNotCompletedItemModel.fromJson(v));
      });
    }
    isExpanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_queue_id'] = this.ticketQueueId;
    data['queue_name'] = this.queueName;
    data['queue_total'] = this.queueTotal;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketNotCompletedItemModel {
  int? statusId;
  String? statusName;
  int? overdueTicketCheck;
  int? total;

  TicketNotCompletedItemModel({this.statusId, this.statusName, this.overdueTicketCheck, this.total});

  TicketNotCompletedItemModel.fromJson(Map<String, dynamic> json) {
    statusId = json['status_id'];
    statusName = json['status_name'];
    overdueTicketCheck = json['overdue_ticket_check'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status_id'] = this.statusId;
    data['status_name'] = this.statusName;
    data['overdue_ticket_check'] = this.overdueTicketCheck;
    data['total'] = this.total;
    return data;
  }
}