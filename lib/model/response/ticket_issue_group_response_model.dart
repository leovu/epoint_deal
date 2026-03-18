class TicketIssueGroupResponseModel {
  List<TicketIssueGroupModel>? data;

  TicketIssueGroupResponseModel({this.data});

  TicketIssueGroupResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketIssueGroupModel>[];
      json.forEach((v) {
        data!.add(new TicketIssueGroupModel.fromJson(v));
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

class TicketIssueGroupModel {
  int? ticketIssueGroupId;
  String? type;
  String? name;

  TicketIssueGroupModel({this.ticketIssueGroupId, this.type, this.name});

  TicketIssueGroupModel.fromJson(Map<String, dynamic> json) {
    ticketIssueGroupId = json['ticket_issue_group_id'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_issue_group_id'] = this.ticketIssueGroupId;
    data['type'] = this.type;
    data['name'] = this.name;
    return data;
  }
}
