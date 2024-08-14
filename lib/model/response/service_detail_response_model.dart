
import 'package:epoint_deal_plugin/model/promotion_model.dart';
import 'package:flutter/material.dart';

class ServiceDetailResponseModel {
  String? branchName;
  int? branchId;
  int? serviceId;
  String? serviceName;
  String? serviceCode;
  String? serviceAvatar;
  double? oldPrice;
  double? newPrice;
  String? detailDescription;
  String? description;
  int? time;
  String? serviceCategoryId;
  String? descriptionImage;
  PromotionModel? promotion;
  List<ListImageModel>? serviceImages;
  List<AttachModel>? attach;

  ServiceDetailResponseModel(
      {this.branchName,
        this.branchId,
        this.serviceId,
        this.serviceName,
        this.serviceCode,
        this.serviceAvatar,
        this.oldPrice,
        this.newPrice,
        this.detailDescription,
        this.description,
        this.time,
        this.serviceCategoryId,
        this.descriptionImage,
        this.promotion,
        this.serviceImages,
        this.attach});

  ServiceDetailResponseModel.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
    branchId = json['branch_id'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    serviceCode = json['service_code'];
    serviceAvatar = json['service_avatar'];
    oldPrice = json['old_price'] == null? null: double.tryParse(json['old_price'].toString());
    newPrice = json['new_price'] == null? null: double.tryParse(json['new_price'].toString());
    detailDescription = json['detail_description'];
    description = json['description'];
    time = json['time'];
    serviceCategoryId = json['service_category_id'];
    descriptionImage = json['description_image'];
    promotion = json['promotion'] != null
        ? new PromotionModel.fromJson(json['promotion'])
        : null;
    if (json['service_images'] != null) {
      serviceImages = <ListImageModel>[];
      json['service_images'].forEach((v) {
        serviceImages!.add(new ListImageModel.fromJson(v));
      });
    }
    if (json['attach'] != null) {
      attach = <AttachModel>[];
      json['attach'].forEach((v) {
        attach!.add(new AttachModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_name'] = this.branchName;
    data['branch_id'] = this.branchId;
    data['service_id'] = this.serviceId;
    data['service_name'] = this.serviceName;
    data['service_code'] = this.serviceCode;
    data['service_avatar'] = this.serviceAvatar;
    data['old_price'] = this.oldPrice;
    data['new_price'] = this.newPrice;
    data['detail_description'] = this.detailDescription;
    data['description'] = this.description;
    data['time'] = this.time;
    data['service_category_id'] = this.serviceCategoryId;
    data['description_image'] = this.descriptionImage;
    if (this.promotion != null) {
      data['promotion'] = this.promotion!.toJson();
    }
    if (this.serviceImages != null) {
      data['service_images'] =
          this.serviceImages!.map((v) => v.toJson()).toList();
    }
    if (this.attach != null) {
      data['attach'] = this.attach!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListImageModel {
  int? serviceImageId;
  String? name;
  String? type;

  ListImageModel({this.serviceImageId, this.name, this.type});

  ListImageModel.fromJson(Map<String, dynamic> json) {
    serviceImageId = json['service_image_id'];
    name = json['name'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_image_id'] = this.serviceImageId;
    data['name'] = this.name;
    data['type'] = this.type;
    return data;
  }
}

class AttachModel {
  String? objectType;
  int? objectId;
  String? objectCode;
  String? objectName;
  double? price;
  FocusNode? focusNode;
  FocusNode? focusOrder;
  FocusNode? focusCategory;
  FocusNode? focusCart;
  TextEditingController? controller;
  bool? isSelected;

  AttachModel(
      {this.objectType,
        this.objectId,
        this.objectCode,
        this.objectName,
        this.price,
        this.focusOrder,
        this.controller,
        this.isSelected = true});

  AttachModel.fromJson(Map<String, dynamic> json) {
    objectType = json['object_type'];
    objectId = json['object_id'];
    objectCode = json['object_code'];
    objectName = json['object_name'];
    price = double.tryParse((json['price'] ?? 0.0).toString());
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    data['object_code'] = this.objectCode;
    data['object_name'] = this.objectName;
    data['price'] = this.price;
    return data;
  }
}