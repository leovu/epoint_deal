class OrderConfigResponseModel {
  List<OrderConfigModel>? data;

  OrderConfigResponseModel({this.data});

  OrderConfigResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <OrderConfigModel>[];
      json.forEach((v) {
        data!.add(new OrderConfigModel.fromJson(v));
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

class OrderConfigModel {
  int? orderConfigTabId;
  String? code;
  String? tabNameVi;
  String? type;

  OrderConfigModel({this.orderConfigTabId, this.code, this.tabNameVi, this.type});

  OrderConfigModel.fromJson(Map<String, dynamic> json) {
    orderConfigTabId = json['order_config_tab_id'];
    code = json['code'];
    tabNameVi = json['tab_name_vi'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_config_tab_id'] = this.orderConfigTabId;
    data['code'] = this.code;
    data['tab_name_vi'] = this.tabNameVi;
    data['type'] = this.type;
    return data;
  }
}
