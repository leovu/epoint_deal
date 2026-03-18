

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class ProjectCustomerResponseModel {
  PageInfoModel? pageInfo;
  List<ProjectCustomerModel>? items;


  ProjectCustomerResponseModel({this.pageInfo, this.items});

  ProjectCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <ProjectCustomerModel>[];
      json['Items'].forEach((v) {
        items!.add(new ProjectCustomerModel.fromJson(v));
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

class ProjectCustomerModel{
  int? customerId;
  String? customerName;
  String? customerAvatar;
  String? gender;
  String? phone;
  String? email;
  String? customerType;
  bool? isSelected;

  ProjectCustomerModel({
    this.customerId,
    this.customerName,
    this.customerAvatar,
    this.gender,
    this.phone,
    this.email,
    this.customerType,
    this.isSelected = false,
  });

  ProjectCustomerModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['full_name'];
    customerAvatar = json['customer_avatar'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
    customerType = json['customer_type'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_avatar'] = this.customerAvatar;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['customer_type'] = this.customerType;
    return data;
  }
}
