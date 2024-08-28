
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/booking_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/member_discount_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/transport_method_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/order_create_bloc.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class OrderCreateScreen extends StatefulWidget {
  final OrderDetailResponseModel? model;
  final List<ProductNewModel>? productNewModels;
  final List<ServiceNewModel>? serviceNewModels;
  final List<OrderServiceCardModel>? serviceCardModels;
  final List<ServiceCardModel>? serviceCardActivatedModels;
  final CustomerModel? customerModel;
  final DeliveryAddress? deliveryAddressModel;
  final BookingDetailResponseModel? bookingModel;

  OrderCreateScreen(
      {this.model,
      this.productNewModels,
      this.serviceNewModels,
      this.serviceCardModels,
      this.serviceCardActivatedModels,
      this.customerModel,
      this.deliveryAddressModel,
      this.bookingModel});

  @override
  OrderCreateScreenState createState() => OrderCreateScreenState();
}

class OrderCreateScreenState extends State<OrderCreateScreen> {
  late OrderCreateBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Globals.cart = GlobalCart();
    _bloc = OrderCreateBloc(
        context,
        widget.model,
        widget.productNewModels,
        widget.serviceNewModels,
        widget.serviceCardModels,
        widget.serviceCardActivatedModels,
        widget.customerModel,
        widget.deliveryAddressModel);

