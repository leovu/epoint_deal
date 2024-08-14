class CustomerNoteRequestModel {
  int? customerId;
  int? page;
  String? brandCode;

  CustomerNoteRequestModel({this.customerId, this.page, this.brandCode});

  CustomerNoteRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    page = json['page'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['page'] = this.page;
    data['brand_code'] = this.brandCode;
    return data;
  }
}
