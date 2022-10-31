class UpdateDealModelResponse {
  int errorCode;
  String errorDescription;
  int data;

  UpdateDealModelResponse({this.errorCode, this.errorDescription, this.data});

  UpdateDealModelResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    data['Data'] = this.data;
    return data;
  }
}
