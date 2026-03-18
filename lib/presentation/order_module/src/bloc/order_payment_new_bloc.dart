import 'dart:io';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/model/request/maintenance_receipt_request_model.dart';
import 'package:epoint_deal_plugin/model/request/payment_request_model.dart';
import 'package:epoint_deal_plugin/model/response/maintenance_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/payment_method_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/network/http/aws_connection.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OrderPaymentNewBloc extends BaseBloc {
  OrderPaymentNewBloc(BuildContext context) {
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamModels.close();
    _streamImages.close();
    _removeListener();
    super.dispose();
  }

  OrderDetailResponseModel? orderModel;
  MaintenanceDetailResponseModel? maintenanceModel;
  late double owed, finalMoney, paid;

  List<PaymentMethodResponseModel>? models;
  List<PaymentMethodResponseModel>? selectedModels;
  List<String> images = [];

  final FocusNode focusNote = FocusNode();
  final TextEditingController controllerNote = TextEditingController();

  final _streamModels = BehaviorSubject<List<PaymentMethodResponseModel>?>();
  ValueStream<List<PaymentMethodResponseModel>?> get outputModels =>
      _streamModels.stream;
  setModels(List<PaymentMethodResponseModel>? event) =>
      set(_streamModels, event);

  final _streamImages = BehaviorSubject<List<String>>();
  ValueStream<List<String>> get outputImages => _streamImages.stream;
  setImages(List<String> event) => set(_streamImages, event);

  Future onRefresh({bool isRefresh = true}) {
    return getPaymentMethod(owed, isRefresh);
  }

  onPaymentMethodRemove(PaymentMethodResponseModel model) {
    if (selectedModels!.length == 1) {
      CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          AppLocalizations.text(LangKey.payment_method_selected_message));
      return;
    }
    selectedModels!.remove(model);
    setModels(selectedModels);
  }

  onPaymentMethod() async {
    if (models == null) {
      await onRefresh(isRefresh: true);
      if (models == null) {
        return;
      }
    }
    List<CustomBottomOptionModel> events = models!
        .map((e) => CustomBottomOptionModel(
              id: e.paymentMethodCode,
              text: e.paymentMethodName,
              isSelected: selectedModels!.firstWhereOrNull((element) =>
                      element.paymentMethodCode == e.paymentMethodCode) !=
                  null,
            ))
        .toList();
    CustomNavigator.showCustomBottomDialog(
        context!,
        CustomBottomSheet(
            body: CustomBottomOption(
          options: events,
          onConfirm: () {
            final selectedEvents =
                events.where((element) => element.isSelected!).toList();
            if (selectedEvents.isEmpty) {
              CustomNavigator.showCustomAlertDialog(
                  context!,
                  AppLocalizations.text(LangKey.notification),
                  AppLocalizations.text(
                      LangKey.payment_method_selected_message));
              return;
            }

            selectedModels = [];
            for (var e in selectedEvents) {
              selectedModels!.add(models!
                  .firstWhere((element) => element.paymentMethodCode == e.id));
            }
            setModels(selectedModels);
            CustomNavigator.pop(context!);
          },
        )));
  }

  _removeListener() {
    for (var e in models ?? <PaymentMethodResponseModel>[]) {
      e.node!.dispose();
      e.controller!.dispose();
    }
  }

  _addListener() {
    for (var e in models!) {
      e.node!.addListener(() {
        setModels(selectedModels);
      });
      e.controller!.addListener(() {
        setModels(selectedModels);
      });
    }
  }

  List<double> getMoneySuggest(PaymentMethodResponseModel model) {
    double money = parseMoney(
        model.controller!.text.isEmpty ? "0.0" : model.controller!.text);
    if (money == 0) {
      return [money100, money200, money500, money1ml];
    } else {
      double value = money * 10;
      List<double> values = [];
      while (value < money1bl) {
        if (value >= 10000 && value % 1000 == 0) {
          values.add(value);
        }
        value *= 10;
      }

      return values;
    }
  }

  onAddImage(List<File> files) async {
    CustomNavigator.pop(context!);
    CustomNavigator.showProgressDialog(context);
    String? error;
    for (var e in files) {
      await uploadFile(
          AWSFileModel(
            file: e,
          ), (url) {
        images.add(url);
      }, (e) => error = e);
    }
    CustomNavigator.hideProgressDialog();

    setImages(images);

    if (error != null) {
      CustomNavigator.showCustomAlertDialog(
          context!, AppLocalizations.text(LangKey.notification), error);
    }
  }

  onRemoveImage(int index) {
    images.removeAt(index);
    setImages(images);
  }

  getAmount() {
    double amount = 0;

    for (var e in selectedModels ?? <PaymentMethodResponseModel>[]) {
      amount += parseMoney(e.controller!.text);
    }

    return amount;
  }

  onExit() {
    CustomNavigator.pop(context!);
  }

  getPaymentMethod(double? totalMoney, bool isRefresh) async {
    if ((models?.length ?? 0) > 0) {
      return;
    }
    if (!isRefresh) {
      setModels(null);
    }
    ResponseModel response = await repository.getPaymentMethod(context);
    if (response.success!) {
      _removeListener();

      var events = <PaymentMethodResponseModel>[];
      selectedModels = [];
      response.datas!.forEach((e) {
        var model = PaymentMethodResponseModel.fromJson(e);

        if (model.paymentMethodCode == paymentMethodCASH) {
          if (totalMoney != 0) {
            model.controller!.text = formatMoney(totalMoney);
            model.controller!.selection =
                TextSelection.collapsed(offset: model.controller!.text.length);
          }
          selectedModels!.add(model);
        }

        events.add(model);
      });

      models = events;

      _addListener();

      setModels(selectedModels);
    } else {
      if (!isRefresh) {
        setModels([]);
      }
    }
  }

  uploadFile(AWSFileModel model, Function(String) onSuccess,
      Function(String?) onError) async {
    ResponseModel response =
        await repository.upload(context, model, showError: false);
    if (response.success!) {
      onSuccess(response.url ?? "");
    } else {
      onError(response.errorDescription);
    }
  }

  onPayment() {
    if ((selectedModels?.length ?? 0) == 0) {
      CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          AppLocalizations.text(LangKey.payment_method_selected_message));
      return;
    }
    CustomNavigator.showProgressDialog(context);
    double amount = getAmount();
    double cashReturn = amount - owed;
    if (cashReturn < 0) cashReturn = 0;
    if (orderModel != null) {
      payment(PaymentRequestModel(
          customerId: orderModel!.customerId,
          brandCode: Global.brandCode,
          orderCode: orderModel!.orderCode,
          orderId: orderModel!.orderId,
          amountPaid: amount,
          totalAmountReceipt: owed,
          amountReturn: cashReturn,
          paymentMethod: selectedModels!
              .map((e) => PaymentMethod(
                  paymentMethodCode: e.paymentMethodCode,
                  money: parseMoney(e.controller!.text)))
              .toList(),
          listFile: images,
          note: controllerNote.text));
    } else {
      maintenanceReceipt(MaintenanceReceiptRequestModel(
          customerId: maintenanceModel!.customerId,
          maintenanceId: maintenanceModel!.maintenanceId,
          maintenanceCode: maintenanceModel!.maintenanceCode,
          totalMoney: owed,
          amountPaid: amount,
          amountReturn: cashReturn,
          paymentMethod: selectedModels!
              .map((e) => PaymentMethod(
                  paymentMethodCode: e.paymentMethodCode,
                  money: parseMoney(e.controller!.text)))
              .toList(),
          note: controllerNote.text));
    }
  }

  payment(PaymentRequestModel model) async {
    ResponseModel response = await repository.payment(context, model);
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      _paymentSuccess(response.errorDescription);
    }
  }

  maintenanceReceipt(MaintenanceReceiptRequestModel model) async {
    ResponseModel response =
        await repository.maintenanceReceipt(context, model);
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      _paymentSuccess(response.errorDescription);
    }
  }

  _paymentSuccess(String? event) async {
    await CustomNavigator.showCustomAlertDialog(
        context!, AppLocalizations.text(LangKey.notification), event);
    CustomNavigator.pop(context!, object: true);
  }
}
