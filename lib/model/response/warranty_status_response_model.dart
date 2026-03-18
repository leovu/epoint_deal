
import 'package:epoint_deal_plugin/presentation/list_deal/list_deal_screen.dart';
import 'package:flutter/material.dart';

class WarrantyStatusResponseModel {
  List<WarrantyStatusModel>? data;

  WarrantyStatusResponseModel({this.data});

  WarrantyStatusResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WarrantyStatusModel>[];
      json.forEach((v) {
        data!.add(new WarrantyStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WarrantyStatusModel {
  String? status;
  String? statusName;
  String? statusColor;
  Color? color;
  bool? selected;

  WarrantyStatusModel({this.status, this.statusName, this.statusColor, this.color, this.selected = false});

  WarrantyStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
    color = HexColor(statusColor ?? "000000");
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    return data;
  }
}
