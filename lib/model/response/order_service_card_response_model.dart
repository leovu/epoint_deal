

import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';

class OrderServiceCardResponseModel {
  PageInfoModel? pageInfo;
  List<OrderServiceCardModel>? items;

  OrderServiceCardResponseModel({this.pageInfo, this.items});

  OrderServiceCardResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <OrderServiceCardModel>[];
      json['Items'].forEach((v) {
        items!.add(new OrderServiceCardModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderServiceCardModel {
  int? serviceCardId;
  String? code;
  int? serviceCardGroupId;
  String? groupName;
  String? serviceCardType;
  int? dateUsing;
  int? numberUsing;
  String? name;
  double? price;
  String? image;
  String? description;
  List<BookingStaffModel>? staffModels;
  DiscountCartModel? voucherModel;
  CustomDropdownModel? roomModel;
  double? changePrice, discount, surcharge;
  double? quantity;
  String? note;

  OrderServiceCardModel(
      {this.serviceCardId,
        this.code,
        this.serviceCardGroupId,
        this.groupName,
        this.serviceCardType,
        this.dateUsing,
        this.numberUsing,
        this.name,
        this.price,
        this.image,
        this.description});

  OrderServiceCardModel.fromJson(Map<String, dynamic> json) {
    serviceCardId = json['service_card_id'];
    code = json['code'];
    serviceCardGroupId = json['service_card_group_id'];
    groupName = json['group_name'];
    serviceCardType = json['service_card_type'];
    dateUsing = json['date_using'];
    numberUsing = json['number_using'];
    name = json['name'];
    price = double.tryParse((json['price'] ?? 0.0).toString());
    image = json['image'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_card_id'] = this.serviceCardId;
    data['code'] = this.code;
    data['service_card_group_id'] = this.serviceCardGroupId;
    data['group_name'] = this.groupName;
    data['service_card_type'] = this.serviceCardType;
    data['date_using'] = this.dateUsing;
    data['number_using'] = this.numberUsing;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    return data;
  }
}
