class OrderRequestModel {
  String? search;
  String? createdAt;
  String? status;
  int? page;
  String? brandCode;

  OrderRequestModel(
      {this.search, this.createdAt, this.status, this.page, this.brandCode});

  OrderRequestModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    createdAt = json['created_at'];
    status = json['status'];
    page = json['page'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['page'] = this.page;
    data['brand_code'] = this.brandCode;
    return data;
  }
}

class OrderDetailRequestModel {
  int? orderId;
  String? brandCode;

  OrderDetailRequestModel({this.orderId, this.brandCode});

  OrderDetailRequestModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['brand_code'] = this.brandCode;
    return data;
  }
}