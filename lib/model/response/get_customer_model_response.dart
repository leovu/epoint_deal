class GetCustomerModelResponse {
  int errorCode;
  String errorDescription;
  List<CustomerData> data;

  GetCustomerModelResponse({this.errorCode, this.errorDescription, this.data});

  GetCustomerModelResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    if (json['Data'] != null) {
      data = <CustomerData>[];
      json['Data'].forEach((v) {
        data.add(new CustomerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerData {
  int customerId;
  String fullName;
  String customerCode;
  bool selected;

  CustomerData({this.customerId, this.fullName, this.customerCode});

  CustomerData.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    fullName = json['full_name'];
    customerCode = json['customer_code'];
    selected = json['selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['full_name'] = this.fullName;
    data['customer_code'] = this.customerCode;
    data['selected'] = this.selected;
    return data;
  }
}
