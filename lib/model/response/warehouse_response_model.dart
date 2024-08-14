/*
* Created by: hieupc
* Created at: 2021/06/09 3:51 PM
*/

class WarehouseResponseModel {
  List<WarehouseModel>? data;

  WarehouseResponseModel({this.data});

  WarehouseResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WarehouseModel>[];
      json.forEach((v) {
        data!.add(new WarehouseModel.fromJson(v));
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

class WarehouseModel {
  int? warehouseId;
  String? name;
  int? branchId;
  int? isRetail;
  late bool selected;

  WarehouseModel(
      {this.warehouseId,
        this.name,
        this.branchId,
        this.isRetail});

  WarehouseModel.fromJson(Map<String, dynamic> json) {
    warehouseId = json['warehouse_id'];
    name = json['name'];
    branchId = json['branch_id'];
    isRetail = json['is_retail'];
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warehouse_id'] = this.warehouseId;
    data['name'] = this.name;
    data['branch_id'] = this.branchId;
    data['is_retail'] = this.isRetail;
    return data;
  }
}