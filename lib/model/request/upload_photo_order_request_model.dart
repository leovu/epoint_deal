class UploadPhotoOrderRequestModel {
  String? orderCode;
  String? type;
  String? link;
  String? brandCode;

  UploadPhotoOrderRequestModel({this.orderCode, this.type, this.link, this.brandCode});

  UploadPhotoOrderRequestModel.fromJson(Map<String, dynamic> json) {
    orderCode = json['order_code'];
    type = json['type'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_code'] = this.orderCode;
    data['type'] = this.type;
    data['brand_code'] = this.brandCode;
    return data;
  }
}
