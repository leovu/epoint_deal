
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/customer_order_photo_model.dart';
import 'package:epoint_deal_plugin/model/response/maintenance_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/payment_method_response_model.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/format_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../bloc/order_payment_new_bloc.dart';

class OrderPaymentNewScreen extends StatefulWidget {
  final OrderDetailResponseModel? orderModel;
  final MaintenanceDetailResponseModel? maintenanceModel;

  const OrderPaymentNewScreen(
      {super.key, this.orderModel, this.maintenanceModel});

  @override
  OrderPaymentNewScreenState createState() => OrderPaymentNewScreenState();
}

class OrderPaymentNewScreenState extends State<OrderPaymentNewScreen> {
  late OrderPaymentNewBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderPaymentNewBloc(context);

    _bloc.orderModel = widget.orderModel;
    _bloc.maintenanceModel = widget.maintenanceModel;

    if (widget.orderModel != null) {
      _bloc.finalMoney = widget.orderModel!.amount ?? 0;
      _bloc.paid = widget.orderModel!.payed ?? 0;
      _bloc.owed = widget.orderModel!.owed ?? 0;
    } else {
      _bloc.finalMoney = widget.maintenanceModel!.totalAmountPay ?? 0;
      _bloc.paid = widget.maintenanceModel!.totalAmountReceipt ?? 0;
      _bloc.owed = (widget.maintenanceModel!.totalAmountPay ?? 0) -
          (widget.maintenanceModel!.totalAmountReceipt ?? 0);
    }
    if (_bloc.owed < 0) {
      _bloc.owed = 0;
    }

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.onRefresh(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildHeader() {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        CustomRowInformation(
          title: AppLocalizations.text(LangKey.final_money),
          content: formatMoney(_bloc.finalMoney),
          contentStyle: AppTextStyles.style14BlackBold,
        ),
        CustomRowInformation(
          title: AppLocalizations.text(LangKey.paid),
          content: formatMoney(_bloc.paid),
          titleStyle: AppTextStyles.style14BlackNormal,
          contentStyle: AppTextStyles.style14PrimaryRegular,
        ),
        CustomRowInformation(
          title: AppLocalizations.text(LangKey.need_to_pay),
          content: formatMoney(_bloc.owed),
          titleStyle: AppTextStyles.style14BlackNormal,
          contentStyle: AppTextStyles.style14DarkRedBold,
        ),
      ],
    );
  }

  Widget _buildSkeleton() {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: List.generate(1, (index) => CustomColumnInformation()).toList(),
    );
  }

  Widget _buildItems(List<PaymentMethodResponseModel>? models) {
    return ContainerDataBuilder(
      data: models,
      skeletonBuilder: _buildSkeleton(),
      emptyPhysics: NeverScrollableScrollPhysics(),
      emptyShinkWrap: true,
      bodyBuilder: () => CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: models!
            .map((e) => CustomColumnInformation(
                  title: e.paymentMethodName ?? "",
                  titleStyle: AppTextStyles.style14BlackNormal,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                              child: CustomTextField(
                            controller: e.controller,
                            focusNode: e.node,
                            hintText:
                                AppLocalizations.text(LangKey.enter_amount),
                            suffixIcon: e.controller!.text.isNotEmpty
                                ? Assets.iconCloseCircle
                                : null,
                            backgroundColor: Colors.transparent,
                            borderColor: AppColors.borderColor,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              FormatNumberInputFormatter(
                                  AppFormat.quantityFormat),
                              LengthLimitingTextInputFormatter(11)
                            ],
                            onSuffixTap: () => e.controller!.clear(),
                          )),
                          SizedBox(
                            width: AppSizes.minPadding,
                          ),
                          InkWell(
                            child: CustomImageIcon(
                              icon: Assets.iconTrash,
                              color: AppColors.darkRedColor,
                            ),
                            onTap: () => _bloc.onPaymentMethodRemove(e),
                          )
                        ],
                      ),
                      if ((e.node?.hasFocus ?? false)) ...[
                        Container(
                          height: 5.0,
                        ),
                        Wrap(
                          spacing: AppSizes.minPadding,
                          runSpacing: AppSizes.minPadding,
                          children: _bloc
                              .getMoneySuggest(e)
                              .map((f) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomChip(
                                        text: formatMoney(f),
                                        backgroundColor: AppColors.primaryColor,
                                        style: AppTextStyles.style13WhiteNormal,
                                        onTap: () {
                                          e.controller!.text = formatMoney(f);
                                          e.controller!.selection =
                                              TextSelection.collapsed(
                                                  offset: e
                                                      .controller!.text.length);
                                        },
                                      )
                                    ],
                                  ))
                              .toList(),
                        )
                      ]
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildAmount(List<PaymentMethodResponseModel>? models) {
    double amount = _bloc.getAmount();
    double owed = _bloc.owed - amount;
    double cashReturn = amount - _bloc.owed;
    if (owed < 0) owed = 0;
    if (cashReturn < 0) cashReturn = 0;

    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        CustomRowInformation(
          title: AppLocalizations.text(LangKey.total_amount_you_pay),
          content: formatMoney(amount),
          titleStyle: AppTextStyles.style14BlackNormal,
          contentStyle: AppTextStyles.style14BlackBold,
        ),
        CustomRowInformation(
          title: AppLocalizations.text(LangKey.owed),
          content: formatMoney(owed),
          titleStyle: AppTextStyles.style14BlackNormal,
          contentStyle: AppTextStyles.style14BlackBold,
        ),
        CustomRowInformation(
          title: AppLocalizations.text(LangKey.cash_return),
          content: formatMoney(cashReturn),
          titleStyle: AppTextStyles.style14BlackNormal,
          contentStyle: AppTextStyles.style14BlackBold,
        ),
      ],
    );
  }

  Widget _buildMethod() {
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.payment_method),
      titleSuffix: Text(
        "+ ${AppLocalizations.text(LangKey.choose)}",
        style: AppTextStyles.style14PrimaryRegular,
        textAlign: TextAlign.right,
      ),
      onTitleTap: _bloc.onPaymentMethod,
      child: StreamBuilder(
          stream: _bloc.outputModels,
          initialData: _bloc.selectedModels,
          builder: (_, snapshot) {
            List<PaymentMethodResponseModel>? models =
                snapshot.data as List<PaymentMethodResponseModel>?;
            return CustomListView(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: [_buildItems(models), _buildAmount(models)],
            );
          }),
    );
  }

  Widget _buildNote() {
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.note),
      child: CustomTextField(
        controller: _bloc.controllerNote,
        focusNode: _bloc.focusNote,
        hintText: AppLocalizations.text(LangKey.add_note),
        textInputAction: TextInputAction.newline,
        keyboardType: TextInputType.multiline,
        backgroundColor: Colors.transparent,
        borderColor: AppColors.borderColor,
        maxLines: 3,
      ),
    );
  }

  Widget _buildImage() {
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.image),
      child: StreamBuilder(
          stream: _bloc.outputImages,
          initialData: _bloc.images,
          builder: (_, snapshot) {
            return CustomImageList(
              models: _bloc.images
                  .map((e) => CustomerOrderPhotoModel(url: e))
                  .toList(),
              onAdd: _bloc.onAddImage,
              onRemove: _bloc.onRemoveImage,
            );
          }),
    );
  }

  Widget _buildContent() {
    return CustomListView(
      separatorPadding: AppSizes.maxPadding,
      children: [
        _buildHeader(),
        _buildMethod(),
        _buildNote(),
        if(widget.orderModel != null)
          _buildImage(),
      ],
    );
  }

  Widget _buildBottom() {
    return CustomBottom(
      text: AppLocalizations.text(LangKey.payment),
      onTap: _bloc.onPayment,
      subText: AppLocalizations.text(LangKey.exit),
      onSubTap: _bloc.onExit,
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
      title: AppLocalizations.text(LangKey.payment),
      body: _buildBody(),
    );
  }
}
