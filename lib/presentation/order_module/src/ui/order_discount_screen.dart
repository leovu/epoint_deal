
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/request/voucher_request_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/voucher_response_model.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_radio_button.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/format_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/maximum_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bloc/order_discount_bloc.dart';

class OrderDiscountScreen extends StatefulWidget {
  final ArrObject? model;
  final double? amount;
  final CustomerModel? customerModel;
  final bool fromOrder;

  OrderDiscountScreen({this.customerModel, this.model, this.amount, this.fromOrder = false});

  @override
  OrderDiscountScreenState createState() => OrderDiscountScreenState();
}

class OrderDiscountScreenState extends State<OrderDiscountScreen> {
  late OrderDiscountBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderDiscountBloc(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildItem({required String value}) {
    bool isSelected = value == _bloc.value;
    String title, image, hint;
    FocusNode focus;
    TextEditingController controller;
    Widget? child;
    TextInputType? keyboardType;
    List<TextInputFormatter>? inputFormatters;
    Function(String)? onChanged;
    GestureTapCallback? onSuffixTap;

    if(value == discountTypeCash){
      title = "${AppLocalizations.text(LangKey.direct_discount)} - ${AppLocalizations.text(LangKey.cash)}";
      image = Assets.imageDiscountCash;
      hint = AppLocalizations.text(LangKey.enter_discount_amount)!;
      focus = _bloc.focusAmount;
      controller = _bloc.controllerAmount;
      keyboardType = TextInputType.number;
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        FormatNumberInputFormatter(AppFormat.quantityFormat),
      ];
    }
    else if(value == discountTypePercent){
      title = "${AppLocalizations.text(LangKey.direct_discount)} - ${AppLocalizations.text(LangKey.percent)}";
      image = Assets.imageDiscountDirect;
      hint = AppLocalizations.text(LangKey.enter_discount_percentage)!;
      focus = _bloc.focusPercent;
      controller = _bloc.controllerPercent;
      keyboardType = TextInputType.number;
      inputFormatters = [
        FilteringTextInputFormatter.digitsOnly,
        MaximumNumberInputFormatter(100)
      ];
    }
    else{
      title = AppLocalizations.text(LangKey.discount_by_code)!;
      image = Assets.imageDiscountVoucher;
      hint = AppLocalizations.text(LangKey.enter_discount_code)!;
      focus = _bloc.focusCode;
      controller = _bloc.controllerCode;
      onChanged = (event) => _bloc.setEnableCheck(event.trim().isNotEmpty);
      child = Row(
        children: [
          Text(
            "${AppLocalizations.text(LangKey.value)}: ",
            style: AppTextStyles.style14HintNormal,
          ),
          Expanded(child: StreamBuilder(
              stream: _bloc.outputVoucherModel,
              initialData: _bloc.voucherModel,
              builder: (_, snapshot){
                CheckVoucherResponseModel? model = snapshot.data as CheckVoucherResponseModel?;
                return Text(
                  model == null ? AppLocalizations.text(LangKey.undefined)! : formatMoney(model.discount),
                  style: AppTextStyles.style14BlackNormal,
                );
              }
          ))
        ],
      );
      onSuffixTap = () {
        if (widget.customerModel == null) {
          CustomNavigator.showCustomAlertDialog(
              context,
              AppLocalizations.text(LangKey.notification),
              '${AppLocalizations.text(LangKey.you_have_not_selected_a_customer)}!');
          return;
        }

        List<ArrObject> models = [];
        double amount = 0.0;
        if(widget.model == null){
          for (var e in Globals.cart!.products) {
            models.add(
                ArrObject(objectId: e.productId, objectType: subjectTypeProduct));
          }
          for (var e in Globals.cart!.services) {
            models.add(
                ArrObject(objectId: e.serviceId, objectType: subjectTypeService));
          }
          for (var e in Globals.cart!.serviceCards) {
            models.add(
                ArrObject(objectId: e.serviceCardId, objectType: subjectTypeServiceCard));
          }
          for (var e in Globals.cart!.serviceActivatedCards) {
            models.add(
                ArrObject(objectId: e.customerServiceCardId, objectType: subjectTypeMemberCard));
          }
          amount = Globals.cart!.getValue(isStream: false);
        }
        else{
          models.add(widget.model!);
          amount = widget.amount ?? 0.0;
        }
        CheckVoucherRequestModel model = CheckVoucherRequestModel(
            customerId: widget.customerModel!.customerId,
            totalAmount: amount.toString(),
            arrObject: models,
            voucherCode: controller.text,
            objectType: "all");
        _bloc.checkVoucher(model);
      };
    }

    return ContainerBooking(
      CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            right: AppSizes.minPadding, bottom: AppSizes.minPadding),
        children: [
          Row(
            children: [
              CustomRadioButton(isSelected, (event) => _bloc.onChange(value)),
              Expanded(child: Text(
                title,
                style: AppTextStyles.style14PrimaryBold,
              ))
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: AppSizes.minPadding),
            child: CustomTextField(
              focusNode: focus,
              controller: controller,
              backgroundColor: Colors.transparent,
              borderColor: AppColors.borderColor,
              titleImage: image,
              hintText: hint,
              keyboardType: keyboardType,
              inputFormatters: inputFormatters,
              suffixText: onSuffixTap == null ? null : AppLocalizations.text(LangKey.check),
              onChanged: (event) {
                if(onChanged != null){
                  onChanged(event);
                }
                _bloc.setValue(value);
              },
              onSuffixTap: onSuffixTap,
            ),
          ),
          if(child != null)
            Padding(
              padding: EdgeInsets.only(left: AppSizes.minPadding),
              child: child,
            )
        ],
      ),
      onTap: () => _bloc.onChange(value),
      isSelected: isSelected,
    );
  }

  Widget _buildContent() {
    return StreamBuilder(
        stream: _bloc.outputValue,
        initialData: _bloc.value,
        builder: (_, snapshot){
          _bloc.value = snapshot.data as String?;
          return CustomListView(
            children: (widget.fromOrder ? [
              if(checkConfigKey(ConfigKey.discount_order_direct_money))
                discountTypeCash,
              if(checkConfigKey(ConfigKey.discount_order_direct_percent))
                discountTypePercent,
              if(checkConfigKey(ConfigKey.discount_order_voucher))
                discountTypeCode
            ] : [
              if(checkConfigKey(ConfigKey.discount_direct_money))
                discountTypeCash,
              if(checkConfigKey(ConfigKey.discount_direct_percent))
                discountTypePercent,
              if(checkConfigKey(ConfigKey.discount_voucher))
                discountTypeCode
            ]).map((e) => _buildItem(value: e)).toList(),
          );
        }
    );
  }

  Widget _buildBottom() {
    return CustomBottom(
      text: AppLocalizations.text(LangKey.confirm),
      onTap: _bloc.onConfirm,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [Expanded(child: _buildContent()), _buildBottom()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.discount),
      body: _buildBody(),
    );
  }
}
