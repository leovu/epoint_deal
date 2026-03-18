import 'package:flutter/material.dart';

class MaintenanceCostTypeResponseModel {
  List<MaintenanceCostTypeModel>? data;

  MaintenanceCostTypeResponseModel({this.data});

  MaintenanceCostTypeResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <MaintenanceCostTypeModel>[];
      json.forEach((v) {
        data!.add(new MaintenanceCostTypeModel.fromJson(v));
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

class MaintenanceCostTypeModel {
  int? maintenanceCostTypeId;
  String? maintenanceCostTypeName;
  bool? isSelected;
  FocusNode? focusNode;
  TextEditingController? controller;

  MaintenanceCostTypeModel({
    this.maintenanceCostTypeId,
    this.maintenanceCostTypeName,
    this.isSelected = true,
    this.focusNode,
    this.controller
  });

  MaintenanceCostTypeModel.fromJson(Map<String, dynamic> json) {
    maintenanceCostTypeId = json['maintenance_cost_type_id'];
    maintenanceCostTypeName = json['maintenance_cost_type_name'];
    isSelected = false;
    focusNode = FocusNode();
    controller = TextEditingController();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_cost_type_id'] = this.maintenanceCostTypeId;
    data['maintenance_cost_type_name'] = this.maintenanceCostTypeName;
    return data;
  }
}
