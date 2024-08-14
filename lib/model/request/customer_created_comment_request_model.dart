class CustomerCreatedCommentRequestModel {
  int? customerId;
  int? customerParentCommentId;
  String? message;
  String? path;

  CustomerCreatedCommentRequestModel(
      {this.customerId, this.customerParentCommentId, this.message, this.path});

  CustomerCreatedCommentRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerParentCommentId = json['customer_parent_comment_id'];
    message = json['message'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_parent_comment_id'] = this.customerParentCommentId;
    data['message'] = this.message;
    data['path'] = this.path;
    return data;
  }
}
