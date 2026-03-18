import 'package:epoint_deal_plugin/model/promotion_model.dart';

import 'rating_response_model.dart';
import 'service_detail_response_model.dart';

class ProductDetailResponseModel {
  int? productId;
  String? productCode;
  String? productName;
  String? avatar;
  int? isNew;
  double? oldPrice;
  double? newPrice;
  String? description;
  String? descriptionDetail;
  String? typeApp;
  int? isSales;
  int? percentSale;
  int? productCategoryId;
  String? categoryName;
  String? unitName;
  int? productParentId;
  String? descriptionImage;
  PromotionModel? promotion;
  String? productModelName;
  String? madeIn;
  String? supplierName;
  int? isReview;
  List<ListImageModel>? listImage;
  int? isLike;
  RatingResponseModel? rating;
  List<AttachModel>? attach;

  ProductDetailResponseModel(
      {this.productId,
        this.productCode,
        this.productName,
        this.avatar,
        this.isNew,
        this.oldPrice,
        this.newPrice,
        this.description,
        this.descriptionDetail,
        this.typeApp,
        this.isSales,
        this.percentSale,
        this.productCategoryId,
        this.categoryName,
        this.unitName,
        this.productParentId,
        this.descriptionImage,
        this.promotion,
        this.productModelName,
        this.madeIn,
        this.supplierName,
        this.isReview,
        this.listImage,
        this.isLike,
        this.rating,
        this.attach});

  ProductDetailResponseModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    avatar = json['avatar'];
    isNew = json['is_new'];
    oldPrice = json['old_price'] == null? null: double.tryParse(json['old_price'].toString());
    newPrice = json['new_price'] == null? null: double.tryParse(json['new_price'].toString());
    description = json['description'];
    descriptionDetail = json['description_detail'];
    typeApp = json['type_app'];
    isSales = json['is_sales'];
    percentSale = json['percent_sale'];
    productCategoryId = json['product_category_id'];
    categoryName = json['category_name'];
    unitName = json['unit_name'];
    productParentId = json['product_parent_id'];
    descriptionImage = json['description_image'];
    promotion = json['promotion'] != null
        ? new PromotionModel.fromJson(json['promotion'])
        : null;
    productModelName = json['product_model_name'];
    madeIn = json['made_in'];
    supplierName = json['supplier_name'];
    isReview = json['is_review'];
    if (json['list_image'] != null) {
      listImage = [];
      json['list_image'].forEach((v) {
        listImage!.add(new ListImageModel.fromJson(v));
      });
    }
    isLike = json['is_like'];
    rating =
    json['rating'] != null ? new RatingResponseModel.fromJson(json['rating']) : null;
    if (json['attach'] != null) {
      attach = <AttachModel>[];
      json['attach'].forEach((v) {
        attach!.add(new AttachModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['avatar'] = this.avatar;
    data['is_new'] = this.isNew;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['description'] = this.description;
    data['description_detail'] = this.descriptionDetail;
    data['type_app'] = this.typeApp;
    data['is_sales'] = this.isSales;
    data['percent_sale'] = this.percentSale;
    data['product_category_id'] = this.productCategoryId;
    data['category_name'] = this.categoryName;
    data['unit_name'] = this.unitName;
    data['product_parent_id'] = this.productParentId;
    data['description_image'] = this.descriptionImage;
    if (this.promotion != null) {
      data['promotion'] = this.promotion!.toJson();
    }
    data['product_model_name'] = this.productModelName;
    data['made_in'] = this.madeIn;
    data['supplier_name'] = this.supplierName;
    data['is_review'] = this.isReview;
    data['list_image'] = this.listImage;
    data['is_like'] = this.isLike;
    if (this.rating != null) {
      data['rating'] = this.rating!.toJson();
    }
    if (this.attach != null) {
      data['attach'] = this.attach!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListImageModel {
  int? productImageId;
  String? image;

  ListImageModel({this.productImageId, this.image});

  ListImageModel.fromJson(Map<String, dynamic> json) {
    productImageId = json['product_image_id'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_image_id'] = this.productImageId;
    data['image'] = this.image;
    return data;
  }
}