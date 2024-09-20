class BookingCustomerRequestModel {
  int? customerId;
  int? page;

  BookingCustomerRequestModel({this.customerId, this.page});

  BookingCustomerRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['page'] = this.page;
    return data;
  }
}