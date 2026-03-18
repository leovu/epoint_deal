
import 'package:epoint_deal_plugin/presentation/list_deal/list_deal_screen.dart';
import 'package:flutter/material.dart';

class WarrantyDetailResponseModel {
  int? warrantyCardId;
  String? warrantyCardCode;
  String? warrantyPackedCode;
  String? packedName;
  int? quota;
  int? customerId;
  String? customerCode;
  String? customerName;
  String? phone;
  String? birthday;
  String? email;
  String? customerAvatar;
  String? groupName;
  String? address;
  String? provinceName;
  String? districtName;
  String? wardName;
  String? dateActived;
  String? dateExpired;
  String? dateExpiredName;
  String? status;
  int? warrantyPercent;
  double? warrantyValue;
  double? warrantyValueApply;
  String? description;
  String? objectType;
  String? objectTypeId;
  String? objectCode;
  double? objectPrice;
  String? objectSerial;
  String? objectNote;
  String? statusName;
  String? statusColor;
  Color? color;
  String? objectName;
  String? fullAddress;
  List<WarrantyImageModel>? warrantyImage;
  int? isUpdate;
  int? isCreateMaintenance;

  WarrantyDetailResponseModel(
      {this.warrantyCardId,
        this.warrantyCardCode,
        this.warrantyPackedCode,
        this.packedName,
        this.quota,
        this.customerId,
        this.customerCode,
        this.customerName,
        this.phone,
        this.birthday,
        this.email,
        this.customerAvatar,
        this.groupName,
        this.address,
        this.provinceName,
        this.districtName,
        this.wardName,
        this.dateActived,
        this.dateExpired,
        this.dateExpiredName,
        this.status,
        this.warrantyPercent,
        this.warrantyValue,
        this.warrantyValueApply,
        this.description,
        this.objectType,
        this.objectTypeId,
        this.objectCode,
        this.objectPrice,
        this.objectSerial,
        this.objectNote,
        this.statusName,
        this.statusColor,
        this.objectName,
        this.fullAddress,
        this.warrantyImage,
        this.isUpdate,
        this.isCreateMaintenance});

  WarrantyDetailResponseModel.fromJson(Map<String, dynamic> json) {
    warrantyCardId = json['warranty_card_id'];
    warrantyCardCode = json['warranty_card_code'];
    warrantyPackedCode = json['warranty_packed_code'];
    packedName = json['packed_name'];
    quota = json['quota'];
    customerId = json['customer_id'];
    customerCode = json['customer_code'];
    customerName = json['customer_name'];
    phone = json['phone'];
    birthday = json['birthday'];
    email = json['email'];
    customerAvatar = json['customer_avatar'];
    groupName = json['group_name'];
    address = json['address'];
    provinceName = json['province_name'];
    districtName = json['district_name'];
    wardName = json['ward_name'];
    dateActived = json['date_actived'];
    dateExpired = json['date_expired'];
    dateExpiredName = json['date_expired_name'];
    status = json['status'];
    warrantyPercent = json['warranty_percent'];
    warrantyValue = double.tryParse((json['warranty_value'] ?? 0).toString());
    warrantyValueApply = double.tryParse((json['warranty_value_apply'] ?? 0).toString());
    description = json['description'];
    objectType = json['object_type'];
    objectTypeId = json['object_type_id'];
    objectCode = json['object_code'];
    objectPrice = double.tryParse((json['object_price'] ?? 0).toString());
    objectSerial = json['object_serial'];
    objectNote = json['object_note'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
    color = HexColor(statusColor ?? "000000");
    objectName = json['object_name'];
    fullAddress = json['full_address'];
    if (json['warranty_image'] != null) {
      warrantyImage = <WarrantyImageModel>[];
      json['warranty_image'].forEach((v) {
        warrantyImage!.add(new WarrantyImageModel.fromJson(v));
      });
    }
    isUpdate = json['is_update'];
    isCreateMaintenance = json['is_create_maintenance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_card_id'] = this.warrantyCardId;
    data['warranty_card_code'] = this.warrantyCardCode;
    data['warranty_packed_code'] = this.warrantyPackedCode;
    data['packed_name'] = this.packedName;
    data['quota'] = this.quota;
    data['customer_id'] = this.customerId;
    data['customer_code'] = this.customerCode;
    data['customer_name'] = this.customerName;
    data['phone'] = this.phone;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['customer_avatar'] = this.customerAvatar;
    data['group_name'] = this.groupName;
    data['address'] = this.address;
    data['province_name'] = this.provinceName;
    data['district_name'] = this.districtName;
    data['ward_name'] = this.wardName;
    data['date_actived'] = this.dateActived;
    data['date_expired'] = this.dateExpired;
    data['date_expired_name'] = this.dateExpiredName;
    data['status'] = this.status;
    data['warranty_percent'] = this.warrantyPercent;
    data['warranty_value'] = this.warrantyValue;
    data['warranty_value_apply'] = this.warrantyValueApply;
    data['description'] = this.description;
    data['object_type'] = this.objectType;
    data['object_type_id'] = this.objectTypeId;
    data['object_code'] = this.objectCode;
    data['object_price'] = this.objectPrice;
    data['object_serial'] = this.objectSerial;
    data['object_note'] = this.objectNote;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    data['object_name'] = this.objectName;
    data['full_address'] = this.fullAddress;
    if (this.warrantyImage != null) {
      data['warranty_image'] =
          this.warrantyImage!.map((v) => v.toJson()).toList();
    }
    data['is_update'] = this.isUpdate;
    data['is_create_maintenance'] = this.isCreateMaintenance;
    return data;
  }
}

class WarrantyImageModel {
  int? warrantyImageId;
  String? warrantyCardCode;
  String? link;

  WarrantyImageModel({this.warrantyImageId, this.warrantyCardCode, this.link});

  WarrantyImageModel.fromJson(Map<String, dynamic> json) {
    warrantyImageId = json['warranty_image_id'];
    warrantyCardCode = json['warranty_card_code'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_image_id'] = this.warrantyImageId;
    data['warranty_card_code'] = this.warrantyCardCode;
    data['link'] = this.link;
    return data;
  }
}
