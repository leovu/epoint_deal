class WorkListCommentResponseModel {
  int errorCode;
  String errorDescription;
  List<WorkListCommentModel> data;

  WorkListCommentResponseModel({this.errorCode, this.errorDescription, this.data});

  WorkListCommentResponseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    if (json['Data'] != null) {
      data = <WorkListCommentModel>[];
      json['Data'].forEach((v) {
        data.add(new WorkListCommentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}



class WorkListCommentModel {
  int dealCommentId;
  int dealId;
  int dealParentCommentId;
  int staffId;
  String staffName;
  String staffAvatar;
  String message;
  String timeText;
  String path;
  List<WorkListCommentModel> listObject;
  bool isSubComment;

  WorkListCommentModel(
      {this.dealCommentId,
        this.dealId,
        this.dealParentCommentId,
        this.staffId,
        this.staffName,
        this.staffAvatar,
        this.message,
        this.timeText,
        this.path,
        this.listObject});

  WorkListCommentModel.fromJson(Map<String, dynamic> json) {
    dealCommentId = json['deal_comment_id'];
    dealId = json['deal_id'];
    dealParentCommentId = json['deal_parent_comment_id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    staffAvatar = json['staff_avatar'];
    message = json['message'];
    timeText = json['time_text'];
    path = json['path'];
    if (json['list_object'] != null) {
      listObject = <WorkListCommentModel>[];
      json['list_object'].forEach((v) {
        var model = new WorkListCommentModel.fromJson(v);
        model.isSubComment = true;
        listObject.add(model);
      });
    }
    isSubComment = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_comment_id'] = this.dealCommentId;
    data['deal_id'] = this.dealId;
    data['deal_parent_comment_id'] = this.dealParentCommentId;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['staff_avatar'] = this.staffAvatar;
    data['message'] = this.message;
    data['time_text'] = this.timeText;
    data['path'] = this.path;
    if (this.listObject != null) {
      data['list_object'] = this.listObject.map((v) => v.toJson()).toList();
    }
    return data;
  }
}