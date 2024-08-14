class CustomerListCommentRequestModel {
  int? customerId;

  CustomerListCommentRequestModel({this.customerId});

  CustomerListCommentRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    return data;
  }
}
