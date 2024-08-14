import 'payment_request_model.dart';

class MaintenanceReceiptRequestModel {
  int? customerId;
  int? maintenanceId;
  String? maintenanceCode;
  double? totalMoney;
  double? amountPaid;
  double? amountReturn;
  String? note;
  List<PaymentMethod>? paymentMethod;

  MaintenanceReceiptRequestModel(
      {this.customerId,
        this.maintenanceId,
        this.maintenanceCode,
        this.totalMoney,
        this.amountPaid,
        this.amountReturn,
        this.note,
        this.paymentMethod});

  MaintenanceReceiptRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    maintenanceId = json['maintenance_id'];
    maintenanceCode = json['maintenance_code'];
    totalMoney = json['total_money'];
    amountPaid = json['amount_paid'];
    amountReturn = json['amount_return'];
    note = json['note'];
    if (json['payment_method'] != null) {
      paymentMethod = <PaymentMethod>[];
      json['payment_method'].forEach((v) {
        paymentMethod!.add(new PaymentMethod.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['maintenance_id'] = this.maintenanceId;
    data['maintenance_code'] = this.maintenanceCode;
    data['total_money'] = this.totalMoney;
    data['amount_paid'] = this.amountPaid;
    data['amount_return'] = this.amountReturn;
    data['note'] = this.note;
    if (this.paymentMethod != null) {
      data['payment_method'] =
          this.paymentMethod!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}