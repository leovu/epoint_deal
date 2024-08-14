class TicketSearchMaterialsRequestModel {
  String? productName;
  int? page;

  TicketSearchMaterialsRequestModel({this.productName, this.page});

  TicketSearchMaterialsRequestModel.fromJson(Map<String, dynamic> json) {
    productName = json['product_name'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['product_name'] = this.productName;
    data['page'] = this.page;
    return data;
  }
}