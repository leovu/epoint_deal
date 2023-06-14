class ProductRequestModel {
  String? productName;
  int? page;
  String? brandCode;

  ProductRequestModel({this.productName, this.page, this.brandCode});

  ProductRequestModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    page = json['page'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['page'] = this.page;
    data['brand_code'] = this.brandCode;
    return data;
  }
}
