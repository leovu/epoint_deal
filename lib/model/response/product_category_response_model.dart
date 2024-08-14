class ProductCategoryResponseModel {
  List<ProductCategoryModel>? data;

  ProductCategoryResponseModel({this.data});

  ProductCategoryResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProductCategoryModel>[];
      json.forEach((v) {
        data!.add(new ProductCategoryModel.fromJson(v));
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

class ProductCategoryModel {
  int? productCategoryId;
  String? categoryName;
  String? description;
  int? isActived;

  ProductCategoryModel(
      {this.productCategoryId,
        this.categoryName,
        this.description,
        this.isActived});

  ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    productCategoryId = json['product_category_id'];
    categoryName = json['category_name'];
    description = json['description'];
    isActived = json['is_actived'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_category_id'] = this.productCategoryId;
    data['category_name'] = this.categoryName;
    data['description'] = this.description;
    data['is_actived'] = this.isActived;
    return data;
  }
}
