class WorkCreateCommentRequestModel {
  int dealID;
  int dealParentCommentId;
  String message;
  String path;

  WorkCreateCommentRequestModel(
      {this.dealID, this.dealParentCommentId, this.message, this.path});

  WorkCreateCommentRequestModel.fromJson(Map<String, dynamic> json) {
    dealID = json['deal_id'];
    dealParentCommentId = json['deal_parent_comment_id'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_id'] = this.dealID;
    data['deal_parent_comment_id'] = this.dealParentCommentId;
    data['message'] = this.message;
    data['path'] = this.path;
    return data;
  }
}