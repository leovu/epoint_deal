/*
* Created by: hieupc
* Created at: 2021/06/14 4:03 PM
*/

/*
* Created by: hieupc
* Created at: 2021/06/08 4:21 PM
*/

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CommissionDetailReportResponseModel {
  PageInfoModel? pageInfo;
  List<CommissionDetailReportModel?>? items;

  CommissionDetailReportResponseModel({this.pageInfo, this.items});

  CommissionDetailReportResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CommissionDetailReportModel?>[];
      json['Items'].forEach((v) {
        items!.add(new CommissionDetailReportModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class CommissionDetailReportModel {
  String? staffName;
  double? staffMoney;
  double? staffCommissionRate;
  String? branchName;
  String? createdAt;

  CommissionDetailReportModel(
      {this.staffName,
        this.staffMoney,
        this.staffCommissionRate,
        this.branchName,
        this.createdAt});

  CommissionDetailReportModel.fromJson(Map<String, dynamic> json) {
    staffName = json['staff_name'];
    staffMoney = double.tryParse(json['staff_money'].toString());
    staffCommissionRate = double.tryParse(json['staff_commission_rate'].toString());
    branchName = json['branch_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_name'] = this.staffName;
    data['staff_money'] = this.staffMoney;
    data['staff_commission_rate'] = this.staffCommissionRate;
    data['branch_name'] = this.branchName;
    data['created_at'] = this.createdAt;
    return data;
  }
}