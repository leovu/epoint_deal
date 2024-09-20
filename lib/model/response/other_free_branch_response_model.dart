
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/decimal_number_input_formatter.dart';
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
  String? feeName;
  double? value;
  String? valueType;
  double? otherFeeValue;
  String? otherFeeCode;
  String? feeType;
  double? feeMoney;
  double? feeValue;
  late bool isMoney;
  late bool isSelected;
  late FocusNode focusNode;
  late TextEditingController controller;

  OtherFreeBranchModel(
      {this.otherFeeId, this.otherFeeName, this.value, this.valueType, this.feeName, this.otherFeeValue, this.feeType});

  OtherFreeBranchModel.fromJson(Map<String, dynamic> json, {bool init = true, bool isUpdate = false}) {
    otherFeeId = json['other_fee_id'];
    otherFeeName = json['other_fee_name'];
    feeName = json['fee_name'];
    value = double.tryParse((json['value'] ?? 0).toString());
    feeValue = double.tryParse((json['fee_value'] ?? 0).toString());
    otherFeeValue = double.tryParse((json['other_fee_value'] ?? 0).toString());
    feeMoney = double.tryParse((json['fee_money'] ?? 0).toString());
    valueType = json['value_type'];
    feeType = json['fee_type'];
    if (valueType == null) {
      isMoney = feeType == otherFreeBranchTypeMoney;
    } else {
      isMoney = valueType == otherFreeBranchTypeMoney;
    }
    isSelected = init;
    focusNode = FocusNode();
    if (feeMoney != null && isUpdate) {
      controller = TextEditingController(
        text: isMoney
            ? formatMoney(feeMoney)
            : (otherFeeValue == null ? "" : otherFeeValue!.toInt().toString()));
    } else {
      controller = TextEditingController(
        text: isMoney
            ? formatMoney(value)
            : (value == null ? "" : value!.toInt().toString()));
    }
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

class OrderFeeModel {
  int? otherFeeId;
  String? otherFeeCode;
  String? otherFeeName;
  num? otherFeeValue;
  String? feeType;
  num? feeMoney;
  int? value;
  int? feeValue;

  OrderFeeModel(
      {this.otherFeeId,
      this.otherFeeCode,
      this.otherFeeName,
      this.otherFeeValue,
      this.feeType,
      this.feeMoney,
      this.value,
      this.feeValue});

  OrderFeeModel.fromJson(Map<String, dynamic> json) {
    otherFeeId = json['other_fee_id'];
    otherFeeCode = json['other_fee_code'];
    otherFeeName = json['other_fee_name'];
    otherFeeValue = json['other_fee_value'];
    feeType = json['fee_type'];
    value = json['value'];
    feeMoney = json['fee_money'];
    feeValue = json['fee_value'];
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['other_fee_id'] = this.otherFeeId;
    data['other_fee_code'] = this.otherFeeCode;
    data['other_fee_name'] = this.otherFeeName;
    data['other_fee_value'] = this.otherFeeValue;
    data['fee_type'] = this.feeType;
    data['fee_money'] = this.feeMoney;
    if (value != null) {
      data['value'] = this.value;
    }
    if (feeValue != null) {
      data['fee_value'] = this.feeValue;
    }
    return data;
  }
}

