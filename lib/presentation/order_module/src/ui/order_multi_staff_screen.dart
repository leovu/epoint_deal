
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/order_multi_staff_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_line.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class OrderMultiStaffScreen extends StatefulWidget {
  final List<BookingStaffModel>? models;
  final int? branchId;

  OrderMultiStaffScreen({this.models, required this.branchId});

  @override
  OrderMultiStaffScreenState createState() => OrderMultiStaffScreenState();
}

class OrderMultiStaffScreenState extends State<OrderMultiStaffScreen> {
  FocusNode _focusSearch = FocusNode();
  TextEditingController _controllerSearch = TextEditingController();

  late OrderMultiStaffBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderMultiStaffBloc(context);

    _bloc.models = widget.models;
    _bloc.branchId = widget.branchId;

    _controllerSearch.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _onRefresh());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerSearch.dispose();
    _bloc.dispose();
    super.dispose();
  }

  Future _onRefresh() {
    return _bloc.orderStaff(_controllerSearch.text);
  }

  _listener() {
    _bloc.search(_controllerSearch.text);
  }

  Widget _buildSearch(List<BookingStaffModel>? models) {
    return Container(
      padding: EdgeInsets.only(
          top: AppSizes.maxPadding,
          left: AppSizes.maxPadding,
          right: AppSizes.maxPadding),
      child: Row(
        children: [
          Expanded(
              child: CustomTextField(
                focusNode: _focusSearch,
                controller: _controllerSearch,
                hintText:
                AppLocalizations.text(LangKey.enter_search_information),
                backgroundColor: Colors.transparent,
                borderColor: AppColors.borderColor,
              )),
          SizedBox(
            width: AppSizes.minPadding,
          ),
          CustomButton(
            text: AppLocalizations.text(LangKey.select_all),
            isExpand: false,
            onTap: _bloc.selectAll,
          )
        ],
      ),
    );
  }

  Widget _buildItem(BookingStaffModel? model) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.maxPadding, vertical: AppSizes.minPadding),
        alignment: Alignment.centerLeft,
        child: model == null
            ? CustomShimmer(
          child: CustomSkeleton(
            width: AppSizes.maxWidth! / 2,
          ),
        )
            : Row(
          children: [
            CustomAvatar(
              url: model.staffAvatar,
              name: model.fullName,
              size: AppSizes.sizeOnTap,
            ),
            Container(
              width: AppSizes.minPadding,
            ),
            Expanded(
                child: Text(
                  model.fullName ?? "",
                  style: AppTextStyles.style15BlackNormal,
                )),
            if (model.selected)
              Container(
                padding: EdgeInsets.only(left: AppSizes.minPadding),
                child: Icon(
                  Icons.check,
                  color: AppColors.ticketNewColor,
                  size: 15,
                ),
              )
          ],
        ),
      ),
      onTap: model == null ? null : () => _bloc.selected(model),
    );
  }

  Widget _buildContent(List<BookingStaffModel>? models) {
    return CustomListView(
      padding: EdgeInsets.zero,
      physics: AlwaysScrollableScrollPhysics(),
      separator: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppSizes.maxPadding,
        ),
        child: CustomLine(),
      ),
      children: models == null
          ? List.generate(4, (index) => _buildItem(null)).toList()
          : models.map((e) => _buildItem(e)).toList(),
      onRefresh: _onRefresh,
    );
  }

  Widget _buildBottom() {
    return CustomBottom(
      text: AppLocalizations.text(LangKey.apply),
      onTap: _bloc.confirm,
      subText: AppLocalizations.text(LangKey.delete),
      onSubTap: () => _bloc.delete(_controllerSearch.text),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
        stream: _bloc.outputModels,
        initialData: null,
        builder: (_, snapshot) {
          List<BookingStaffModel>? models = snapshot.data as List<BookingStaffModel>?;
          return Column(
            children: [
              _buildSearch(models),
              Expanded(child: _buildContent(models)),
              _buildBottom()
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.staff),
      body: _buildBody(),
    );
  }
}
