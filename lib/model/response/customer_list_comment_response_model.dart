class CustomerListCommentResponseModel {
  List<CustomerListCommentModel>? data;

  CustomerListCommentResponseModel({this.data});

  CustomerListCommentResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerListCommentModel>[];
      json.forEach((v) {
        data!.add(new CustomerListCommentModel.fromJson(v));
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

class CustomerListCommentModel {
  int? customerCommentId;
  int? customerId;
  int? customerParentCommentId;
  int? staffId;
  String? staffName;
  String? staffAvatar;
  String? message;
  String? path;
  String? timeText;
  List<CustomerListCommentModel>? listObject;
  late bool isSubComment;

  CustomerListCommentModel(
      {this.customerCommentId,
        this.customerId,
        this.customerParentCommentId,
        this.staffId,
        this.staffName,
        this.staffAvatar,
        this.message,
        this.path,
        this.timeText,
        this.listObject});

  CustomerListCommentModel.fromJson(Map<String, dynamic> json) {
    customerCommentId = json['customer_comment_id'];
    customerId = json['customer_id'];
    customerParentCommentId = json['customer_parent_comment_id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    staffAvatar = json['staff_avatar'];
    message = json['message'];
    path = json['path'];
    timeText = json['time_text'];
    if (json['list_object'] != null) {
      listObject = <CustomerListCommentModel>[];
      json['list_object'].forEach((v) {
        var model = CustomerListCommentModel.fromJson(v);
        model.isSubComment = true;
        listObject!.add(model);
      });
    }
    isSubComment = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_comment_id'] = this.customerCommentId;
    data['customer_id'] = this.customerId;
    data['customer_parent_comment_id'] = this.customerParentCommentId;
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
