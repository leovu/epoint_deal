import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/order_staff_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_line.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class OrderStaffScreen extends StatefulWidget {
  final int? id;

  OrderStaffScreen(this.id);

  @override
  OrderStaffScreenState createState() => OrderStaffScreenState();
}

class OrderStaffScreenState extends State<OrderStaffScreen> {

  FocusNode _focusSearch = FocusNode();
  TextEditingController _controllerSearch = TextEditingController();

  late OrderStaffBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderStaffBloc(context);

    _controllerSearch.addListener(_listener);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _onRefresh());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controllerSearch.removeListener(_listener);
    _bloc.dispose();
    super.dispose();
  }

  Future _onRefresh(){
    return _bloc.orderStaff(_controllerSearch.text, widget.id);
  }

  _listener(){
    _bloc.search(_controllerSearch.text);
  }

  _selected(BookingStaffModel? model){
    CustomNavigator.pop(context, object: model);
  }

  Widget _buildSearch(){
    return Container(
      padding: EdgeInsets.only(
          top: AppSizes.maxPadding,
          left: AppSizes.maxPadding,
          right: AppSizes.maxPadding),
      child: CustomTextField(
        focusNode: _focusSearch,
        controller: _controllerSearch,
        hintText: AppLocalizations.text(LangKey.enter_search_information),
        backgroundColor: Colors.transparent,
        borderColor: AppColors.borderColor,
      ),
    );
  }

  Widget _buildItem(BookingStaffModel? model){
    return CustomBookingStaff(
      model: model,
      onTap: () => _selected(model),
    );
  }

  Widget _buildContent(){
    return StreamBuilder(
        stream: _bloc.outputModels,
        initialData: null,
        builder: (_, snapshot){
          List<BookingStaffModel>? models = snapshot.data as List<BookingStaffModel>?;
          return CustomListView(
            padding: EdgeInsets.zero,
            separator: Container(
              padding: EdgeInsets.symmetric(
                horizontal: AppSizes.maxPadding,
              ),
              child: CustomLine(),
            ),
            children: models == null
                ? List.generate(4, (index) => _buildItem(null)).toList()
                : models.map((e) => _buildItem(e)).toList(),
            onRefresh: () => _onRefresh(),
          );
        }
    );
  }

  Widget _buildBody(){
    return Column(
      children: [
        _buildSearch(),
        Expanded(child: _buildContent()),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.staff),
      body: _buildBody(),
    );
  }
}
