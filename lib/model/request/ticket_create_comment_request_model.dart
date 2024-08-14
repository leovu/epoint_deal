class TicketCreateCommentRequestModel {
  int? ticketId;
  int? ticketParentCommentId;
  String? message;
  String? path;

  TicketCreateCommentRequestModel(
      {this.ticketId, this.ticketParentCommentId, this.message, this.path});

  TicketCreateCommentRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    ticketParentCommentId = json['ticket_parent_comment_id'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    data['ticket_parent_comment_id'] = this.ticketParentCommentId;
    data['message'] = this.message;
    data['path'] = this.path;
    return data;
  }
}
