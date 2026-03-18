class CustomerDebtPaymentRequestModel {
  int? customerId;
  int? orderId;
  String? orderCode;
  double? totalAmountReceipt;
  double? amountPaid;
  double? amountReturn;
  String? note;
  List<CustomerDebtPaymentMethodModel>? paymentMethod;
  List<String>? listFile;

  CustomerDebtPaymentRequestModel(
      {this.customerId,
        this.orderId,
        this.orderCode,
        this.totalAmountReceipt,
        this.amountPaid,
        this.amountReturn,
        this.note,
        this.paymentMethod,
        this.listFile});

  CustomerDebtPaymentRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    totalAmountReceipt = double.tryParse((json['total_amount_receipt'] ?? 0.0).toString());
    amountPaid = double.tryParse((json['amount_paid'] ?? 0.0).toString());
    amountReturn = double.tryParse((json['amount_return'] ?? 0.0).toString());
    note = json['note'];
    if (json['payment_method'] != null) {
      paymentMethod = <CustomerDebtPaymentMethodModel>[];
      json['payment_method'].forEach((v) {
        paymentMethod!.add(new CustomerDebtPaymentMethodModel.fromJson(v));
      });
    }
    listFile = json['list_file'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['order_id'] = this.orderId;
    data['order_code'] = this.orderCode;
    data['total_amount_receipt'] = this.totalAmountReceipt;
    data['amount_paid'] = this.amountPaid;
    data['amount_return'] = this.amountReturn;
    data['note'] = this.note;
    if (this.paymentMethod != null) {
      data['payment_method'] =
          this.paymentMethod!.map((v) => v.toJson()).toList();
    }
    data['list_file'] = this.listFile;
    return data;
  }
}

class CustomerDebtPaymentMethodModel {
  String? paymentMethodCode;
  double? money;

  CustomerDebtPaymentMethodModel({this.paymentMethodCode, this.money});

  CustomerDebtPaymentMethodModel.fromJson(Map<String, dynamic> json) {
    paymentMethodCode = json['payment_method_code'];
    money = double.tryParse((json['money'] ?? 0.0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_code'] = this.paymentMethodCode;
    data['money'] = this.money;
    return data;
  }
}
