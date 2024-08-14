class PaymentRequestModel {
  String? brandCode;
  int? orderId;
  String? orderCode;
  int? customerId;
  double? amountPaid;
  double? totalAmountReceipt;
  double? amountReturn;
  String? note;
  List<PaymentMethod>? paymentMethod;
  List<String>? listFile;

  PaymentRequestModel(
      {this.brandCode,
        this.orderId,
        this.orderCode,
        this.customerId,
        this.amountPaid,
        this.totalAmountReceipt,
        this.amountReturn,
        this.note,
        this.paymentMethod,
        this.listFile});

  PaymentRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    customerId = json['customer_id'];
    amountPaid = json['amount_paid'];
    totalAmountReceipt = json['total_amount_receipt'];
    amountReturn = json['amount_return'];
    note = json['note'];
    if (json['payment_method'] != null) {
      paymentMethod = <PaymentMethod>[];
      json['payment_method'].forEach((v) {
        paymentMethod!.add(new PaymentMethod.fromJson(v));
      });
    }
    listFile = json['list_file'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['order_id'] = this.orderId;
    data['order_code'] = this.orderCode;
    data['customer_id'] = this.customerId;
    data['amount_paid'] = this.amountPaid;
    data['total_amount_receipt'] = this.totalAmountReceipt;
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

class PaymentMethod {
  String? paymentMethodCode;
  double? money;

  PaymentMethod({this.paymentMethodCode, this.money});

  PaymentMethod.fromJson(Map<String, dynamic> json) {
    paymentMethodCode = json['payment_method_code'];
    money = json['money'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['payment_method_code'] = this.paymentMethodCode;
    data['money'] = this.money;
    return data;
  }
}
