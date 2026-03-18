
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/other_free_branch_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/booking_surcharge_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_checkbox.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/format_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/maximum_number_input_formatter.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BookingSurchargeScreen extends StatefulWidget {
  final List<OtherFreeBranchModel> models;

  const BookingSurchargeScreen({super.key, required this.models});

  @override
  BookingSurchargeScreenState createState() => BookingSurchargeScreenState();
}

class BookingSurchargeScreenState extends State<BookingSurchargeScreen> {
  late BookingSurchargeBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = BookingSurchargeBloc(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildType(String image, bool isSelected, GestureTapCallback onTap) {
    return GestureDetector(
      child: Container(
        width: AppSizes.sizeOnTap,
        height: AppSizes.sizeOnTap,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
                color:
                    isSelected ? AppColors.primaryColor : Colors.transparent)),
        alignment: Alignment.center,
        child: Image.asset(
          image,
          width: AppSizes.iconSize,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildItem(OtherFreeBranchModel model) {
    return ContainerBooking(
      CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.only(
            right: AppSizes.minPadding, bottom: AppSizes.minPadding),
        children: [
          Row(
            children: [
              CustomCheckbox(model.isSelected,
                  (event) => _bloc.onChange(model, widget.models)),
              Expanded(
                  child: Text(
                model.otherFeeName ?? "",
                style: AppTextStyles.style14PrimaryBold,
              ))
            ],
          ),
          Padding(
              padding: EdgeInsets.only(left: AppSizes.minPadding),
              child: Row(children: [
                _buildType(Assets.imageDiscountCash, model.isMoney,
                    () => _bloc.onTypeChange(model, widget.models)),
                SizedBox(
                  width: 1.0,
                ),
                _buildType(Assets.imageDiscountDirect, !model.isMoney,
                    () => _bloc.onTypeChange(model, widget.models)),
                SizedBox(
                  width: 1.0,
                ),
                Expanded(
                    child: CustomTextField(
                  focusNode: model.focusNode,
                  controller: model.controller,
                  hintText: AppLocalizations.text(model.isMoney
                      ? LangKey.enter_amount
                      : LangKey.enter_percentage),
                  keyboardType: TextInputType.number,
                  inputFormatters: model.isMoney
                      ? [
                          FilteringTextInputFormatter.digitsOnly,
                          FormatNumberInputFormatter(AppFormat.quantityFormat),
                        ]
                      : [
                          FilteringTextInputFormatter.digitsOnly,
                          MaximumNumberInputFormatter(100)
                        ],
                ))
              ])),
        ],
      ),
      onTap: () => _bloc.onChange(model, widget.models),
      isSelected: model.isSelected,
    );
  }

  Widget _buildContent() {
    return StreamBuilder(
        stream: _bloc.outputSurchargeModels,
        initialData: widget.models,
        builder: (_, snapshot) {
          return CustomListView(
            children: widget.models.map(_buildItem).toList(),
          );
        });
  }

  Widget _buildBottom() {
    return CustomBottom(
      text: AppLocalizations.text(LangKey.done),
      onTap: () => CustomNavigator.pop(context),
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
      title: AppLocalizations.text(LangKey.other_revenues),
      body: _buildBody(),
    );
  }
}
