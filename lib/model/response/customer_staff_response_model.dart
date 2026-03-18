class CustomerStaffResponseModel {
  List<CustomerStaffModel>? data;

  CustomerStaffResponseModel({this.data});

  CustomerStaffResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerStaffModel>[];
      json.forEach((v) {
        data!.add(new CustomerStaffModel.fromJson(v));
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

class CustomerStaffModel {
  int? customerStaffId;
  int? customerId;
  int? staffId;
  String? staffName;
  String? staffTitleName;
  String? phone;
  int? branchId;
  String? branchName;
  int? isPrimary;
  String? primaryName;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? createdAt;
  String? updatedAt;
  String? statusColor;

  CustomerStaffModel(
      {this.customerStaffId,
        this.customerId,
        this.staffId,
        this.staffName,
        this.staffTitleName,
        this.phone,
        this.branchId,
        this.branchName,
        this.isPrimary,
        this.primaryName,
        this.createdBy,
        this.updatedBy,
        this.staffCreatedName,
        this.staffUpdatedName,
        this.createdAt,
        this.updatedAt,
        this.statusColor});

  CustomerStaffModel.fromJson(Map<String, dynamic> json) {
    customerStaffId = json['customer_staff_id'];
    customerId = json['customer_id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    staffTitleName = json['staff_title_name'];
    phone = json['phone'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    isPrimary = json['is_primary'];
    primaryName = json['primary_name'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    statusColor = json['status_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_staff_id'] = this.customerStaffId;
    data['customer_id'] = this.customerId;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['staff_title_name'] = this.staffTitleName;
    data['phone'] = this.phone;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['is_primary'] = this.isPrimary;
    data['primary_name'] = this.primaryName;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status_color'] = this.statusColor;
    return data;
  }
}
