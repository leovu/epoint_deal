import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/model/request/check_transport_charge_request_model.dart';
import 'package:epoint_deal_plugin/model/request/get_history_req_model.dart';
import 'package:epoint_deal_plugin/model/request/maintenance_receipt_request_model.dart';
import 'package:epoint_deal_plugin/model/request/payment_request_model.dart';
import 'package:epoint_deal_plugin/model/request/upload_file_req_model.dart';
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

  getOrderHistory(BuildContext? context, GetHistoryReqModel model) => Interaction(
    context: context,
    url: API.getOrderHistory(),
    param: model.toJson(),
  ).post();

  getCareDeal(BuildContext? context, GetCareDealModel model) => Interaction(
    context: context,
    url: API.getCareDeal(),
    param: model.toJson(),
  ).post();

  getListNote(BuildContext? context, GetListNoteModel model) => Interaction(
    context: context,
    url: API.getListNote(),
    param: model.toJson(),
  ).post();

  addNote(BuildContext? context, CreateNoteReqModel model) => Interaction(
    context: context,
    url: API.addNote(),
    param: model.toJson(),
  ).post();

  getListFile(BuildContext? context, GetCareDealModel model) => Interaction(
    context: context,
    url: API.getListFile(),
    param: model.toJson(),
  ).post();

  addFile(BuildContext? context, UploadFileReqModel model) => Interaction(
    context: context,
    url: API.addFile(),
    param: model.toJson(),
  ).post();







}