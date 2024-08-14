
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/model/request/destory_order_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_service_card_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/product_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_card_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/preview_print_model.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/list_printer_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/order_payment_new_screen.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_appbar.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';

import '../ui/order_create_screen.dart';
import '../ui/order_photo_upload_screen.dart';

class OrderDetailBloc extends BaseBloc {
  OrderDetailBloc(BuildContext context) {
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamModel.close();
    super.dispose();
  }

  List<CustomOptionAppBar>? options;
  int? id;
  Function? onParentRefresh;

  OrderDetailResponseModel? model;

  final _streamModel = BehaviorSubject<OrderDetailResponseModel?>();
  ValueStream<OrderDetailResponseModel?> get outputModel => _streamModel.stream;
  setModel(OrderDetailResponseModel? event) => set(_streamModel, event);

  Future onRefresh({bool isRefresh = true}) {
    return getOrderDetail(OrderDetailRequestModel(orderId: id), isRefresh);
  }

  getOrderDetail(OrderDetailRequestModel requestModel, bool isRefresh) async {
    if (!isRefresh) {
      setModel(null);
    }
    ResponseModel response =
        await repository.getOrderDetail(context, requestModel);
    if (response.success!) {
      model = OrderDetailResponseModel.fromJson(response.data!);
      setModel(model);
    } else {
      if (!isRefresh) {
        model = null;
        setModel(OrderDetailResponseModel());
      }
    }
  }

