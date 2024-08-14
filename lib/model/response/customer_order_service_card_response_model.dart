

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CustomerOrderServiceCardResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerOrderServiceCardModel>? items;
  int? totalUsedServiceCard;

  CustomerOrderServiceCardResponseModel({this.pageInfo, this.items, this.totalUsedServiceCard});

  CustomerOrderServiceCardResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerOrderServiceCardModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerOrderServiceCardModel.fromJson(v));
      });
    }
    totalUsedServiceCard = json['total_used_service_card'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total_used_service_card'] = this.totalUsedServiceCard;
    return data;
  }
}

class CustomerOrderServiceCardModel {
  String? orderCode;
  int? orderId;
  int? countUsed;
  int? createdBy;
  String? staffCreatedName;
  String? createdAt;
  String? staffId;
  int? sortOrder;
  List<CustomerOrderServiceCardStaffModel>? staffs;

  CustomerOrderServiceCardModel(
      {this.orderCode,
        this.orderId,
        this.countUsed,
        this.createdBy,
        this.staffCreatedName,
        this.createdAt,
        this.staffId,
        this.sortOrder,
        this.staffs});

  CustomerOrderServiceCardModel.fromJson(Map<String, dynamic> json) {
    orderCode = json['order_code'];
    orderId = json['order_id'];
    countUsed = json['count_used'];
    createdBy = json['created_by'];
    staffCreatedName = json['staff_created_name'];
    createdAt = json['created_at'];
    staffId = json['staff_id'];
    sortOrder = json['sort_order'];
    if (json['staffs'] != null) {
      staffs = <CustomerOrderServiceCardStaffModel>[];
      json['staffs'].forEach((v) {
        staffs!.add(new CustomerOrderServiceCardStaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_code'] = this.orderCode;
    data['order_id'] = this.orderId;
    data['count_used'] = this.countUsed;
    data['created_by'] = this.createdBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['created_at'] = this.createdAt;
    data['staff_id'] = this.staffId;
    data['sort_order'] = this.sortOrder;
    if (this.staffs != null) {
      data['staffs'] = this.staffs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerOrderServiceCardStaffModel {
  int? staffId;
  String? fullName;
  String? staffAvatar;

  CustomerOrderServiceCardStaffModel({this.staffId, this.fullName, this.staffAvatar});

  CustomerOrderServiceCardStaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    fullName = json['full_name'];
    staffAvatar = json['staff_avatar'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['full_name'] = this.fullName;
    data['staff_avatar'] = this.staffAvatar;
    return data;
  }
}
