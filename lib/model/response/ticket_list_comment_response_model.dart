class TicketListCommentResponseModel {
  List<TicketListCommentModel>? data;

  TicketListCommentResponseModel({this.data});

  TicketListCommentResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketListCommentModel>[];
      json.forEach((v) {
        data!.add(new TicketListCommentModel.fromJson(v));
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

class TicketListCommentModel {
  int? ticketCommentId;
  int? ticketId;
  int? ticketParentCommentId;
  int? staffId;
  String? staffName;
  String? staffAvatar;
  String? message;
  String? path;
  String? timeText;
  List<TicketListCommentModel>? listObject;
  late bool isSubComment;

  TicketListCommentModel(
      {this.ticketCommentId,
        this.ticketId,
        this.ticketParentCommentId,
        this.staffId,
        this.staffName,
        this.staffAvatar,
        this.message,
        this.path,
        this.timeText,
        this.listObject});

  TicketListCommentModel.fromJson(Map<String, dynamic> json) {
    ticketCommentId = json['ticket_comment_id'];
    ticketId = json['ticket_id'];
    ticketParentCommentId = json['ticket_parent_comment_id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    staffAvatar = json['staff_avatar'];
    message = json['message'];
    path = json['path'];
    timeText = json['time_text'];
    if (json['list_object'] != null) {
      listObject = <TicketListCommentModel>[];
      json['list_object'].forEach((v) {
        var model = TicketListCommentModel.fromJson(v);
        model.isSubComment = true;
        listObject!.add(model);
      });
    }
    isSubComment = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_comment_id'] = this.ticketCommentId;
    data['ticket_id'] = this.ticketId;
    data['ticket_parent_comment_id'] = this.ticketParentCommentId;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['staff_avatar'] = this.staffAvatar;
    data['message'] = this.message;
    data['path'] = this.path;
    data['time_text'] = this.timeText;
    if (this.listObject != null) {
      data['list_object'] = this.listObject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}