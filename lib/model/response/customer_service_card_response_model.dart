

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CustomerServiceCardResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerServiceCardModel>? items;
  List<CustomerServiceCardStatusModel>? status;

  CustomerServiceCardResponseModel({this.pageInfo, this.items, this.status});

  CustomerServiceCardResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerServiceCardModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerServiceCardModel.fromJson(v));
      });
    }
    if (json['status'] != null) {
      status = <CustomerServiceCardStatusModel>[];
      json['status'].forEach((v) {
        status!.add(new CustomerServiceCardStatusModel.fromJson(v));
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
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerServiceCardModel {
  int? customerServiceCardId;
  String? name;
  double? price;
  String? cardCode;
  String? expiredDate;
  String? activedDate;
  int? numberUsing;
  int? countUsing;
  int? remainAmount;
  int? status;
  String? statusName;

  CustomerServiceCardModel(
      {this.customerServiceCardId,
        this.name,
        this.price,
        this.cardCode,
        this.expiredDate,
        this.activedDate,
        this.numberUsing,
        this.countUsing,
        this.remainAmount,
        this.status,
        this.statusName});

  CustomerServiceCardModel.fromJson(Map<String, dynamic> json) {
    customerServiceCardId = json['customer_service_card_id'];
    name = json['name'];
    price = double.tryParse((json['price'] ?? 0.0).toString());
    cardCode = json['card_code'];
    expiredDate = json['expired_date'];
    activedDate = json['actived_date'];
    numberUsing = json['number_using'];
    countUsing = json['count_using'];
    remainAmount = json['remain_amount'];
    status = json['status'];
    statusName = json['status_name'];
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
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    return data;
  }
}

class CustomerServiceCardStatusModel {
  int? status;
  String? name;

  CustomerServiceCardStatusModel({this.status, this.name});

  CustomerServiceCardStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['name'] = this.name;
    return data;
  }
}
