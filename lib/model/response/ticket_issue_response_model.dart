class TicketIssueResponseModel {
  List<TicketIssueModel>? data;

  TicketIssueResponseModel({this.data});

  TicketIssueResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketIssueModel>[];
      json.forEach((v) {
        data!.add(new TicketIssueModel.fromJson(v));
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

class TicketIssueModel {
  int? ticketIssueId;
  String? name;
  int? level;

  TicketIssueModel({this.ticketIssueId, this.name, this.level});

  TicketIssueModel.fromJson(Map<String, dynamic> json) {
    ticketIssueId = json['ticket_issue_id'];
    name = json['name'];
    level = int.tryParse((json['level'] ?? 0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_issue_id'] = this.ticketIssueId;
    data['name'] = this.name;
    data['level'] = this.level;
    return data;
  }
}