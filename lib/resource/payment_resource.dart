import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/model/request/check_transport_charge_request_model.dart';
import 'package:epoint_deal_plugin/model/request/maintenance_receipt_request_model.dart';
import 'package:epoint_deal_plugin/model/request/payment_request_model.dart';
import 'package:epoint_deal_plugin/network/api/api.dart';
import 'package:epoint_deal_plugin/network/api/interaction.dart';
import 'package:flutter/material.dart';

class PaymentResource{
  getPaymentMethod(BuildContext? context) => Interaction(
    context: context,
    url: API.getPaymentMethod(),
    param: {'brand_code':Global.brandCode},
  ).post();
  payment(BuildContext? context,PaymentRequestModel param) => Interaction(
    context: context,
    url: API.payment(),
    param: param.toJson(),
  ).post();
  checkTransportCharge(BuildContext context,CheckTransportChargeRequestModel param) => Interaction(
    context: context,
    url: API.checkTransportCharge(),
    param: param.toJson(),
  ).post();

 // Warranty
  maintenanceReceipt(BuildContext? context, MaintenanceReceiptRequestModel model) => Interaction(
    context: context,
    url: API.maintenanceReceipt(),
    param: model.toJson(),
  ).post();
}