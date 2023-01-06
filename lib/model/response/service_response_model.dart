
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:flutter/cupertino.dart';

class ListServiceResponseModel {
  int errorCode;
  String errorDescription;
  ServiceResponseModel data;

  ListServiceResponseModel({this.errorCode, this.errorDescription, this.data});

  ListServiceResponseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    data = json['Data'] != null ? new ServiceResponseModel.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}


class ServiceResponseModel {
  PageInfo pageInfo;
  List<ServiceModel> items;

  ServiceResponseModel({this.pageInfo, this.items});

  ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfo.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <ServiceModel>[];
      json['Items'].forEach((v) {
        items.add(new ServiceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo {
  int total;
  int itemPerPage;
  int from;
  int to;
  int currentPage;
  int firstPage;
  int lastPage;
  int previousPage;
  int nextPage;
  List<int> pageRange;

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

class ServiceModel {
  String branchName;
  int serviceId;
  String serviceName;
  String serviceCode;
  String serviceAvatar;
  double oldPrice;
  double newPrice;
  String detailDescription;
  String description;
  int time;
  String categoryName;
  int isNew;
  FocusNode node;
  TextEditingController controller;
  int qty;
  Promotion promotion;

  ServiceModel(
      {this.branchName,
      this.serviceId,
      this.serviceName,
      this.serviceCode,
      this.serviceAvatar,
      this.oldPrice,
      this.newPrice,
      this.detailDescription,
      this.description,
      this.time,
      this.categoryName,
      this.isNew,
      this.promotion,
      this.qty});

  ServiceModel.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    serviceCode = json['service_code'];
    serviceAvatar = json['service_avatar'];
    oldPrice = double.tryParse(json['old_price'].toString());
    newPrice = double.tryParse(json['new_price'].toString());
    detailDescription = json['detail_description'];
    description = json['description'];
    time = json['time'];
    categoryName = json['category_name'];
    isNew = json['is_new'];
    qty = GlobalCart.shared.getQuantityService(serviceId);
    node = FocusNode();
    controller = TextEditingController();
    controller.text = '$qty';
    if (json['promotion'] is Map<String, dynamic>) {
      promotion = json['promotion'] != null
          ? new Promotion.fromJson(json['promotion'])
          : null;
    }
  }

  ServiceModel.fromJsonOrderDetail(Map<String, dynamic> json) {
    serviceId = json['object_id'];
    serviceName = json['object_name'];
    serviceCode = json['object_code'];
    newPrice = double.tryParse(json['price'].toString());
    qty = json['quantity'];
    node = FocusNode();
    controller = TextEditingController();
    controller.text = '$qty';
    serviceAvatar = json['object_image'];
  }

  Map<String, dynamic> toJsonOrderDetail() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = "service";
    data['object_id'] = serviceId;
    data['object_name'] = serviceName;
    data['object_code'] = serviceCode;
    data['quantity'] = qty;
    data['price'] = newPrice;
    return data;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_name'] = this.branchName;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['service_code'] = this.serviceCode;
    data['service_avatar'] = this.serviceAvatar;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['detail_description'] = this.detailDescription;
    data['description'] = this.description;
    data['time'] = this.time;
    data['category_name'] = this.categoryName;
    data['is_new'] = this.isNew;
    if (this.promotion != null) {
      data['promotion'] = this.promotion.toJson();
    }
    return data;
  }
}

class Promotion {
  String price;

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
