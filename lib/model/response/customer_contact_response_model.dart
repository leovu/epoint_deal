

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CustomerContactResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerContactModel>? items;

  CustomerContactResponseModel({this.pageInfo, this.items});

  CustomerContactResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerContactModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerContactModel.fromJson(v));
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

class CustomerContactModel {
  int? customerContactId;
  String? customerContactCode;
  String? contactName;
  String? contactPhone;
  String? staffTitleName;
  String? contactEmail;
  String? createdAt;
  String? updatedAt;
  String? customerName;
  String? customerType;
  String? customerTypeName;
  String? staffCreatedAvatar;
  String? staffCreatedName;
  String? staffUpdatedName;

  CustomerContactModel(
      {this.customerContactId,
        this.customerContactCode,
        this.contactName,
        this.contactPhone,
        this.staffTitleName,
        this.contactEmail,
        this.createdAt,
        this.updatedAt,
        this.customerName,
        this.customerType,
        this.customerTypeName,
        this.staffCreatedAvatar,
        this.staffCreatedName,
        this.staffUpdatedName});

  CustomerContactModel.fromJson(Map<String, dynamic> json) {
    customerContactId = json['customer_contact_id'];
    customerContactCode = json['customer_contact_code'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    staffTitleName = json['staff_title_name'];
    contactEmail = json['contact_email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerName = json['customer_name'];
    customerType = json['customer_type'];
    customerTypeName = json['customer_type_name'];
    staffCreatedAvatar = json['staff_created_avatar'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_contact_id'] = this.customerContactId;
    data['customer_contact_code'] = this.customerContactCode;
    data['contact_name'] = this.contactName;
    data['contact_phone'] = this.contactPhone;
    data['staff_title_name'] = this.staffTitleName;
    data['contact_email'] = this.contactEmail;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_name'] = this.customerName;
    data['customer_type'] = this.customerType;
    data['customer_type_name'] = this.customerTypeName;
    data['staff_created_avatar'] = this.staffCreatedAvatar;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    return data;
  }
}
