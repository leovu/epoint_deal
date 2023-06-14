class ListProductResponseModel {
  int? errorCode;
  String? errorDescription;
  ProductResponseModel? data;

  ListProductResponseModel({this.errorCode, this.errorDescription, this.data});

  ListProductResponseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    data = json['Data'] != null ? new ProductResponseModel.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}



class ProductResponseModel {
  PageInfo? pageInfo;
  List<ProductModel?>? items;

  ProductResponseModel({this.pageInfo, this.items});

  ProductResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfo.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <ProductModel?>[];
      json['Items'].forEach((v) {
        items!.add(new ProductModel.fromJson(v));
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


class PageInfo {
  int? total;
  int? itemPerPage;
  int? from;
  int? to;
  int? currentPage;
  int? firstPage;
  int? lastPage;
  int? previousPage;
  int? nextPage;
  List<int>? pageRange;

  PageInfo(
      {this.total,
      this.itemPerPage,
      this.from,
      this.to,
      this.currentPage,
      this.firstPage,
      this.lastPage,
      this.previousPage,
      this.nextPage,
      this.pageRange});

  PageInfo.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    itemPerPage = json['itemPerPage'];
    from = json['from'];
    to = json['to'];
    currentPage = json['currentPage'];
    firstPage = json['firstPage'];
    lastPage = json['lastPage'];
    previousPage = json['previousPage'];
    nextPage = json['nextPage'];
    pageRange =
        json['pageRange'] == null ? null : json['pageRange'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['itemPerPage'] = this.itemPerPage;
    data['from'] = this.from;
    data['to'] = this.to;
    data['currentPage'] = this.currentPage;
    data['firstPage'] = this.firstPage;
    data['lastPage'] = this.lastPage;
    data['previousPage'] = this.previousPage;
    data['nextPage'] = this.nextPage;
    data['pageRange'] = this.pageRange;
    return data;
  }
}

class ProductModel {
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
  Promotion? promotion;
  num? qty;
  num? price;
  String? note;

  ProductModel(
      {this.productId,
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
      this.promotion, this.price, this.note, this.qty});

  ProductModel.fromJson(Map<String, dynamic> json) {
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
          ? new Promotion.fromJson(json['promotion'])
          : null;
    }
    qty = json["quantity"];
    note = json["note"];
  }

  ProductModel.fromJsonOrderDetail(Map<String, dynamic> json) {
    productId = json['object_id'];
    productName = json['object_name'];
    productCode = json['object_code'];
    qty = json['quantity'];
    price = json['price'];
    note = json['note'];
    avatar = json['object_image'];
    unitName = json['unit_name'];
    note = json['note'];
  }

  Map<String, dynamic> toJsonOrderDetail() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = "product";
    data['object_id'] = productId;
    data['object_name'] = productName;
    data['object_code'] = productCode;
    data['quantity'] = qty;
    data['price'] = price;
    data['note'] = note;
    return data;
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

    data["quantity"] = this.qty;
    data["note"] = this.note;
    return data;
  }
}


class Promotion {
  String? price;

  Promotion({this.price});

  Promotion.fromJson(Map<String, dynamic> json) {
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    return data;
  }
}
