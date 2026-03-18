

import 'package:epoint_deal_plugin/model/page_info_model.dart';

import 'order_response_model.dart';

class CustomerOrderResponseModel {
  PageInfoModel? pageInfo;
  List<OrderModel>? items;
  CustomerOrderAnalyticsModel? analytics;
  List<CustomerOrderStatusModel>? status;

  CustomerOrderResponseModel({this.pageInfo, this.items, this.analytics, this.status});

  CustomerOrderResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <OrderModel>[];
      json['Items'].forEach((v) {
        items!.add(new OrderModel.fromJson(v));
      });
    }
    analytics = json['Analytics'] != null
        ? new CustomerOrderAnalyticsModel.fromJson(json['Analytics'])
        : null;
    if (json['status'] != null) {
      status = <CustomerOrderStatusModel>[];
      json['status'].forEach((v) {
        status!.add(new CustomerOrderStatusModel.fromJson(v));
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
    if (this.analytics != null) {
      data['Analytics'] = this.analytics!.toJson();
    }
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerOrderAnalyticsModel {
  double? totalUnpaid;
  double? totalPaid;
  double? totalOrder;

  CustomerOrderAnalyticsModel({this.totalUnpaid, this.totalPaid, this.totalOrder});

  CustomerOrderAnalyticsModel.fromJson(Map<String, dynamic> json) {
    totalUnpaid = double.tryParse((json['total_unpaid'] ?? 0.0).toString());
    totalPaid = double.tryParse((json['total_paid'] ?? 0.0).toString());
    totalOrder = double.tryParse((json['total_order'] ?? 0.0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_unpaid'] = this.totalUnpaid;
    data['total_paid'] = this.totalPaid;
    data['total_order'] = this.totalOrder;
    return data;
  }
}

class CustomerOrderStatusModel {
  String? status;
  String? statusName;
  String? statusColor;

  CustomerOrderStatusModel({this.status, this.statusName, this.statusColor});

  CustomerOrderStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    return data;
  }
}