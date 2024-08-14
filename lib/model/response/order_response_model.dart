

import 'package:epoint_deal_plugin/model/page_info_model.dart';

import 'order_detail_response_model.dart';

class OrderResponseModel {
  PageInfoModel? pageInfo;
  List<OrderModel>? items;

  OrderResponseModel({this.pageInfo, this.items});

  OrderResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <OrderModel>[];
      json['Items'].forEach((v) {
        items!.add(new OrderModel.fromJson(v));
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

class OrderModel {
  int? orderId;
  String? orderCode;
  String? branchName;
  String? referName;
  double? total;
  double? discount;
  double? amount;
  String? processStatus;
  String? voucherCode;
  double? discountMember;
  String? orderDate;
  String? contactAddress;
  String? deliveryStatus;
  int? deliveryActive;
  String? fullName;
  String? phone;
  String? processStatusName;
  String? processStatusColor;
  int? customerId;
  int? isEdit;
  List<OrderDetailModel>? orderDetail;
  double? paid;
  double? owed;

  OrderModel(
      {this.orderId,
      this.orderCode,
      this.branchName,
      this.referName,
      this.total,
      this.discount,
      this.amount,
      this.processStatus,
      this.voucherCode,
      this.discountMember,
      this.orderDate,
      this.contactAddress,
      this.deliveryStatus,
      this.deliveryActive,
      this.fullName,
      this.phone,
      this.processStatusName,
      this.processStatusColor,
      this.customerId,
      this.isEdit,
      this.orderDetail,
      this.paid,
      this.owed});

  OrderModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderCode = json['order_code'];
    branchName = json['branch_name'];
    referName = json['refer_name'];
    total = double.tryParse((json['total'] ?? 0.0).toString());
    discount = double.tryParse((json['discount'] ?? 0.0).toString());
    amount = double.tryParse((json['amount'] ?? 0.0).toString());
    processStatus = json['process_status'];
    voucherCode = json['voucher_code'];
    discountMember =
        double.tryParse((json['discount_member'] ?? 0.0).toString());
    orderDate = json['order_date'];
    contactAddress = json['contact_address'];
    deliveryStatus = json['delivery_status'];
    deliveryActive = json['delivery_active'];
    fullName = json['full_name'];
    phone = json['phone'];
    processStatusName = json['process_status_name'];
    processStatusColor = json['process_status_color'];
    customerId = json['customer_id'];
    isEdit = json['is_edit'];
    if (json['order_detail'] != null) {
      orderDetail = <OrderDetailModel>[];
      json['order_detail'].forEach((v) {
        orderDetail!.add(new OrderDetailModel.fromJson(v));
      });
    }
    paid = double.tryParse((json['paid'] ?? 0.0).toString());
    owed = double.tryParse((json['owed'] ?? 0.0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_code'] = this.orderCode;
    data['branch_name'] = this.branchName;
    data['refer_name'] = this.referName;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['process_status'] = this.processStatus;
    data['voucher_code'] = this.voucherCode;
    data['discount_member'] = this.discountMember;
    data['order_date'] = this.orderDate;
    data['contact_address'] = this.contactAddress;
    data['delivery_status'] = this.deliveryStatus;
    data['delivery_active'] = this.deliveryActive;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['process_status_name'] = this.processStatusName;
    data['process_status_color'] = this.processStatusColor;
    data['customer_id'] = this.customerId;
    data['is_edit'] = this.isEdit;
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    data['paid'] = this.paid;
    data['owed'] = this.owed;
    return data;
  }
}
