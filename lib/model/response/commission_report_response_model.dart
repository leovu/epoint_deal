/*
* Created by: hieupc
* Created at: 2021/06/14 11:59 AM
*/

class CustomerDetailResponseModel {
  double? totalCommission;
  List<CommissionStaffDetailModel>? commissionStaffDetail;

  CustomerDetailResponseModel(
      {this.totalCommission,
        this.commissionStaffDetail});

  CustomerDetailResponseModel.fromJson(Map<String, dynamic> json) {
    totalCommission = json['totalCommission'] == null?null:double.tryParse(json['totalCommission'].toString());

    if (json['detail'] != null) {
      commissionStaffDetail = <CommissionStaffDetailModel>[];
      json['detail'].forEach((v) {
        commissionStaffDetail!.add(new CommissionStaffDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCommission'] = this.totalCommission;
    if (this.commissionStaffDetail != null) {
      data['detail'] =
          this.commissionStaffDetail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CommissionStaffDetailModel {
  int? staffId;
  double? totalStaffMoney;
  String? staffName;
  bool? selected;

  CommissionStaffDetailModel(
      {this.staffId,
        this.totalStaffMoney,
        this.staffName});

  CommissionStaffDetailModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    totalStaffMoney = double.tryParse(json['total_staff_money'].toString());
    staffName = json['staff_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['total_staff_money'] = this.totalStaffMoney;
    data['staff_name'] = this.staffName;
    return data;
  }
}
