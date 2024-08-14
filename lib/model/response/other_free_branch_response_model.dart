
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:flutter/material.dart';

class OtherFreeBranchResponseModel {
  List<OtherFreeBranchModel>? data;

  OtherFreeBranchResponseModel({this.data});

  OtherFreeBranchResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <OtherFreeBranchModel>[];
      json.forEach((v) {
        data!.add(new OtherFreeBranchModel.fromJson(v, init: false));
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

class OtherFreeBranchModel {
  int? otherFeeId;
  String? otherFeeName;
  double? value;
  String? valueType;
  late bool isMoney;
  late bool isSelected;
  late FocusNode focusNode;
  late TextEditingController controller;

  OtherFreeBranchModel(
      {this.otherFeeId, this.otherFeeName, this.value, this.valueType});

  OtherFreeBranchModel.fromJson(Map<String, dynamic> json, {bool init = true}) {
    otherFeeId = json['other_fee_id'];
    otherFeeName = json['other_fee_name'];
    value = double.tryParse((json['value'] ?? "").toString());
    valueType = json['value_type'];
    isMoney = valueType == otherFreeBranchTypeMoney;
    isSelected = init;
    focusNode = FocusNode();
    controller = TextEditingController(
        text: isMoney
            ? formatMoney(value)
            : (value == null ? "" : value!.toInt().toString()));
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['other_fee_id'] = this.otherFeeId;
    data['other_fee_name'] = this.otherFeeName;
    data['value'] = this.value;
    data['value_type'] = this.valueType;
    return data;
  }
}
