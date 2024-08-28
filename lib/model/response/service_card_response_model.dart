

import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';

class ServiceCardResponseModel {
  PageInfoModel? pageInfo;
  List<ServiceCardModel?>? items;

  ServiceCardResponseModel({this.pageInfo, this.items});

  ServiceCardResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    items = <ServiceCardModel?>[];
    if (json['Items'] != null) {
      json['Items'].forEach((v) {
        items!.add(new ServiceCardModel.fromJson(v));
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

class ServiceCardModel {
  int? customerServiceCardId;
  String? name;
  double? price;
  String? cardCode;
  String? expiredDate;
  String? activedDate;
  int? numberUsing;
  int? countUsing;
  int? remainAmount;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  List<BookingStaffModel>? staffModels;
  DiscountCartModel? voucherModel;
  CustomDropdownModel? roomModel;
  double? changePrice, discount, surcharge;
  double? quantity;
  String? note;

  ServiceCardModel(
      {this.customerServiceCardId,
        this.name,
        this.price,
        this.cardCode,
        this.expiredDate,
        this.activedDate,
        this.numberUsing,
        this.countUsing,
        this.remainAmount,
        this.createdBy,
        this.updatedBy,
        this.staffCreatedName,
        this.staffUpdatedName});

  ServiceCardModel.fromJson(Map<String, dynamic> json) {
    customerServiceCardId = json['customer_service_card_id'];
    name = json['name'];
    price = double.tryParse((json['price'] ?? 0.0).toString());
    cardCode = json['card_code'];
    expiredDate = json['expired_date'];
    activedDate = json['actived_date'];
    numberUsing = json['number_using'];
    countUsing = json['count_using'];
    remainAmount = json['remain_amount'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_service_card_id'] = this.customerServiceCardId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['card_code'] = this.cardCode;
    data['expired_date'] = this.expiredDate;
    data['actived_date'] = this.activedDate;
    data['number_using'] = this.numberUsing;
    data['count_using'] = this.countUsing;
    data['remain_amount'] = this.remainAmount;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    return data;
  }
}