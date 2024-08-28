import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/presentation/discount_screen/discount_bloc.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_radio_button.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/format_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/maximum_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DiscountScreen extends StatefulWidget {
  // final OrderBloc bloc;
  // final CustomerModel customerModel;

  // DiscountScreen({this.bloc, this.customerModel});
  DiscountScreen({Key? key}) : super(key: key);

  @override
  DiscountScreenState createState() => DiscountScreenState();
}

class DiscountScreenState extends State<DiscountScreen> {
  final FocusNode _focusMoney = FocusNode();
  final TextEditingController _controllerMoney = TextEditingController();

  final FocusNode _focusPercent = FocusNode();
  final TextEditingController _controllerPercent = TextEditingController();

  // final FocusNode _focusCode = FocusNode();
  // final TextEditingController _controllerCode = TextEditingController();

  bool _isMoney = true;
  late int _amount;

  late DiscountBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = DiscountBloc(context);
    //  _amount = GlobalCart.shared.getValue().round();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    _controllerPercent.dispose();
    _controllerMoney.dispose();
    super.dispose();
  }

  _discountDirect() async {
    _controllerMoney.text = "";
    _controllerPercent.text = "";
    bool event = await CustomNavigator.showCustomAlertDialog(
        context, AppLocalizations.text(LangKey.direct_discount), null,
        enableCancel: true,
        child: StreamBuilder(
            stream: _bloc.outputIsMoney,
            initialData: _isMoney,
            builder: (_, snapshot) {
              if (snapshot.data != null) {
                _isMoney = snapshot.data as bool;
              }
              // _isMoney = snapshot.data as bool?;
              return Column(
                children: [
                  _buildType(
                      "${AppLocalizations.text(LangKey.cash)} (VNĐ)", true),
                  _buildType(
                      "${AppLocalizations.text(LangKey.percent)} (%)", false),
                  _isMoney
                      ? CustomTextField(
                          focusNode: _focusMoney,
                          controller: _controllerMoney,
                          hintText: AppLocalizations.text(
                              LangKey.enter_discount_amount),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FormatNumberInputFormatter(AppFormat.moneyFormat),
                          ],
                          textAlign: TextAlign.center,
                          // onChanged: (event) {
                          //   if (AppFormat.moneyFormat.parse(event) > _amount) {
                          //     _controllerMoney.text = AppFormat.moneyFormat
                          //         .format(GlobalCart.shared.getValue());
                          //     _controllerMoney.selection =
                          //         TextSelection.collapsed(
                          //             offset: _controllerMoney.text.length);
                          //   }
                          // },
                        )
                      : CustomTextField(
                          focusNode: _focusPercent,
                          controller: _controllerPercent,
                          hintText: AppLocalizations.text(
                              LangKey.enter_discount_percentage),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            MaximumNumberInputFormatter(100)
                          ],
                          textAlign: TextAlign.center,
                        )
                ],
              );
            }),
        textSubmitted: AppLocalizations.text(LangKey.confirm), onSubmitted: () {
      CustomNavigator.pop(context, object: true);
    });
    if ((event)) {
      // String money = _isMoney ? _controllerMoney.text : _controllerPercent.text;
      // CustomNavigator.pop(context,
      //     object: money.isEmpty
      //         ? null
      //         : _isMoney
      //             ? DiscountCartModel(
      //                 amount: AppFormat.moneyFormat.parse(money).toInt())
      //             : DiscountCartModel(percent: int.tryParse(money)));
    }
  }

  // _discountByCode(){
  //   _controllerCode.text = "";
  //   CustomNavigator.showCustomAlertDialog(
  //       context,
  //       AppLocalizations.text(LangKey.discount_by_code),
  //       null,
  //       enableCancel: true,
  //       child: CustomTextField(
  //         focusNode: _focusCode,
  //         controller: _controllerCode,
  //         hintText: AppLocalizations.text(LangKey.enter_discount_code),
  //       ),
  //       textSubmitted: AppLocalizations.text(LangKey.confirm),
  //       onSubmitted: () async {
  //         if(_controllerCode.text.isEmpty){
  //           CustomNavigator.pop(context);
  //           CustomNavigator.pop(context);
  //         }
  //         else{
  //           if (widget.customerModel == null) {
  //             CustomNavigator.showCustomAlertDialog(
  //                 context,
  //                 AppLocalizations.text(LangKey.notification),
  //                 '${AppLocalizations.text(LangKey.you_have_not_selected_a_customer)}!');
  //             return;
  //           }
  //           List<ArrObject> models = [];
  //           for(var e in GlobalCart.shared.products ?? <ProductModel>[]){
  //             models.add(ArrObject(objectId: e.productId, objectType: subjectTypeProduct));
  //           }
  //           for(var e in GlobalCart.shared.services ?? <ServiceModel>[]){
  //             models.add(ArrObject(objectId: e.serviceId, objectType: subjectTypeService));
  //           }
  //           CheckVoucherRequestModel model = CheckVoucherRequestModel(
  //             customerId: widget.customerModel.customerId,
  //             brandCode: Globals.prefs.getString(SharedPrefsKey.brand_code),
  //             voucherCode: _controllerCode.text,
  //             totalAmount: double.tryParse(GlobalCart.shared.getValue().round().toString()).toString(),
  //             arrObject: models
  //           );
  //           CheckVoucherResponseModel result = await widget.bloc.checkVoucher(model);
  //           if(result != null){
  //             CustomNavigator.pop(context);
  //             CustomNavigator.pop(context, object: DiscountCartModel(model: result));
  //           }
  //         }
  //       }
  //   );
  // }

  Widget _buildType(String text, bool type) {
    return InkWell(
      child: Row(
        children: [
          CustomRadioButton(
              type == _isMoney, (event) => _bloc.setIsMoney(type)),
          Expanded(
              child: Text(
            text ?? "",
            style: AppTextStyles.style14BlackNormal,
          ))
        ],
      ),
      onTap: () => _bloc.setIsMoney(type),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: AppLocalizations.text(LangKey.discount),
      body: CustomBottomOption(
        options: [
          CustomBottomOptionModel(
              image: Assets.imageDiscountDirect,
              text: AppLocalizations.text(LangKey.direct_discount),
              onTap: _discountDirect),
          CustomBottomOptionModel(
              image: Assets.imageDiscountVoucher,
              text: AppLocalizations.text(LangKey.discount_by_code),
              textColor: AppColors.grey700Color
              // onTap: _discountByCode
              ),
        ],
      ),
    );
  }
}
