
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:epoint_deal_plugin/model/promotion_model.dart';

import 'booking_staff_response_model.dart';

class ProductNewResponseModel {
  PageInfoModel? pageInfo;
  List<ProductNewModel?>? items;

  ProductNewResponseModel({this.pageInfo, this.items});

  ProductNewResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    items = <ProductNewModel?>[];
    if (json['Items'] != null) {
      json['Items'].forEach((v) {
        items!.add(new ProductNewModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class ProductNewModel {
  int? productId;
  String? productCode;
  String? productName;
  String? avatar;
  double? oldPrice;
  double? newPrice;
  String? description;
  String? descriptionDetail;
  dynamic typeApp;
  int? isSales;
  int? percentSale;
  int? productCategoryId;
  String? categoryName;
  String? unitName;
  PromotionModel? promotion;
  int? isAttach;
  List<BookingStaffModel>? staffModels;
  double? quantity, changePrice, surcharge, discount;
  DiscountCartModel? voucherModel;
  String? note;

  ProductNewModel({
    this.productId,
    this.productCode,
    this.productName,
    this.avatar,
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
    this.promotion,
    this.isAttach,
    this.staffModels,
    this.note
  });

  ProductNewModel.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'];
    productCode = json['product_code'];
    productName = json['product_name'];
    avatar = json['avatar'];
    oldPrice = double.tryParse((json['old_price'] ?? 0.0).toString());
    newPrice = double.tryParse((json['new_price'] ?? 0.0).toString());
    description = json['description'];
    descriptionDetail = json['description_detail'];
    typeApp = json['type_app'];
    isSales = json['is_sales'];
    percentSale = json['percent_sale'];
    productCategoryId = json['product_category_id'];
    categoryName = json['category_name'];
    unitName = json['unit_name'];
    if (json['promotion'] is Map<String, dynamic>) {
      promotion = json['promotion'] != null
          ? new PromotionModel.fromJson(json['promotion'])
          : null;
    }
    isAttach = json['is_attach'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_id'] = this.productId;
    data['product_code'] = this.productCode;
    data['product_name'] = this.productName;
    data['avatar'] = this.avatar;
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
    if (this.promotion != null) {
      data['promotion'] = this.promotion!.toJson();
    }
    data['is_attach'] = this.isAttach;
    return data;
  }
}
