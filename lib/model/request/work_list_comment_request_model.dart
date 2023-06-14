class WorkListCommentRequestModel {
  int? dealId;

  WorkListCommentRequestModel({this.dealId});

  WorkListCommentRequestModel.fromJson(Map<String, dynamic> json) {
    dealId = json['deal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_id'] = this.dealId;
    return data;
  }
}