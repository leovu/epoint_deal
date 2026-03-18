import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/order_detail_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_appbar.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_line.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';

import 'package:flutter/material.dart';

class OrderDetailScreen extends StatefulWidget {
  final int? id;
  final Function? onRefresh;

  const OrderDetailScreen({super.key, required this.id, this.onRefresh});

  @override
  OrderDetailScreenState createState() => OrderDetailScreenState();
}

class OrderDetailScreenState extends State<OrderDetailScreen> {
  late OrderDetailBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderDetailBloc(context);

    _bloc.id = widget.id;
    _bloc.onParentRefresh = widget.onRefresh;

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.onRefresh(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildHeader(OrderDetailResponseModel model) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomRowWithoutTitleInformation(
                icon: Assets.iconBarcode,
                text: model.orderCode ?? "",
                textStyle: AppTextStyles.style14BlackBold,
              ),
            ),
            CustomChip(
              text: model.processStatusName,
              backgroundColor: HexColor(model.processStatusColor),
              style: AppTextStyles.style12WhiteBold,
            )
          ],
        ),
        CustomRowWithoutTitleInformation(
          icon: Assets.iconClockFill,
          text: parseAndFormatDate(model.orderDate,
              format: AppFormat.formatDateTime),
        ),
        Row(
          children: [
            Expanded(
              child: CustomRowWithoutTitleInformation(
                icon: Assets.iconTagFill,
                text: hideMoney(model.amount,
                    checkVisibilityKey(VisibilityWidgetName.OD000009)),
                textStyle: AppTextStyles.style20PrimaryBold,
              ),
            ),
            if (isOrderPayment(model.receiptDetail, model.processStatus))
              CustomChip(
                text: AppLocalizations.text(LangKey.payment),
                style: AppTextStyles.style12WhiteBold,
                radius: 5.0,
                onTap: _bloc.onPayment,
              )
          ],
        ),
        CustomRowWithoutTitleInformation(
          icon: Assets.iconMarker,
          text: model.receiveAtCounter == 1
              ? AppLocalizations.text(LangKey.pick_up_at_the_counter)
              : "${AppLocalizations.text(LangKey.customer_address)} - ${model.typeShippingText ?? ""}",
        ),
      ],
    );
  }

  Widget _buildCustomer(OrderDetailResponseModel model) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        // CustomBookingCustomer(
        //   model: model.customer,
        //   onTap: _bloc.onCustomer,
        // ),
        if (model.receiveAtCounter == 0 && model.customerContactShipping != null)
          CustomColumnInformation(
            title: AppLocalizations.text(LangKey.delivery_information),
            child: CustomListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                CustomRowWithoutTitleInformation(
                  icon: Assets.iconUser,
                  text: model.customerContactShipping?.contactName,
                ),
                CustomRowWithoutTitleInformation(
                  icon: Assets.iconPhone,
                  text: model.customerContactShipping?.contactPhone,
                ),
                CustomRowWithoutTitleInformation(
                  icon: Assets.iconMarker,
                  text: model.customerContactShipping?.fullAddress,
                ),
              ],
            ),
          )
      ],
    );
  }

  Widget _buildNote(OrderDetailResponseModel model) {
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.note),
      child: (model.orderDescription ?? "").isEmpty
          ? Text(
              AppLocalizations.text(LangKey.data_empty)!,
              style: AppTextStyles.style14HintNormalItalic,
            )
          : null,
      content: model.orderDescription,
    );
  }

  Widget _buildItems(OrderDetailResponseModel model) {
    return CustomColumnInformation(
      title:
          "${AppLocalizations.text(LangKey.product)} / ${AppLocalizations.text(LangKey.service)}",
      child: CustomListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        separator: Padding(
          padding: EdgeInsets.symmetric(vertical: AppSizes.minPadding),
          child: CustomLine(),
        ),
        children: model.orderDetail?.map((e) => ContainerOrderDetail(
          staffModels: e.staffs,
          quantity: e.quantity,
          name: e.objectName,
          discount: e.discount,
          type: e.objectType,
          price: e.price,
          amount: e.amount,
          note: e.note,
        )).toList() ?? []
      )
    );
  }

  Widget _buildTotal(OrderDetailResponseModel model) {
    return CustomColumnInformation(
      title: "${AppLocalizations.text(LangKey.total)}: ${model.quantity}",
      titleSuffix: Text(
        hideMoney(
            model.total, checkVisibilityKey(VisibilityWidgetName.OD000009)),
        style: AppTextStyles.style14BlackNormal,
      ),
      child: CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          CustomRowInformation(
            icon: Assets.iconDiscountHand,
            title: AppLocalizations.text(LangKey.member_discount),
            content: hideMoney(model.discountMember,
                checkVisibilityKey(VisibilityWidgetName.OD000009)),
          ),
          CustomRowInformation(
            icon: Assets.iconTagPercent,
            title: AppLocalizations.text(LangKey.discount),
            content: hideMoney(model.discount,
                checkVisibilityKey(VisibilityWidgetName.OD000009)),
          ),
          if ((model.voucherCode ?? "").isNotEmpty)
            CustomRowInformation(
              icon: Assets.iconDiscountCode,
              title: AppLocalizations.text(LangKey.discount_code),
              content: model.voucherCode,
            ),
          CustomRowInformation(
            icon: Assets.iconTruck,
            title: AppLocalizations.text(LangKey.transport_fee),
            content: hideMoney(model.tranportCharge,
                checkVisibilityKey(VisibilityWidgetName.OD000009)),
          ),
          if (checkConfigKey(ConfigKey.receipt_other)) ...[
            CustomRowInformation(
              icon: Assets.iconMoneyOwed,
              title: AppLocalizations.text(LangKey.other_revenues),
              content: hideMoney(model.totalOtherFee,
                  checkVisibilityKey(VisibilityWidgetName.OD000009)),
            ),
            if ((model.otherFee?.length ?? 0) > 0)
              ...model.otherFee!
                  .map((e) => CustomRowInformation(
                title: e.otherFeeName,
                titleStyle: AppTextStyles.style14HintNormal,
                content: hideMoney(e.totalValue,
                    checkVisibilityKey(VisibilityWidgetName.OD000009)),
              ))
                  .toList()
          ],
          if (checkConfigKey(ConfigKey.vat)) ...[
            CustomRowInformation(
              icon: Assets.iconMoneySquare,
              title: AppLocalizations.text(LangKey.total_pre_tax_money),
              content: hideMoney(model.amountBeforeVat,
                  checkVisibilityKey(VisibilityWidgetName.OD000009)),
            ),
            CustomRowInformation(
              icon: Assets.iconTagPercent,
              title: AppLocalizations.text(LangKey.vat),
              content: hideMoney(model.totalTax,
                  checkVisibilityKey(VisibilityWidgetName.OD000009)),
            ),
          ],
          CustomRowInformation(
            icon: Assets.iconMoneySquare,
            title: AppLocalizations.text(LangKey.final_money),
            content: hideMoney(model.amount,
                checkVisibilityKey(VisibilityWidgetName.OD000009)),
            contentStyle: AppTextStyles.style14BlackBold,
          ),
          CustomRowInformation(
            icon: Assets.iconPaymentCard,
            title: AppLocalizations.text(LangKey.paid),
            content: hideMoney(
                model.payed, checkVisibilityKey(VisibilityWidgetName.OD000009)),
            contentStyle: AppTextStyles.style14PrimaryBold,
          ),
          CustomRowInformation(
            icon: Assets.iconMoneyOwed,
            title: AppLocalizations.text(LangKey.owed),
            content: hideMoney(
                model.owed, checkVisibilityKey(VisibilityWidgetName.OD000009)),
            contentStyle: AppTextStyles.style14DarkRedBold,
          ),
          if (isOrderPayment(model.receiptDetail, model.processStatus))
            CustomButton(
              borderColor: AppColors.primaryColor,
              backgroundColor: AppColors.whiteColor,
              style: AppTextStyles.style14PrimaryRegular,
              isIcon: true,
              icon: Assets.iconWalletOutline,
              iconColor: AppColors.primaryColor,
              text: AppLocalizations.text(LangKey.payment),
              onTap: _bloc.onPayment,
            )
        ],
      ),
    );
  }

  Widget _buildPayment(OrderDetailResponseModel model) {
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.payment_details),
      child: CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: model.receiptDetail!
            .map((e) => Row(
                  children: [
                    Text(
                      parseAndFormatDate(e.receiptDate,
                          format: AppFormat.formatDateTime),
                      style: AppTextStyles.style14BlackNormal,
                    ),
                    SizedBox(
                      width: AppSizes.minPadding,
                    ),
                    Expanded(
                        child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.borderColor),
                          borderRadius: BorderRadius.circular(5.0)),
                      padding: EdgeInsets.all(AppSizes.minPadding),
                      child: Row(
                        children: [
                          Expanded(
                              child: Text(
                            e.receiptType ?? "",
                            style: AppTextStyles.style14BlackNormal,
                          )),
                          SizedBox(
                            width: AppSizes.minPadding,
                          ),
                          Text(
                            hideMoney(
                                e.amount,
                                checkVisibilityKey(
                                    VisibilityWidgetName.OD000009)),
                            style: AppTextStyles.style14PrimaryRegular,
                          )
                        ],
                      ),
                    ))
                  ],
                ))
            .toList(),
      ),
    );
  }

  Widget _buildOthers(OrderDetailResponseModel model) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      children: [
        if(model.referId != null)
          // InkWell(
          //   child: CustomRowInformation(
          //     icon: Assets.iconUserStand,
          //     title: AppLocalizations.text(LangKey.presenter),
          //     content: model.referName,
          //   ),
          //   onTap: _bloc.onPresenter,
          // ),
        if(model.saleId != null)
          CustomRowInformation(
            icon: Assets.iconUserSetting,
            title: AppLocalizations.text(LangKey.business_staff),
            content: model.saleName,
          ),
        CustomRowInformation(
          icon: Assets.iconBranch,
          title: AppLocalizations.text(LangKey.branch),
          content: model.branchName,
        ),
        CustomRowInformation(
          icon: Assets.iconUserGroup,
          title: AppLocalizations.text(LangKey.order_source),
          content: model.orderSourceName,
        ),
        CustomRowInformation(
          icon: Assets.iconUserCreate,
          title: AppLocalizations.text(LangKey.creator),
          content: model.staffCreatedName,
        ),
        CustomRowInformation(
          icon: Assets.iconAddCalendar,
          title: AppLocalizations.text(LangKey.create_date),
          content: parseAndFormatDate(model.createdAt,
              format: AppFormat.formatDateTime),
        ),
        if ((model.updatedAt ?? "").isNotEmpty) ...[
          CustomRowInformation(
            icon: Assets.iconUserUpdate,
            title: AppLocalizations.text(LangKey.updater),
            content: model.staffUpdatedName,
          ),
          CustomRowInformation(
            icon: Assets.iconClockUpdate,
            title: AppLocalizations.text(LangKey.update_day),
            content: parseAndFormatDate(model.updatedAt,
                format: AppFormat.formatDateTime),
          ),
        ],
      ],
    );
  }

  Widget _buildContent(OrderDetailResponseModel model) {
    return CustomListView(
      separatorPadding: AppSizes.maxPadding,
      children: [
        _buildHeader(model),
        _buildCustomer(model),
        _buildNote(model),
        _buildItems(model),
        _buildTotal(model),
        if ((model.receiptDetail?.length ?? 0) != 0) _buildPayment(model),
        _buildOthers(model),
      ],
      onRefresh: _bloc.onRefresh,
    );
  }

  Widget _buildBottom(OrderDetailResponseModel model) {
    return CustomBottom(
      text:
          model.isEdit == 1 ? AppLocalizations.text(LangKey.edit_order) : null,
      onTap: _bloc.onEdit,
      subText: model.isRemove == 1
          ? AppLocalizations.text(LangKey.delete_order)
          : model.isCancel == 1
              ? AppLocalizations.text(LangKey.cancel_order)
              : null,
      onSubTap: () {
        if (model.isRemove == 1) {
          _bloc.onRemove();
        } else {
          _bloc.onCancel();
        }
      },
    );
  }

  Widget _buildSkeleton() {
    return Container(
      padding: EdgeInsets.all(AppSizes.maxPadding),
      child: CustomShimmer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSkeleton(),
            SizedBox(
              height: AppSizes.minPadding,
            ),
            CustomSkeleton(),
            SizedBox(
              height: AppSizes.minPadding,
            ),
            CustomSkeleton(
              width: AppSizes.maxWidth! / 2,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(OrderDetailResponseModel? model) {
    return ContainerDataBuilder(
      data: model,
      skeletonBuilder: _buildSkeleton(),
      bodyBuilder: () => Column(
        children: [
          Expanded(child: _buildContent(model!)),
          if (model.isEdit == 1 || model.isRemove == 1 || model.isCancel == 1)
            _buildBottom(model)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.outputModel,
        initialData: null,
        builder: (_, snapshot) {
          OrderDetailResponseModel? model =
              snapshot.data as OrderDetailResponseModel?;
          if (model?.orderId != null && _bloc.options == null) {
            _bloc.options = [
              if (checkVisibilityKey(VisibilityWidgetName.OD000007) &&
                  checkVisibilityKey(VisibilityWidgetName.OD000008))
                CustomOptionAppBar(
                    icon: Assets.iconUpload, onTap: _bloc.onUpload),
              CustomOptionAppBar(
                  icon: Assets.iconPrinter, onTap: _bloc.onPrinter)
            ];
          }
          return CustomScaffold(
            title: AppLocalizations.text(LangKey.order_details),
            body: _buildBody(model),
            options: _bloc.options,
          );
        });
  }
}
