/*
* Created by: hieupc
* Created at: 2021/06/08 3:57 PM
*/
class ReportInventoryRequestModel {
  String? date;
  int? warehouseId;
  int? page;
  String? brandCode;

  ReportInventoryRequestModel({this.brandCode, this.page, this.date, this.warehouseId});

  ReportInventoryRequestModel.fromJson(Map<String, dynamic> json) {
    warehouseId = json['warehouse_id'];
    date = json['date'];
    page = json['page'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouse_id'] = this.warehouseId;
    data['date'] = this.date;
    data['page'] = this.page;
    data['brand_code'] = this.brandCode;
    return data;
  }
}
