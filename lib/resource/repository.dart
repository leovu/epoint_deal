import 'package:epoint_deal_plugin/model/request/check_transport_charge_request_model.dart';
import 'package:epoint_deal_plugin/model/request/get_history_req_model.dart';
import 'package:epoint_deal_plugin/model/request/maintenance_receipt_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_request_model.dart';
import 'package:epoint_deal_plugin/model/request/booking_staff_request_model.dart';
import 'package:epoint_deal_plugin/model/request/create_qr_code_request_model.dart';
import 'package:epoint_deal_plugin/model/request/destory_order_request_model.dart';
import 'package:epoint_deal_plugin/model/request/member_discount_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_config_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_service_card_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_service_card_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_store_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_upload_image_request_model.dart';
import 'package:epoint_deal_plugin/model/request/other_free_branch_request_model.dart';
import 'package:epoint_deal_plugin/model/request/payment_request_model.dart';
import 'package:epoint_deal_plugin/model/request/print_devices_request_model.dart';
import 'package:epoint_deal_plugin/model/request/product_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/product_request_model.dart';
import 'package:epoint_deal_plugin/model/request/remove_photo_order_model.dart';
import 'package:epoint_deal_plugin/model/request/send_rating_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_card_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_card_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_request_model.dart';
import 'package:epoint_deal_plugin/model/request/status_vnpay_request_model.dart';
import 'package:epoint_deal_plugin/model/request/transport_method_request_model.dart';
import 'package:epoint_deal_plugin/model/request/voucher_request_model.dart';
import 'package:epoint_deal_plugin/network/http/aws_connection.dart';
import 'package:epoint_deal_plugin/resource/aws_resource.dart';
import 'package:epoint_deal_plugin/resource/booking_resource.dart';
import 'package:epoint_deal_plugin/resource/manage_word_resource.dart';
import 'package:epoint_deal_plugin/resource/order_resource.dart';
import 'package:epoint_deal_plugin/resource/payment_resource.dart';
import 'package:flutter/material.dart';

class Repository {
  var _orderResource = OrderResource();
  var _bookingResource = BookingResource();
  var _paymentResource = PaymentResource();
  var _awsResource = AWSResource();
  var _manageWorkResource = ManageWorkResource();

  getOrder(BuildContext? context, OrderRequestModel model) =>
      _orderResource.getOrder(context, model);
  uploadPhotoOrder(BuildContext? context, OrderUploadImageRequestModel model) =>
      _orderResource.uploadPhotoOrder(context, model);
  orderStore(BuildContext? context, OrderStoreRequestModel model) =>
      _orderResource.orderStore(context, model);
  orderUpdate(BuildContext? context, OrderStoreRequestModel model) =>
      _orderResource.orderUpdate(context, model);
  getPrintOrder(BuildContext? context, int? orderId, String? brandCode) =>
      _orderResource.getPrintOrder(context, orderId, brandCode);
  getOrderDetail(BuildContext? context, OrderDetailRequestModel model) =>
      _orderResource.getOrderDetail(context, model);
  destroyOrder(BuildContext? context, DestroyOrderRequestModel model) =>
      _orderResource.destroyOrder(context, model);
  createQRCode(BuildContext? context, CreateQRCodeRequestModel model) =>
      _orderResource.createQRCode(context, model);
  getStatusVNPay(BuildContext? context, StatusVNPayRequestModel model) =>
      _orderResource.getStatusVNPay(context, model);
  getTransportMethod(
          BuildContext? context, TransportMethodRequestModel model) =>
      _orderResource.getTransportMethod(context, model);
  productDetail(BuildContext? context, ProductDetailRequestModel model,
          {bool showError = true}) =>
      _orderResource.productDetail(context, model, showError);
  serviceDetail(BuildContext? context, ServiceDetailRequestModel model,
          {bool showError = true}) =>
      _orderResource.serviceDetail(context, model, showError);
  printDevices(BuildContext? context, PrintDevicesRequestModel model) =>
      _orderResource.printDevices(context, model);
  serviceCategory(BuildContext? context) =>
      _orderResource.serviceCategory(context);
  orderConfig(BuildContext? context, OrderConfigRequestModel model) =>
      _orderResource.orderConfig(context, model);
  orderServiceCard(BuildContext? context, OrderServiceCardRequestModel model) =>
      _orderResource.orderServiceCard(context, model);
  orderServiceCardDetail(
          BuildContext? context, OrderServiceCardDetailRequestModel model,
          {bool? showError}) =>
      _orderResource.orderServiceCardDetail(context, model, showError ?? true);
  orderServiceCardUsing(BuildContext? context, ServiceCardRequestModel model) =>
      _orderResource.orderServiceCardUsing(context, model);
  orderServiceCardDetailActive(
          BuildContext? context, ServiceCardDetailRequestModel model,
          {bool? showError}) =>
      _orderResource.orderServiceCardDetailActive(
          context, model, showError ?? true);
  orderStaff(BuildContext? context, BookingStaffRequestModel model) =>
      _orderResource.orderStaff(context, model);
  orderVAT(BuildContext? context) => _orderResource.orderVAT(context);
  config(BuildContext? context) => _orderResource.config(context);
  otherFreeBranch(BuildContext? context, OtherFreeBranchRequestModel model) =>
      _orderResource.otherFreeBranch(context, model);
  sendRating(BuildContext? context, SendRatingRequestModel model) =>
      _orderResource.sendRating(context, model);

  getService(BuildContext? context, ServiceRequestModel model) =>
      _orderResource.getService(context, model);
  getProduct(BuildContext? context, ProductRequestModel model) =>
      _orderResource.getProduct(context, model);
  productCategory(BuildContext? context) =>
      _orderResource.productCategory(context);
  getMemberDiscount(BuildContext? context, MemberDiscountRequestModel model) =>
      _orderResource.getMemberDiscount(context, model);
  checkVoucher(BuildContext? context, CheckVoucherRequestModel model) =>
      _orderResource.checkVoucher(context, model);
  removePhotoOrder(BuildContext? context, RemovePhotoOrderModel model) =>
      _orderResource.removePhotoOrder(context, model);

  getRoom(BuildContext? context) => _bookingResource.getRoom(context);

  getPaymentMethod(BuildContext? context) =>
      _paymentResource.getPaymentMethod(context);
  payment(BuildContext? context, PaymentRequestModel model) =>
      _paymentResource.payment(context, model);
  checkTransportCharge(
          BuildContext context, CheckTransportChargeRequestModel model) =>
      _paymentResource.checkTransportCharge(context, model);

  maintenanceReceipt(
          BuildContext? context, MaintenanceReceiptRequestModel model) =>
      _paymentResource.maintenanceReceipt(context, model);

  upload(BuildContext? context, AWSFileModel model, {bool showError = true}) =>
      _awsResource.upload(context, model, showError);

  workListDepartment(BuildContext? context) =>
      _manageWorkResource.workListDepartment(context);

  getOrderHistory(BuildContext? context, GetHistoryReqModel model) =>
      _paymentResource.getOrderHistory(context, model);

  getCareDeal(BuildContext? context, GetCareDealModel model) =>
      _paymentResource.getCareDeal(context, model);

  getListNote(BuildContext? context, GetListNoteModel model) =>
      _paymentResource.getListNote(context, model);
  addNote(BuildContext? context, CreateNoteReqModel model) =>
      _paymentResource.addNote(context, model);
}
