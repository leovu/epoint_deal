class WorkListCommentRequestModel {
  int? manageWorkId;
  int? dealId;

  WorkListCommentRequestModel({this.manageWorkId, this.dealId});

  WorkListCommentRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    dealId = json['deal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['deal_id'] = this.dealId;
    return data;
  }
}