  destroyOrder(DestroyOrderRequestModel model) async {
    CustomNavigator.showProgressDialog(context!);
    ResponseModel response = await repository.destroyOrder(context, model);
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      await CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          response.errorDescription);
      CustomNavigator.pop(context!, object: true);
    }
  }

  productDetail(OrderDetailModel model, Function(ProductNewModel) onSuccess,
      Function(String) onError) async {
    ResponseModel response = await repository.productDetail(
        context, ProductDetailRequestModel(productId: model.objectId),
        showError: false);
    if (response.success!) {
      var responseModel = ProductNewModel.fromJson(response.data!);
      onSuccess(responseModel);
    } else {
      onError(response.errorDescription ?? "");
    }
  }

  serviceDetail(OrderDetailModel model, Function(ServiceNewModel) onSuccess,
      Function(String) onError) async {
    ResponseModel response = await repository.serviceDetail(
        context, ServiceDetailRequestModel(serviceId: model.objectId),
        showError: false);
    if (response.success!) {
      var responseModel = ServiceNewModel.fromJson(response.data!);
      onSuccess(responseModel);
    } else {
      onError(response.errorDescription ?? "");
    }
  }

  orderServiceCardDetail(
      OrderDetailModel model,
      Function(OrderServiceCardModel) onSuccess,
      Function(String) onError) async {
    ResponseModel response = await repository.orderServiceCardDetail(
        context,
        OrderServiceCardDetailRequestModel(
          serviceCardId: model.objectId,
        ),
        showError: false);
    if (response.success!) {
      var responseModel = OrderServiceCardModel.fromJson(response.data!);
      onSuccess(responseModel);
    } else {
      onError(response.errorDescription ?? "");
    }
  }

  orderServiceCardDetailActive(OrderDetailModel model,
      Function(ServiceCardModel) onSuccess, Function(String) onError) async {
    ResponseModel response = await repository.orderServiceCardDetailActive(
        context,
        ServiceCardDetailRequestModel(
            customerServiceCardId: model.objectId,
            customerId: this.model!.customerId),
        showError: false);
    if (response.success!) {
      var responseModel = ServiceCardModel.fromJson(response.data!);
      onSuccess(responseModel);
    } else {
      onError(response.errorDescription ?? "");
    }
  }

  getPrintOrder(int? orderId, String? brandCode,
      Function(PreviewPrintResponseModel) onSuccess) async {
    CustomNavigator.showProgressDialog(context!);
    ResponseModel response =
        await repository.getPrintOrder(context, orderId, brandCode);
    if (response.success!) {
      PreviewPrintResponseModel responseModel =
          PreviewPrintResponseModel.fromJson(response.data!);
      onSuccess(responseModel);
    } else {
      CustomNavigator.hideProgressDialog();
    }
  }

  onRemove() {
    CustomNavigator.showCustomAlertDialog(
        context!,
        AppLocalizations.text(LangKey.notification),
        "${AppLocalizations.text(LangKey.confirm_delete_order)}!",
        enableCancel: true,
        textSubmitted: AppLocalizations.text(LangKey.delete), onSubmitted: () {
      CustomNavigator.pop(context!);
      DestroyOrderRequestModel mdl = DestroyOrderRequestModel();
      mdl.orderId = model?.orderId;
      mdl.brandCode = Global.brandCode;
      mdl.type = 'remove';
      destroyOrder(mdl);
    });
  }

  onCancel() {
    CustomNavigator.showCustomAlertDialog(
        context!,
        AppLocalizations.text(LangKey.notification),
        "${AppLocalizations.text(LangKey.confirm_cancel_order)}!",
        enableCancel: true,
        textSubmitted: AppLocalizations.text(LangKey.cancel), onSubmitted: () {
      CustomNavigator.pop(context!);
      DestroyOrderRequestModel mdl = DestroyOrderRequestModel();
      mdl.orderId = model?.orderId;
      mdl.brandCode = Global.brandCode;
      mdl.type = 'cancel';
      destroyOrder(mdl);
    });
  }

  onEdit() async {
    CustomNavigator.showProgressDialog(context!);
    final group = <Future>[];

    List<ProductNewModel> productNewModels = [];
    List<ServiceNewModel> serviceNewModels = [];
    List<OrderServiceCardModel> serviceCardModels = [];
    List<ServiceCardModel> serviceCardActivatedModels = [];
    CustomerModel? customerModel;
    DeliveryAddress? deliveryAddressModel;

    String? error;

    for (var e in model!.orderDetail ?? <OrderDetailModel>[]) {
      if (e.objectType == subjectTypeProduct) {
        group.add(productDetail(e, (model) {
          model.staffModels = e.staffs;
          model.quantity = e.quantity;
          model.changePrice = e.price;
          model.discount = e.discount;
          model.note = e.note;
          model.voucherModel = parseDiscount(
              e.discount, e.discountType, e.discountValue, e.discountCode);
          model.surcharge = (e.surcharge ?? 0) == 0? null : e.surcharge;
          productNewModels.add(model);
        }, (event) => error = event));
      } else if (e.objectType == subjectTypeService) {
        group.add(serviceDetail(e, (model) {
          model.staffModels = e.staffs;
          model.quantity = e.quantity;
          model.changePrice = e.price;
          model.discount = e.discount;
          model.note = e.note;
          model.voucherModel = parseDiscount(
              e.discount, e.discountType, e.discountValue, e.discountCode);
          model.surcharge = (e.surcharge ?? 0) == 0? null : e.surcharge;
          serviceNewModels.add(model);
        }, (event) => error = event));
      } else if (e.objectType == subjectTypeServiceCard) {
        group.add(orderServiceCardDetail(e, (model) {
          model.staffModels = e.staffs;
          model.quantity = e.quantity;
          model.changePrice = e.price;
          model.discount = e.discount;
          model.note = e.note;
          model.voucherModel = parseDiscount(
              e.discount, e.discountType, e.discountValue, e.discountCode);
          model.surcharge = (e.surcharge ?? 0) == 0? null : e.surcharge;
          serviceCardModels.add(model);
        }, (event) => error = event));
      } else {
        group.add(orderServiceCardDetailActive(e, (model) {
          model.staffModels = e.staffs;
          model.quantity = e.quantity;
          model.note = e.note;
          serviceCardActivatedModels.add(model);
        }, (event) => error = event));
      }
    }

    if (model!.customerId == customerGuestId) {
      customerModel = CustomerModel(customerId: customerGuestId);
      deliveryAddressModel = model!.customerContactShipping;
    } else {
      customerModel = model!.customer;
    }

    await Future.wait(group);
    CustomNavigator.hideProgressDialog();

    if (productNewModels.isEmpty && serviceNewModels.isEmpty && error != null) {
      CustomNavigator.showCustomAlertDialog(
          context!, AppLocalizations.text(LangKey.notification), error);
    } else {
      bool? result = await CustomNavigator.push(
          context!,
          OrderCreateScreen(
            model: model,
            customerModel: customerModel,
            deliveryAddressModel: deliveryAddressModel,
            productNewModels: productNewModels,
            serviceNewModels: serviceNewModels,
            serviceCardModels: serviceCardModels,
            serviceCardActivatedModels: serviceCardActivatedModels,
          ));
      if ((result ?? false)) {
        if (onParentRefresh != null) {
          onParentRefresh!();
        }
        onRefresh(isRefresh: false);
      }
    }
  }

  onPayment() async {
    bool? result = await CustomNavigator.push(
        context!, OrderPaymentNewScreen(orderModel: model));
    if ((result ?? false)) {
      if (onParentRefresh != null) {
        onParentRefresh!();
      }
      onRefresh(isRefresh: false);
    }
  }

  onUpload() async {
    // bool? event = await CustomNavigator.push(
    //     context!,
    //     OrderPhotoUploadScreen(
    //         model?.orderCode, model?.imageBefore, model?.imageAfter));
    // if ((event ?? false)) {
    //   onRefresh(isRefresh: false);
    // }
  }

  onPrinter() {
    // CustomNavigator.push(
    //     context!,
    //     ListPrinterScreen(
    //       id: model!.orderId,
    //       code: model!.orderCode,
    //     ));

  }
}
