import '../request/order_upload_image_request_model.dart';

class OrderUploadImageResponseModel {
  List<OrderUploadImageModel>? data;

  OrderUploadImageResponseModel({this.data});

  OrderUploadImageResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <OrderUploadImageModel>[];
      json.forEach((v) {
        data!.add(new OrderUploadImageModel.fromJson(v));
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