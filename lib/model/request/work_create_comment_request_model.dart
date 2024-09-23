class WorkCreateCommentRequestModel {
  int? dealID;
  int? parentDealCommentId;
  String? message;
  String? path;

  WorkCreateCommentRequestModel(
      {this.dealID, this.parentDealCommentId, this.message, this.path});

  WorkCreateCommentRequestModel.fromJson(Map<String, dynamic> json) {
    dealID = json['deal_id'];
    parentDealCommentId = json['parent_deal_comment_id'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_id'] = this.dealID;
    data['parent_deal_comment_id'] = this.parentDealCommentId;
    data['message'] = this.message;
    data['path'] = this.path;
    return data;
  }
}