class RemovePhotoOrderModel {
  String? brandCode;
  List<int>? orderImageId;

  RemovePhotoOrderModel({this.brandCode, this.orderImageId});

  RemovePhotoOrderModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    orderImageId = json['order_image_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['order_image_id'] = this.orderImageId;
    return data;
  }
}