/*
* Created by: hieupc
* Created at: 2021/06/08 4:21 PM
*/

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class InventoryListDetailResponseModel {
  PageInfoModel? pageInfo;
  List<InventoryListDetailModel?>? items;

  InventoryListDetailResponseModel({this.pageInfo, this.items});

  InventoryListDetailResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <InventoryListDetailModel?>[];
      json['Items'].forEach((v) {
        items!.add(new InventoryListDetailModel.fromJson(v));
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

class InventoryListDetailModel {
  String? productName;
  String? productCode;
  int? inventory;
  double? inventoryValue;

  InventoryListDetailModel(
      {this.productName,
        this.productCode,
        this.inventory,
        this.inventoryValue});

  InventoryListDetailModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    productCode = json['product_code'];
    inventory = json['inventory'];
    inventoryValue = double.tryParse(json['inventory_value'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['product_code'] = this.productCode;
    data['inventory'] = this.inventory;
    data['inventory_value'] = this.inventoryValue;
    return data;
  }
}

