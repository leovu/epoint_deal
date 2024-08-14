class ProductRequestModel {
  String? productName;
  int? productCategoryId;
  int? page;

  ProductRequestModel({this.productName, this.productCategoryId, this.page});

  ProductRequestModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productCategoryId = json['product_category_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_category_id'] = this.productCategoryId;
    data['page'] = this.page;
    return data;
  }
}
