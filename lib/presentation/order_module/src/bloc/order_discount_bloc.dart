
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/request/voucher_request_model.dart';
import 'package:epoint_deal_plugin/model/response/voucher_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OrderDiscountBloc extends BaseBloc {

  OrderDiscountBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerAmount.dispose();
    controllerPercent.dispose();
    controllerCode.dispose();
    _streamValue.close();
    _streamVoucherModel.close();
    _streamEnableCheck.close();
    super.dispose();
  }

  String? value;
  CheckVoucherResponseModel? voucherModel;

  final FocusNode focusAmount = FocusNode();
  final TextEditingController controllerAmount = TextEditingController();
  final FocusNode focusPercent = FocusNode();
  final TextEditingController controllerPercent = TextEditingController();
  final FocusNode focusCode = FocusNode();
  final TextEditingController controllerCode = TextEditingController();

  final _streamValue = BehaviorSubject<String>();
  ValueStream<String> get outputValue => _streamValue.stream;
  setValue(String event) => set(_streamValue, event);

  final _streamVoucherModel = BehaviorSubject<CheckVoucherResponseModel>();
  ValueStream<CheckVoucherResponseModel> get outputVoucherModel => _streamVoucherModel.stream;
  setVoucherModel(CheckVoucherResponseModel event) => set(_streamVoucherModel, event);

  final _streamEnableCheck = BehaviorSubject<bool>();
  ValueStream<bool> get outputEnableCheck => _streamEnableCheck.stream;
  setEnableCheck(bool event) => set(_streamEnableCheck, event);

  onChange(String event) {
    value = event;
    setValue(value!);
  }

  onConfirm() {
    if (value == null) {
      CustomNavigator.showCustomAlertDialog(
        context!,
        AppLocalizations.text(LangKey.notification),
        AppLocalizations.text(LangKey.discount_confirm_message),
      );
      return;
    }

    if(value == discountTypeCash){
      double? value = parseMoney(controllerAmount.text);

      if(value == 0){
        CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          AppLocalizations.text(LangKey.discount_value_message),
        );
        return;
      }

      CustomNavigator.pop(context!, object: DiscountCartModel(
          amount: value));
    }
    else if(value == discountTypePercent){
      int? value = int.tryParse(controllerPercent.text);

      if((value ?? 0) == 0){
        CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          AppLocalizations.text(LangKey.discount_value_message),
        );
        return;
      }

      CustomNavigator.pop(context!, object: DiscountCartModel(
          percent: value));
    }
    else{
      if(voucherModel == null){
        CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          AppLocalizations.text(LangKey.discount_value_message),
        );
        return;
      }

      CustomNavigator.pop(context!,
          object: DiscountCartModel(model: voucherModel));
    }
  }

  checkVoucher(CheckVoucherRequestModel model) async {
    CustomNavigator.showProgressDialog(context);
    ResponseModel response = await repository.checkVoucher(context, model);
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      voucherModel = CheckVoucherResponseModel.fromJson(response.data!);
      setVoucherModel(voucherModel!);
    }
  }
}