import 'package:epoint_deal_plugin/model/page_info_model.dart';


class CustomerReceiptResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerReceiptModel>? items;
  double? totalPaid;

  CustomerReceiptResponseModel({this.pageInfo, this.items, this.totalPaid});

  CustomerReceiptResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerReceiptModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerReceiptModel.fromJson(v));
      });
    }
    totalPaid = double.tryParse((json['total_paid'] ?? 0.0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['total_paid'] = this.totalPaid;
    return data;
  }
}

class CustomerReceiptModel {
  int? receiptId;
  String? receiptCode;
  String? orderCode;
  double? totalOrder;
  String? debtAmount;
  String? debtAmountPaid;
  String? objectType;
  String? receiptTypeNameVi;
  String? status;
  String? statusName;
  String? statusColor;
  double? totalMoney;
  int? branchId;
  String? branchName;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  double? paid;
  double? owed;

  CustomerReceiptModel(
      {this.receiptId,
      this.receiptCode,
      this.orderCode,
      this.totalOrder,
      this.debtAmount,
      this.debtAmountPaid,
      this.objectType,
      this.receiptTypeNameVi,
      this.status,
      this.statusName,
      this.statusColor,
      this.totalMoney,
      this.branchId,
      this.branchName,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.staffCreatedName,
      this.staffUpdatedName,
      this.paid,
      this.owed});

  CustomerReceiptModel.fromJson(Map<String, dynamic> json) {
    receiptId = json['receipt_id'];
    receiptCode = json['receipt_code'];
    orderCode = json['order_code'];
    totalOrder = double.tryParse((json['total_order'] ?? 0.0).toString());
    debtAmount = json['debt_amount'];
    debtAmountPaid = json['debt_amount_paid'];
    objectType = json['object_type'];
    receiptTypeNameVi = json['receipt_type_name_vi'];
    status = json['status'];
    statusName = json['status_name'];
    statusColor = json['status_color'];
    totalMoney = double.tryParse((json['total_money'] ?? 0.0).toString());
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    paid = double.tryParse((json['paid'] ?? 0.0).toString());
    owed = double.tryParse((json['owed'] ?? 0.0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_id'] = this.receiptId;
    data['receipt_code'] = this.receiptCode;
    data['order_code'] = this.orderCode;
    data['total_order'] = this.totalOrder;
    data['debt_amount'] = this.debtAmount;
    data['debt_amount_paid'] = this.debtAmountPaid;
    data['object_type'] = this.objectType;
    data['receipt_type_name_vi'] = this.receiptTypeNameVi;
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    data['status_color'] = this.statusColor;
    data['total_money'] = this.totalMoney;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['paid'] = this.paid;
    data['owed'] = this.owed;
    return data;
  }
}
