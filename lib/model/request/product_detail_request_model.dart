class ProductDetailRequestModel {
  int productId;

  ProductDetailRequestModel({this.productId});

  ProductDetailRequestModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    return data;
  }
}