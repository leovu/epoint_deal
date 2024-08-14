/*
* Created by: hieupc
* Created at: 2021/06/11 2:44 PM
*/

class InventoryTotalResponseModel {
  double? totalInventoryValue;
  int? totalInventory;

  InventoryTotalResponseModel(
      {this.totalInventoryValue,
        this.totalInventory});

  InventoryTotalResponseModel.fromJson(Map<String, dynamic> json) {
    totalInventoryValue = double.tryParse(json['total_inventory_value'].toString());
    totalInventory = json['total_inventory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_inventory_value'] = this.totalInventoryValue;
    data['total_inventory'] = this.totalInventory;
    return data;
  }
}