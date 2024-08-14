class ServiceCardRequestModel {
  String? search;
  int? customerId;
  int? page;

  ServiceCardRequestModel({this.search, this.customerId, this.page});

  ServiceCardRequestModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    customerId = json['customer_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['customer_id'] = this.customerId;
    data['page'] = this.page;
    return data;
  }
}