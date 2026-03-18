class TicketListQueueResponseModel {
  List<TicketListQueueModel>? data;

  TicketListQueueResponseModel({this.data});

  TicketListQueueResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketListQueueModel>[];
      json.forEach((v) {
        data!.add(new TicketListQueueModel.fromJson(v));
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

class TicketListQueueModel {
  int? ticketQueueId;
  String? queueName;

  TicketListQueueModel({this.ticketQueueId, this.queueName});

  TicketListQueueModel.fromJson(Map<String, dynamic> json) {
    ticketQueueId = json['ticket_queue_id'];
    queueName = json['queue_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_queue_id'] = this.ticketQueueId;
    data['queue_name'] = this.queueName;
    return data;
  }
}