    _bloc.bookingModel = widget.bookingModel;

    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => _bloc.onRefresh(isRefresh: false, isInit: true));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    Globals.cart?.dispose();
    Globals.cart = null;
    super.dispose();
  }

  Widget _buildTitle(String? title, Widget child,
      {bool isRequired = false,
      Widget? suffix,
      String? content,
      GestureTapCallback? onTap}) {
    return CustomColumnInformation(
      title: title,
      child: child,
      isRequired: isRequired,
      titleSuffix: suffix ??
          (content != null
              ? Text(
                  "+ $content",
                  style: AppTextStyles.style14PrimaryRegular,
                  textAlign: TextAlign.right,
                )
              : null),
      onTitleTap: onTap,
    );
  }

  Widget _buildCustomer(CustomerModel? model) {
    return _buildTitle(
        AppLocalizations.text(LangKey.customer_information),
        CustomBookingCustomer(
          model: model,
          onRemove: _bloc.isEdit ? null : _bloc.removeCustomer,
        ),
        content: _bloc.isEdit
            ? null
            : AppLocalizations.text(
                model == null ? LangKey.choose : LangKey.update),
        isRequired: true,
        onTap: _bloc.isEdit ? null : _bloc.chooseCustomer);
  }

  Widget _buildItems() {
    return StreamBuilder(
        stream: _bloc.outputProductModels,
        initialData: Globals.cart!.products,
        builder: (_, snapshot) {
          List<ProductNewModel>? productModels =
              snapshot.data as List<ProductNewModel>?;
          return StreamBuilder(
              stream: _bloc.outputServiceModels,
              initialData: Globals.cart!.services,
              builder: (_, snapshot) {
                List<ServiceNewModel>? serviceModels =
                    snapshot.data as List<ServiceNewModel>?;

                return StreamBuilder(
                    stream: _bloc.outputServiceCardModels,
                    initialData: Globals.cart!.serviceCards,
                    builder: (_, snapshot) {
                      List<OrderServiceCardModel>? serviceCardModels =
                          snapshot.data as List<OrderServiceCardModel>?;

                      return StreamBuilder(
                          stream: _bloc.outputServiceCardActivatedModels,
                          initialData: Globals.cart!.serviceActivatedCards,
                          builder: (_, snapshot) {
                            List<ServiceCardModel>? serviceCardActivatedModels =
                                snapshot.data as List<ServiceCardModel>?;

                            return _buildTitle(
                                "${AppLocalizations.text(LangKey.product)} / ${AppLocalizations.text(LangKey.service)}",
                                ContainerItemsOrder(
                                  productModels: productModels,
                                  serviceModels: serviceModels,
                                  serviceCardModels: serviceCardModels,
                                  serviceCardActivatedModels:
                                      serviceCardActivatedModels,
                                  onProductTap: _bloc.onProductTap,
                                  onServiceTap: _bloc.onServiceTap,
                                  onServiceCardTap: _bloc.onServiceCardTap,
                                  onServiceCardActivatedTap:
                                      _bloc.onServiceCardActivatedTap,
                                  onProductDelete: _bloc.onProductRemove,
                                  onServiceDelete: _bloc.onServiceRemove,
                                  onServiceCardDelete:
                                      _bloc.onServiceCardRemove,
                                  onServiceCardActivatedDelete:
                                      _bloc.onServiceCardActivatedRemove,
                                ),
                                content: AppLocalizations.text(
                                    (productModels?.length ??
                                                serviceModels?.length ??
                                                serviceCardModels?.length ??
                                                serviceCardActivatedModels
                                                    ?.length ??
                                                0) ==
                                            0
                                        ? LangKey.add
                                        : LangKey.update),
                                onTap: _bloc.onAddItems);
                          });
                    });
              });
        });
  }

  Widget _buildDateTime() {
    return _buildTitle(
        AppLocalizations.text(LangKey.time),
        CustomTextField(
          focusNode: _bloc.focusDate,
          controller: _bloc.controllerDate,
          readOnly: true,
          backgroundColor: Colors.transparent,
          borderColor: AppColors.borderColor,
          suffixIcon: Assets.iconCalendar,
          onTap: () => _bloc.showDateTime(_bloc.controllerDate),
        ),
        isRequired: true);
  }

  Widget _buildNote() {
    return _buildTitle(
        AppLocalizations.text(LangKey.note),
        CustomTextField(
          focusNode: _bloc.focusNote,
          controller: _bloc.controllerNote,
          hintText: AppLocalizations.text(LangKey.note_information),
          maxLines: 4,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          backgroundColor: Colors.transparent,
          borderColor: AppColors.borderColor,
        ));
  }

  Widget _buildDeliveryAddress() {
    return StreamBuilder(
        stream: _bloc.outputDeliveryAddressModel,
        initialData: _bloc.deliveryAddressModel,
        builder: (_, snapshot) {
          DeliveryAddress? model = snapshot.data as DeliveryAddress?;
          return _buildTitle(
              AppLocalizations.text(LangKey.delivery_information),
              model == null
                  ? Text(
                      AppLocalizations.text(LangKey.data_empty)!,
                      style: AppTextStyles.style14HintNormalItalic,
                    )
                  : Row(
                      children: [
                        Expanded(
                            child: CustomListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          children: [
                            CustomRowWithoutTitleInformation(
                              icon: Assets.iconUser,
                              text: model.contactName,
                            ),
                            CustomRowWithoutTitleInformation(
                              icon: Assets.iconPhone,
                              text: model.contactPhone,
                            ),
                            CustomRowWithoutTitleInformation(
                              icon: Assets.iconMarker,
                              text: model.fullAddress,
                            ),
                          ],
                        )),
                        SizedBox(
                          width: AppSizes.minPadding,
                        ),
                        InkWell(
                          child: CustomImageIcon(
                            icon: Assets.iconTrash,
                            color: AppColors.red500,
                          ),
                          onTap: _bloc.clearDeliveryAddress,
                        )
                      ],
                    ),
              content: AppLocalizations.text(
                  model == null ? LangKey.choose : LangKey.update),
              isRequired: true,
              onTap: _bloc.chooseDeliveryAddress);
        });
  }

  Widget _buildTransportMethod() {
    return StreamBuilder(
        stream: _bloc.outputTransportMethodModels,
        initialData: <TransportMethodModel>[],
        builder: (_, snapshot) {
          if (snapshot.hasError) {
            return CustomErrorText(snapshot.error as String?);
          }

          List<TransportMethodModel>? models =
              snapshot.data as List<TransportMethodModel>?;
          return ContainerTransportMethod(
            models: models,
            currentModel: _bloc.transportModel,
            onTap: (event) => _bloc.selectTransportMethod(models, event),
          );
        });
  }

  Widget _buildType() {
    return StreamBuilder(
        stream: _bloc.outputIsAtStore,
        initialData: _bloc.isAtStore,
        builder: (_, snapshot) {
          bool atStore = snapshot.data as bool;
          return CustomListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              CustomTypeBooking(
                value: atStore,
                text1: AppLocalizations.text(LangKey.at_the_counter),
                text2: AppLocalizations.text(LangKey.at_the_address),
                onChanged: _bloc.onType,
              ),
              if (!atStore) ...[
                _buildDeliveryAddress(),
                _buildTransportMethod()
              ]
            ],
          );
        });
  }

  Widget _buildAmount() {
    return CustomRowInformation(
      icon: Assets.iconTagFill,
      titleWidget: Text.rich(TextSpan(
          text: "${AppLocalizations.text(LangKey.total_quantity)}: ",
          style: AppTextStyles.style14BlackNormal,
          children: [
            TextSpan(
                text: Globals.cart!.getQuantity().toString(),
                style: AppTextStyles.style14PrimaryBold)
          ])),
      content: formatMoney(_bloc.total),
      contentStyle: AppTextStyles.style14BlackBold,
    );
  }

  Widget _buildMemberDiscount() {
    return CustomRowInformation(
      icon: Assets.iconDiscountHand,
      title: AppLocalizations.text(LangKey.member_discount),
      titleStyle: AppTextStyles.style14BlackNormal,
      child: _bloc.discountMemberHasError
          ? CustomErrorText(
              _bloc.discountMemberError as String?,
              textAlign: TextAlign.right,
            )
          : _bloc.discountMemberModel == null
              ? CustomShimmer(
                  child: CustomSkeleton(),
                )
              : null,
      content: formatMoney(_bloc.discountMember),
    );
  }

  Widget _buildDiscount() {
    return CustomBookingDiscount(
        model: _bloc.voucherModel,
        focusNode: _bloc.focusDiscount,
        controller: _bloc.controllerDiscount,
        onChoose: _bloc.chooseVoucher,
        onRemove: _bloc.removeVoucher);
  }

  Widget _buildSurcharge() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.other_revenues),
      icon: Assets.iconMoneyOwed,
      titleStyle: AppTextStyles.style14BlackNormal,
      child: InkWell(
          child: CustomDropdown(
            isText: true,
            hint: AppLocalizations.text(LangKey.apply_other_revenues),
            value: _bloc.surcharge == 0.0
                ? null
                : CustomDropdownModel(text: formatMoney(_bloc.surcharge)),
            isHint: _bloc.surcharge == 0.0,
            menus: [CustomDropdownModel()],
            showIcon: true,
            suffixIcon: Icons.navigate_next,
            onRemove: _bloc.onRemoveSurcharge,
          ),
          onTap: _bloc.otherFreeBranch),
    );
  }

  Widget _buildTotalPreTax() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.total_pre_tax_money),
      content: formatMoney(_bloc.amountBeforeTax),
      contentStyle: AppTextStyles.style14BlackBold,
    );
  }

  Widget _buildVAT() {
    return CustomRowInformation(
      icon: Assets.iconTagPercent,
      title: AppLocalizations.text(LangKey.vat),
      titleStyle: AppTextStyles.style14BlackNormal,
      child: StreamBuilder(
          stream: _bloc.outputVATModels,
          initialData: _bloc.vatModels,
          builder: (_, snapshot) {
            return CustomDropdown(
              value: _bloc.vatModel,
              menus: _bloc.vatModels,
              hint: "${formatMoney(_bloc.vatDefault)}%",
              onChanged: (event) => _bloc.onSelectVAT(event),
              onRemove: _bloc.onRemoveVAT,
            );
          }),
    );
  }

  Widget _buildPresenter() {
    return StreamBuilder(
        stream: _bloc.outputPresenterModel,
        initialData: _bloc.presenterModel,
        builder: (_, snapshot) {
          CustomerModel? model = snapshot.data as CustomerModel?;
          return CustomTextField(
            focusNode: _bloc.focusPresenter,
            controller: _bloc.controllerPresenter,
            readOnly: true,
            backgroundColor: Colors.transparent,
            borderColor: AppColors.borderColor,
            hintText:
                "${AppLocalizations.text(LangKey.choose)} ${AppLocalizations.text(LangKey.presenter)!.toLowerCase()}",
            suffixIconData: model == null ? Icons.navigate_next : null,
            suffixIcon: model == null ? null : Assets.iconTrash,
            onSuffixTap: model == null
                ? _bloc.onChoosePresenter
                : _bloc.onDeletePresenter,
            onTap: _bloc.onChoosePresenter,
          );
        });
  }

  Widget _buildStaff() {
    return StreamBuilder(
        stream: _bloc.outputStaffModel,
        initialData: _bloc.staffModel,
        builder: (_, snapshot) {
          BookingStaffModel? model = snapshot.data as BookingStaffModel?;
          return CustomTextField(
            focusNode: _bloc.focusStaff,
            controller: _bloc.controllerStaff,
            readOnly: true,
            backgroundColor: Colors.transparent,
            borderColor: AppColors.borderColor,
            hintText:
                "${AppLocalizations.text(LangKey.choose)} ${AppLocalizations.text(LangKey.business_staff)!.toLowerCase()}",
            suffixIconData: model == null ? Icons.navigate_next : null,
            suffixIcon: model == null ? null : Assets.iconTrash,
            onSuffixTap:
                model == null ? _bloc.onChooseStaff : _bloc.onDeleteStaff,
            onTap: _bloc.onChooseStaff,
          );
        });
  }

  Widget _buildOthers() {
    return _buildTitle(
        AppLocalizations.text(LangKey.other),
        CustomListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            // if(_bloc.isEdit)
            //   _buildStatus(),
            _buildPresenter(),
            _buildStaff()
          ],
        ));
  }

  Widget _buildContent() {
    return StreamBuilder(
        stream: _bloc.outputCustomerModel,
        initialData: _bloc.customerModel,
        builder: (_, snapshot) {
          CustomerModel? model = snapshot.data as CustomerModel?;
          return CustomListView(
            separatorPadding: AppSizes.maxPadding,
            children: [
              _buildCustomer(model),
              _buildDateTime(),
              _buildNote(),
              _buildItems(),
              _buildType(),
              _buildAmount(),
              if (checkConfigKey(ConfigKey.discount_order_member))
                _buildMemberDiscount(),
               _buildDiscount(),
              if (checkConfigKey(ConfigKey.receipt_other)) _buildSurcharge(),
              if (checkConfigKey(ConfigKey.vat)) ...[
                _buildTotalPreTax(),
                _buildVAT(),
              ],
              _buildOthers(),
            ],
            onRefresh: _bloc.onRefresh,
          );
        });
  }

  Widget _buildTotal() {
    return Row(
      children: [
        Text(
          AppLocalizations.text(LangKey.need_to_pay)!,
          style: AppTextStyles.style12HintNormal,
          textAlign: TextAlign.right,
        ),
        SizedBox(
          width: AppSizes.minPadding,
        ),
        Expanded(
            child: Text(
          formatMoney(_bloc.amount),
          style: AppTextStyles.style14PrimaryBold,
          textAlign: TextAlign.right,
        ))
      ],
    );
  }

  Widget _buildBottom() {
    return (Globals.cart != null) ?
                  StreamBuilder(
                      stream: Globals.cart!.outputValue,
                      initialData: 0.0,
                      builder: (_, snapshot) {
                        double? event = (snapshot.data as double?) ?? 0.0;
                        return CustomBottomBooking(
                          onTap: () => CustomNavigator.pop(context, object: true),
                            value: event, length: Globals.cart!.getQuantity());
                      }) : SizedBox();
  }

  Widget _buildBody() {
    return StreamBuilder(
        stream: Globals.cart!.outputValue,
        initialData: _bloc.total,
        builder: (_, snapshot) {
          _bloc.total = (snapshot.data as double?) ?? 0.0;
          return StreamBuilder(
              stream: _bloc.outputMemberDiscountModel,
              initialData: _bloc.defaultDiscountMemberModel,
              builder: (_, snapshot) {
                _bloc.discountMemberHasError = snapshot.hasError;
                _bloc.discountMemberError = snapshot.error;
                _bloc.discountMemberModel =
                    snapshot.data as MemberDiscountResponseModel?;
                _bloc.discountMember = double.tryParse(
                        _bloc.discountMemberModel?.discountMember ?? "0") ??
                    0.0;
                return StreamBuilder(
                    stream: _bloc.outputVATModel,
                    initialData: _bloc.vatModel,
                    builder: (_, snapshot) {
                      return StreamBuilder(
                          stream: _bloc.outputTransportCharge,
                          initialData: _bloc.transportCharge,
                          builder: (_, snapshot) {
                            return StreamBuilder(
                                stream: _bloc.outputSurchargeModels,
                                initialData: _bloc.surchargeModels,
                                builder: (_, snapshot) {
                                  _bloc.surcharge =
                                      _bloc.getSurcharge(_bloc.total);
                                  return StreamBuilder(
                                      stream: _bloc.outputVoucherModel,
                                      initialData: _bloc.voucherModel,
                                      builder: (_, snapshot) {
                                        _bloc.discount = 0.0;
                                        if (_bloc.voucherModel != null) {
                                          _bloc.discount = getDiscount(
                                              _bloc.voucherModel,
                                              total: _bloc.total);
                                        }
                                        _bloc.amount = _bloc.total -
                                            _bloc.discount -
                                            _bloc.discountMember +
                                            (_bloc.transportCharge ?? 0.0) +
                                            _bloc.surcharge;

                                        if (_bloc.amount < 0) {
                                          _bloc.amount = 0;
                                        }

                                        if (checkConfigKey(ConfigKey.vat)) {
                                          double vat = _bloc.vatModel == null
                                              ? _bloc.vatDefault
                                              : _bloc.vatModel!.data;
                                          _bloc.totalTax =
                                              vat / 100 * _bloc.amount;
                                          if (_bloc.vatIncluded) {
                                            _bloc.amountBeforeTax =
                                                _bloc.amount - _bloc.totalTax;
                                          } else {
                                            _bloc.amountBeforeTax =
                                                _bloc.amount;
                                            _bloc.amount = _bloc.totalTax +
                                                _bloc.amountBeforeTax;
                                          }
                                        } else {
                                          _bloc.amountBeforeTax = _bloc.amount;
                                        }

                                        return Column(
                                          children: [
                                            Expanded(child: _buildContent()),
                                            _buildBottom(),
                                          ],
                                        );
                                      });
                                });
                          });
                    });
              });
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(
          _bloc.isEdit ? LangKey.edit_order : LangKey.order_1),
      body: _buildBody(),
      onWillPop: _bloc.pop,
    );
  }
}
