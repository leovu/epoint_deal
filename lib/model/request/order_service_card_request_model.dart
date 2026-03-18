class OrderServiceCardRequestModel {
  String? search;
  int? page;

  OrderServiceCardRequestModel({this.search, this.page});

  OrderServiceCardRequestModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['page'] = this.page;
    return data;
  }
}
