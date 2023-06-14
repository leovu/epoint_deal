class OrderSourceModelResponse {
  int? errorCode;
  String? errorDescription;
  List<OrderSourceData>? data;

  OrderSourceModelResponse({this.errorCode, this.errorDescription, this.data});

  OrderSourceModelResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    if (json['Data'] != null) {
      data = <OrderSourceData>[];
      json['Data'].forEach((v) {
        data!.add(new OrderSourceData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderSourceData {
  int? orderSourceId;
  String? orderSourceName;
  bool? selected;

  OrderSourceData({this.orderSourceId, this.orderSourceName,this.selected});

  OrderSourceData.fromJson(Map<String, dynamic> json) {
    orderSourceId = json['order_source_id'];
    orderSourceName = json['order_source_name'];
    selected = json['selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_source_id'] = this.orderSourceId;
    data['order_source_name'] = this.orderSourceName;
    data['selected'] = this.selected;
    return data;
  }
}
