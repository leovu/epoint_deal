/*
* Created by: hieupc
* Created at: 2021/06/14 4:07 PM
*/
class CommissionDetailReportRequestModel {
  String? rangeDate;
  String? brandCode;
  int? staffId;
  int? page;

  CommissionDetailReportRequestModel({this.brandCode, this.rangeDate, this.staffId, this.page});

  CommissionDetailReportRequestModel.fromJson(Map<String, dynamic> json) {
    rangeDate = json['range_date'];
    brandCode = json['brand_code'];
    staffId = json['staff_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['range_date'] = this.rangeDate;
    data['brand_code'] = this.brandCode;
    data['staff_id'] = this.staffId;
    data['page'] = this.page;
    return data;
  }
}