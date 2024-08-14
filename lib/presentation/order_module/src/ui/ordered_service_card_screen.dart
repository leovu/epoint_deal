
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/response/branch_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/ordered_service_card_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class OrderedServiceCardScreen extends StatefulWidget {
  final OrderServiceCardModel model;
  final CustomerModel? customerModel;
  final BranchModel? branchModel;
  final bool isBooking;

  const OrderedServiceCardScreen(
      {super.key,
      required this.model,
      this.customerModel,
      this.branchModel,
      this.isBooking = false});

  @override
  OrderedServiceCardScreenState createState() =>
      OrderedServiceCardScreenState();
}

class OrderedServiceCardScreenState extends State<OrderedServiceCardScreen> {
  late OrderedServiceCardBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderedServiceCardBloc(context);

    _bloc.model = widget.model;
    _bloc.customerModel = widget.customerModel;
    _bloc.isBooking = widget.isBooking;
    if (widget.branchModel != null) {
      _bloc.branchModel = widget.branchModel!;
    }

    if (widget.model.quantity != null) {
      _bloc.controllerQuantity.text = formatMoney(widget.model.quantity);
    }
    if (widget.model.changePrice != null) {
      _bloc.controllerPrice.text = formatMoney(widget.model.changePrice);
    }
    if (widget.model.voucherModel != null) {
      _bloc.voucherModel = widget.model.voucherModel;
      _bloc.controllerDiscount.text = formatMoney(getDiscount(
          _bloc.voucherModel,
          total: parseMoney(_bloc.controllerPrice.text,
                  defaultValue: widget.model.price) *
              parseMoney(_bloc.controllerQuantity.text,
                  defaultValue: defaultCartQuantity)));
    }
    if (widget.model.surcharge != null) {
      _bloc.controllerSurcharge.text = formatMoney(widget.model.surcharge);
    }
    _bloc.staffModels = widget.model.staffModels;
    if (widget.model.roomModel != null) {
      _bloc.initRoom = widget.model.roomModel!.id;
    }
    if (widget.model.note != null) {
      _bloc.controllerNote.text = widget.model.note!;
    }

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _onRefresh(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  Future _onRefresh({bool isRefresh = true}) {
    final group = <Future>[];
    if (_bloc.isBooking) group.add(_bloc.getRoom(isRefresh));
    return Future.wait(group);
  }

  _onConfirm() {
    if (_bloc.controllerQuantity.text.isEmpty) {
      widget.model.quantity = null;
    } else {
      widget.model.quantity = parseMoney(_bloc.controllerQuantity.text);
    }

    if (_bloc.controllerPrice.text.isEmpty) {
      widget.model.changePrice = null;
    } else {
      widget.model.changePrice = parseMoney(_bloc.controllerPrice.text);
    }

    widget.model.voucherModel = _bloc.voucherModel;

    if (_bloc.controllerSurcharge.text.isEmpty) {
      widget.model.surcharge = null;
    } else {
      widget.model.surcharge = parseMoney(_bloc.controllerSurcharge.text);
    }

    if (_bloc.staffModels != null) {
      widget.model.staffModels = _bloc.staffModels;
    }

    widget.model.note = _bloc.controllerNote.text;

    widget.model.roomModel = _bloc.roomModel;

    if (widget.model.voucherModel != null) {
      widget.model.discount = getDiscount(widget.model.voucherModel,
          total: (widget.model.changePrice ?? widget.model.price ?? 0.0) *
              (widget.model.quantity ?? defaultCartQuantity));
    } else {
      widget.model.discount = null;
    }

    CustomNavigator.pop(context, object: true);
  }

  Widget _buildInfo() {
    return CustomListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        Text(
          widget.model.name ?? "",
          style: AppTextStyles.style14BlackBold,
        ),
        Text(
          widget.model.code ?? "",
          style: AppTextStyles.style14HintNormal,
        ),
        Text(
          formatMoney(widget.model.price),
          style: AppTextStyles.style14BlackNormal,
        )
      ],
    );
  }

  Widget _buildQuantity() {
    return CustomRowInformation(
      icon: Assets.iconQuantity,
      title: AppLocalizations.text(LangKey.quantity),
      child: CustomQuantity(
        focusNode: _bloc.focusQuantity,
        controller: _bloc.controllerQuantity,
        onChanged: (_) => _bloc.removeVoucher(),
      ),
    );
  }

  Widget _buildPrice() {
    return CustomRowInformation(
      icon: Assets.iconTagFill,
      title: AppLocalizations.text(LangKey.price),
      child: CustomPrice(
        focusNode: _bloc.focusPrice,
        controller: _bloc.controllerPrice,
        newPrice: widget.model.price,
        onChanged: (_) => _bloc.removeVoucher(),
      ),
    );
  }

  Widget _buildDiscount() {
    return StreamBuilder(
        stream: _bloc.outputVoucherModel,
        initialData: _bloc.voucherModel,
        builder: (_, snapshot) {
          DiscountCartModel? model = snapshot.data as DiscountCartModel?;
          return CustomBookingDiscount(
              model: model,
              focusNode: _bloc.focusDiscount,
              controller: _bloc.controllerDiscount,
              onChoose: _bloc.chooseVoucher,
              onRemove: _bloc.removeVoucher);
        });
  }

  Widget _buildSurcharge() {
    return CustomRowInformation(
      icon: Assets.iconTagAdd,
      title: AppLocalizations.text(LangKey.surcharge),
      child: CustomPrice(
        focusNode: _bloc.focusSurcharge,
        controller: _bloc.controllerSurcharge,
        hint: AppLocalizations.text(LangKey.enter_amount),
        onChanged: (_) => _bloc.setVoucherModel(_bloc.voucherModel),
      ),
    );
  }

  Widget _buildStaffs() {
    return CustomColumnInformation(
        title: AppLocalizations.text(LangKey.staff_1),
        child: Column(
          children: [
            CustomTextField(
              backgroundColor: Colors.transparent,
              borderColor: AppColors.borderColor,
              readOnly: true,
              hintText:
                  "${AppLocalizations.text(LangKey.choose)} ${AppLocalizations.text(LangKey.staff)!.toLowerCase()}",
              suffixIconData: Icons.navigate_next,
              onTap: _bloc.pushStaff,
            ),
            StreamBuilder(
                stream: _bloc.outputStaffModels,
                initialData: _bloc.staffModels,
                builder: (_, snapshot) {
                  if ((_bloc.staffModels?.length ?? 0) == 0) {
                    return Container();
                  }
                  return Container(
                    padding: EdgeInsets.only(top: AppSizes.minPadding),
                    alignment: Alignment.centerLeft,
                    child: Wrap(
                      spacing: AppSizes.minPadding,
                      runSpacing: AppSizes.minPadding,
                      children: _bloc.staffModels!
                          .map((e) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomChip(
                                    radius: 5.0,
                                    backgroundColor: AppColors.greyC4Color,
                                    text: e.fullName,
                                    style: AppTextStyles.style13WhiteNormal,
                                    onClose: () => _bloc.deleteStaff(e),
                                  )
                                ],
                              ))
                          .toList(),
                    ),
                  );
                })
          ],
        ));
  }

  Widget _buildRoom() {
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.room),
      child: StreamBuilder(
          stream: _bloc.outputRoomModels,
          initialData: _bloc.roomModel,
          builder: (_, snapshot) {
            if (snapshot.hasError) {
              return CustomErrorText(snapshot.error as String?);
            }

            List<CustomDropdownModel>? models =
            snapshot.data as List<CustomDropdownModel>?;

            return StreamBuilder(
                stream: _bloc.outputRoomModel,
                initialData: null,
                builder: (_, snapshot) {
                  CustomDropdownModel? model =
                  snapshot.data as CustomDropdownModel?;
                  return CustomDropdown(
                    value: model,
                    menus: models,
                    hint: AppLocalizations.text(LangKey.room),
                    icon: Assets.iconRoom,
                    onChanged: (event) => _bloc.selectRoom(event),
                  );
                });
          }),
    );
  }

  Widget _buildNote() {
    return CustomColumnInformation(
        title: AppLocalizations.text(LangKey.note),
        child: CustomTextField(
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

  Widget _buildContent() {
    return CustomListView(
      children: [
        _buildInfo(),
        _buildQuantity(),
        _buildPrice(),
        if (checkConfigKey(ConfigKey.discount)) _buildDiscount(),
        // _buildSurcharge(),
        _buildStaffs(),
        if (_bloc.isBooking) _buildRoom(),
        _buildNote()
      ],
      onRefresh: _onRefresh,
    );
  }

  Widget _buildBottom() {
    return StreamBuilder(
        stream: _bloc.outputVoucherModel,
        initialData: _bloc.voucherModel,
        builder: (_, snapshot) {
          DiscountCartModel? model = snapshot.data as DiscountCartModel?;
          double amount = parseMoney(_bloc.controllerPrice.text,
              defaultValue: widget.model.price);
          double quantity = parseMoney(_bloc.controllerQuantity.text,
              defaultValue: defaultCartQuantity);
          double total = amount * quantity;
          double discount = getDiscount(model, total: total);
          double surcharge = parseMoney(_bloc.controllerSurcharge.text);
          return CustomBottomBooking(
            value: getBookingAmount(total, discount, surcharge),
            showLength: false,
            onTap: _onConfirm,
          );
        });
  }

  Widget _buildBody() {
    return Column(
      children: [Expanded(child: _buildContent()), _buildBottom()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.ordered_service_card),
      body: _buildBody(),
    );
  }
}
