class CustomerDebtDetailRequestModel {
  int? customerId;
  int? customerDebtId;

  CustomerDebtDetailRequestModel({this.customerId, this.customerDebtId});

  CustomerDebtDetailRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerDebtId = json['customer_debt_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_debt_id'] = this.customerDebtId;
    return data;
  }
}
