
import 'package:epoint_deal_plugin/model/request/booking_staff_request_model.dart';
import 'package:epoint_deal_plugin/model/request/create_qr_code_request_model.dart';
import 'package:epoint_deal_plugin/model/request/destory_order_request_model.dart';
import 'package:epoint_deal_plugin/model/request/member_discount_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_config_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_service_card_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_service_card_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_store_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_upload_image_request_model.dart';
import 'package:epoint_deal_plugin/model/request/other_free_branch_request_model.dart';
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
import 'package:epoint_deal_plugin/network/api/api.dart';
import 'package:epoint_deal_plugin/network/api/interaction.dart';
import 'package:flutter/material.dart';

class OrderResource{
  getOrder(BuildContext? context, OrderRequestModel model) => Interaction(
      context: context,
      url: API.getOrder(),
      param: model.toJson()
  ).post();
  getOrderDetail(BuildContext? context, OrderDetailRequestModel model) => Interaction(
      context: context,
      url: API.getOrderDetail(),
      param: model.toJson()
  ).post();
  getService(BuildContext? context, ServiceRequestModel model) => Interaction(
      context: context,
      url: API.getService(),
      param: model.toJson()
  ).post();
  getProduct(BuildContext? context, ProductRequestModel model) => Interaction(
      context: context,
      url: API.getProduct(),
      param: model.toJson()
  ).post();
  productCategory(BuildContext? context) => Interaction(
      context: context,
      url: API.productCategory(),
  ).post();
  getMemberDiscount(BuildContext? context, MemberDiscountRequestModel model) => Interaction(
      context: context,
      url: API.getMemberDiscount(),
      param: model.toJson(),
      showError: false
  ).post();
  orderStore(BuildContext? context, OrderStoreRequestModel model) => Interaction(
      context: context,
      url: API.orderStore(),
      param: model.toJson(),
  ).post();
  orderUpdate(BuildContext? context, OrderStoreRequestModel model) => Interaction(
      context: context,
      url: API.orderUpdate(),
      param: model.toJson()
  ).post();
  getPrintOrder(BuildContext? context, int? orderId, String? brandCode) => Interaction(
      context: context,
      url: API.getPrintOrder(),
      param: {
        'order_id': orderId,
        'brand_code': brandCode
      }).post();
  uploadPhotoOrder(BuildContext? context, OrderUploadImageRequestModel model) => Interaction(
      context: context,
      url: API.uploadPhotoOrder(),
      param: model.toJson(),
  ).post();
  checkVoucher(BuildContext? context, CheckVoucherRequestModel model) => Interaction(
      context: context,
      url: API.checkVoucher(),
      param: model.toJson()
  ).post();
  removePhotoOrder(BuildContext? context, RemovePhotoOrderModel model) => Interaction(
      context: context,
      url: API.removePhotoOrder(),
      param: model.toJson()
  ).post();
  destroyOrder(BuildContext? context, DestroyOrderRequestModel model) => Interaction(
      context: context,
      url: API.destroyOrder(),
      param: model.toJson()
  ).post();
  createQRCode(BuildContext? context, CreateQRCodeRequestModel model) => Interaction(
      context: context,
      url: API.createQRCode(),
      param: model.toJson()
  ).post();
  getStatusVNPay(BuildContext? context, StatusVNPayRequestModel model) => Interaction(
      context: context,
      url: API.getStatusVNPay(),
      param: model.toJson()
  ).post();
  getTransportMethod(BuildContext? context, TransportMethodRequestModel model) => Interaction(
      context: context,
      url: API.getTransportMethod(),
      param: model.toJson(),
      showError: false
  ).post();
  productDetail(BuildContext? context, ProductDetailRequestModel model, bool showError) => Interaction(
      context: context,
      url: API.productDetail(),
      param: model.toJson(),
      showError: showError
  ).post();
  serviceDetail(BuildContext? context, ServiceDetailRequestModel model, bool showError) => Interaction(
      context: context,
      url: API.serviceDetail(),
      param: model.toJson(),
      showError: showError
  ).post();
  printDevices(BuildContext? context, PrintDevicesRequestModel model) => Interaction(
      context: context,
      url: API.printDevices(),
      param: model.toJson()
  ).post();
  serviceCategory(BuildContext? context) => Interaction(
      context: context,
      url: API.serviceCategory(),
  ).post();
  orderConfig(BuildContext? context, OrderConfigRequestModel model) => Interaction(
      context: context,
      url: API.orderConfig(),
      param: model.toJson()
  ).post();
  orderServiceCard(BuildContext? context, OrderServiceCardRequestModel model) => Interaction(
      context: context,
      url: API.orderServiceCard(),
      param: model.toJson()
  ).post();
  orderServiceCardDetail(BuildContext? context, OrderServiceCardDetailRequestModel model, bool showError) => Interaction(
      context: context,
      url: API.orderServiceCardDetail(),
      param: model.toJson(),
      showError: showError
  ).post();
  orderServiceCardUsing(BuildContext? context, ServiceCardRequestModel model) => Interaction(
      context: context,
      url: API.orderServiceCardUsing(),
      param: model.toJson(),
  ).post();
  orderServiceCardDetailActive(BuildContext? context, ServiceCardDetailRequestModel model, bool showError) => Interaction(
      context: context,
      url: API.orderServiceCardDetailActive(),
      param: model.toJson(),
      showError: showError
  ).post();
  orderStaff(BuildContext? context, BookingStaffRequestModel model) => Interaction(
      context: context,
      url: API.orderStaff(),
      param: model.toJson()
  ).post();
  orderVAT(BuildContext? context) => Interaction(
      context: context,
      url: API.orderVAT()
  ).post();
  config(BuildContext? context) => Interaction(
      context: context,
      url: API.config(),
      showError: false
  ).post();
  otherFreeBranch(BuildContext? context, OtherFreeBranchRequestModel model) => Interaction(
      context: context,
      url: API.otherFreeBranch(),
      param: model.toJson()
  ).post();
  sendRating(BuildContext? context, SendRatingRequestModel model) => Interaction(
      context: context,
      url: API.sendRating(),
      param: model.toJson()
  ).post();
}