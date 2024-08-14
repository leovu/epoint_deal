/*
* Created by: hieupc
* Created at: 2021/06/14 11:54 AM
*/
class CommissionReportRequestModel {
  String? rangeDate;
  String? brandCode;

  CommissionReportRequestModel({this.brandCode, this.rangeDate});

  CommissionReportRequestModel.fromJson(Map<String, dynamic> json) {
    rangeDate = json['range_date'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['range_date'] = this.rangeDate;
    data['brand_code'] = this.brandCode;
    return data;
  }
}

