/*
* Created by: hieupc
* Created at: 2021/06/09 3:47 PM
*/
class WarehouseRequestModel {
  String? brandCode;

  WarehouseRequestModel({this.brandCode});

  WarehouseRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    return data;
  }
}