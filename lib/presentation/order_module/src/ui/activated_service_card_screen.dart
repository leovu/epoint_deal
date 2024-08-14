import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/branch_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/activated_service_card_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/maximum_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ActivatedServiceCardScreen extends StatefulWidget {
  final ServiceCardModel model;
  final BranchModel? branchModel;
  final bool isBooking;

  const ActivatedServiceCardScreen(
      {super.key,
      required this.model,
      this.branchModel,
      this.isBooking = false});

  @override
  ActivatedServiceCardScreenState createState() =>
      ActivatedServiceCardScreenState();
}

class ActivatedServiceCardScreenState
    extends State<ActivatedServiceCardScreen> {
  late ActivatedServiceCardBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ActivatedServiceCardBloc(context);

    _bloc.model = widget.model;
    _bloc.remainAmount = widget.model.remainAmount ?? 0;
    _bloc.isBooking = widget.isBooking;
    if (widget.branchModel != null) {
      _bloc.branchModel = widget.branchModel!;
    }

    if (widget.model.quantity != null) {
      _bloc.controllerQuantity.text = widget.model.quantity!.toInt().toString();
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

    if (_bloc.staffModels != null) {
      widget.model.staffModels = _bloc.staffModels;
    }

    widget.model.note = _bloc.controllerNote.text;

    widget.model.roomModel = _bloc.roomModel;

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
          widget.model.cardCode ?? "",
          style: AppTextStyles.style14HintNormal,
        ),
        Text.rich(TextSpan(
            text:
                "${AppLocalizations.text(LangKey.number_of_uses_remaining)}: ",
            style: AppTextStyles.style14BlackNormal,
            children: [
              TextSpan(
                  text: _bloc.remainAmount.toString(),
                  style: AppTextStyles.style14DarkRedBold)
            ]))
      ],
    );
  }

  Widget _buildPrice() {
    return CustomRowInformation(
      icon: Assets.iconTagFill,
      title: AppLocalizations.text(LangKey.number_of_uses),
      child: CustomQuantity(
        focusNode: _bloc.focusQuantity,
        controller: _bloc.controllerQuantity,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          MaximumNumberInputFormatter(_bloc.remainAmount)
        ],
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
        _buildPrice(),
        _buildStaffs(),
        if (_bloc.isBooking) _buildRoom(),
        _buildNote()
      ],
      onRefresh: _onRefresh,
    );
  }

  Widget _buildBottom() {
    return CustomBottom(
      text: AppLocalizations.text(LangKey.confirm),
      onTap: _onConfirm,
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
      title: AppLocalizations.text(LangKey.service_card_activated),
      body: _buildBody(),
    );
  }
}
