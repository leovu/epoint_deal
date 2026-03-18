class OrderUploadImageRequestModel {
  String? orderCode;
  List<OrderUploadImageModel>? listImages;

  OrderUploadImageRequestModel({this.orderCode, this.listImages});

  OrderUploadImageRequestModel.fromJson(Map<String, dynamic> json) {
    orderCode = json['order_code'];
    if (json['list_images'] != null) {
      listImages = <OrderUploadImageModel>[];
      json['list_images'].forEach((v) {
        listImages!.add(new OrderUploadImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_code'] = this.orderCode;
    if (this.listImages != null) {
      data['list_images'] = this.listImages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderUploadImageModel {
  int? orderImageId;
  String? type;
  String? link;

  OrderUploadImageModel({this.orderImageId, this.type, this.link});

  OrderUploadImageModel.fromJson(Map<String, dynamic> json) {
    orderImageId = json['order_image_id'];
    type = json['type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_image_id'] = this.orderImageId;
    data['type'] = this.type;
    data['link'] = this.link;
    return data;
  }
}
