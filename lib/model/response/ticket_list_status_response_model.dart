class TicketListStatusResponseModel {
  List<TicketListStatusModel>? data;

  TicketListStatusResponseModel({this.data});

  TicketListStatusResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketListStatusModel>[];
      json.forEach((v) {
        data!.add(new TicketListStatusModel.fromJson(v));
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

class TicketListStatusModel {
  int? ticketStatusId;
  String? ticketStatusValue;
  String? statusName;

  TicketListStatusModel({this.ticketStatusId, this.ticketStatusValue, this.statusName});

  TicketListStatusModel.fromJson(Map<String, dynamic> json) {
    ticketStatusId = json['ticket_status_id'];
    ticketStatusValue = json['ticket_status_value'];
    statusName = json['status_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_status_id'] = this.ticketStatusId;
    data['ticket_status_value'] = this.ticketStatusValue;
    data['status_name'] = this.statusName;
    return data;
  }
}