class TicketTotalHomeResponseModel {
  int? totalTicket;
  int? newTicket;
  int? myTicket;
  int? unfinishedTicket;
  int? overdueTicket;
  List<dynamic>? chart;

  TicketTotalHomeResponseModel(
      {this.totalTicket,
        this.newTicket,
        this.myTicket,
        this.unfinishedTicket,
        this.overdueTicket,
        this.chart});

  TicketTotalHomeResponseModel.fromJson(Map<String, dynamic> json) {
    totalTicket = json['total_ticket'];
    newTicket = json['new_ticket'];
    myTicket = json['my_ticket'];
    unfinishedTicket = json['unfinished_ticket'];
    overdueTicket = json['overdue_ticket'];
    chart = json['chart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_ticket'] = this.totalTicket;
    data['new_ticket'] = this.newTicket;
    data['my_ticket'] = this.myTicket;
    data['unfinished_ticket'] = this.unfinishedTicket;
    data['overdue_ticket'] = this.overdueTicket;
    data['chart'] = this.chart;
    return data;
  }
}