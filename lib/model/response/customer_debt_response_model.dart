class CustomerDebtResponseModel {
  List<CustomerDebtModel>? data;

  CustomerDebtResponseModel({this.data});

  CustomerDebtResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerDebtModel>[];
      json.forEach((v) {
        data!.add(new CustomerDebtModel.fromJson(v));
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

class CustomerDebtModel {
  int? customerDebtId;
  String? debtCode;
  int? customerId;
  String? fullName;
  int? branchId;
  String? branchName;
  String? address;
  String? debtType;
  String? debtTypeName;
  int? orderId;
  String? orderCode;
  String? status;
  double? paid;
  double? amountPaid;
  double? owed;
  String? statusName;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? statusColor;

  CustomerDebtModel(
      {this.customerDebtId,
        this.debtCode,
        this.customerId,
        this.fullName,
        this.branchId,
        this.branchName,
        this.address,
        this.debtType,
        this.debtTypeName,
        this.orderId,
        this.orderCode,
        this.status,
        this.paid,
        this.amountPaid,
        this.owed,
        this.statusName,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.staffCreatedName,
        this.staffUpdatedName,
        this.statusColor});

  CustomerDebtModel.fromJson(Map<String, dynamic> json) {
    customerDebtId = json['customer_debt_id'];
    debtCode = json['debt_code'];
    customerId = json['customer_id'];
    fullName = json['full_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    address = json['address'];
    debtType = json['debt_type'];
    debtTypeName = json['debt_type_name'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    status = json['status'];
    paid = double.tryParse((json['paid'] ?? 0.0).toString());
    amountPaid = double.tryParse((json['amount_paid'] ?? 0.0).toString());
    owed = double.tryParse((json['owed'] ?? 0.0).toString());
    statusName = json['status_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    statusColor = json['status_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_debt_id'] = this.customerDebtId;
    data['debt_code'] = this.debtCode;
    data['customer_id'] = this.customerId;
    data['full_name'] = this.fullName;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['address'] = this.address;
    data['debt_type'] = this.debtType;
    data['debt_type_name'] = this.debtTypeName;
    data['order_id'] = this.orderId;
    data['order_code'] = this.orderCode;
    data['status'] = this.status;
    data['paid'] = this.paid;
    data['amount_paid'] = this.amountPaid;
    data['owed'] = this.owed;
    data['status_name'] = this.statusName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['status_color'] = this.statusColor;
    return data;
  }
}
