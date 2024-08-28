
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:epoint_deal_plugin/model/promotion_model.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';

import 'booking_staff_response_model.dart';

class ServiceNewResponseModel {
  PageInfoModel? pageInfo;
  List<ServiceNewModel?>? items;

  ServiceNewResponseModel({this.pageInfo, this.items});

  ServiceNewResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    items = <ServiceNewModel?>[];
    if (json['Items'] != null) {
      json['Items'].forEach((v) {
        items!.add(new ServiceNewModel.fromJson(v));
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

class ServiceNewModel {
  String? branchName;
  int? serviceId;
  String? serviceName;
  String? serviceCode;
  String? serviceAvatar;
  double? oldPrice;
  double? newPrice;
  String? detailDescription;
  String? description;
  int? time;
  String? categoryName;
  int? isNew;
  PromotionModel? promotion;
  int? isAttach;
  List<BookingStaffModel>? staffModels;
  CustomDropdownModel? roomModel;
  double? quantity, changePrice, surcharge, discount;
  DiscountCartModel? voucherModel;
  String? note;

  ServiceNewModel(
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
        this.isAttach,
        this.staffModels,
        this.roomModel,
        this.note});

  ServiceNewModel.fromJson(Map<String, dynamic> json) {
    branchName = json['branch_name'];
    serviceId = json['service_id'];
    serviceName = json['service_name'];
    serviceCode = json['service_code'];
    serviceAvatar = json['service_avatar'];
    oldPrice = double.tryParse((json['old_price'] ?? 0.0).toString());
    newPrice = double.tryParse((json['new_price'] ?? 0.0).toString());
    detailDescription = json['detail_description'];
    description = json['description'];
    time = json['time'];
    categoryName = json['category_name'];
    isNew = json['is_new'];
    if (json['promotion'] is Map<String, dynamic>) {
      promotion = json['promotion'] != null
          ? new PromotionModel.fromJson(json['promotion'])
          : null;
    }
    isAttach = json['is_attach'];
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
      data['promotion'] = this.promotion!.toJson();
    }
    data['is_attach'] = this.isAttach;
    return data;
  }
}