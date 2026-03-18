
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/presentation/category_module/src/bloc/category_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_tab_bar.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatefulWidget {
  final bool isProduct;
  final bool isSelected;
  final CustomerModel? customerModel;
  final bool isBooking;

  CategoryScreen(
      {this.isProduct = true,
      this.isSelected = false,
      this.customerModel,
      this.isBooking = false});

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late CategoryBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = CategoryBloc(context, widget.isSelected);

    _bloc.customerModel = widget.customerModel;
    _bloc.isBooking = widget.isBooking;

    WidgetsBinding.instance
        .addPostFrameCallback((_) => _bloc.onRefresh(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  Widget _buildEmpty() {
    return CustomEmpty(title: AppLocalizations.text(LangKey.data_empty));
  }

  Widget _buildBody(List<CustomModelTabBar>? models) {
    return ContainerDataBuilder(
      data: models,
      emptyBuilder: _buildEmpty(),
      skeletonBuilder: ContainerProduct(),
      bodyBuilder: () => _bloc.tabController == null
          ? SizedBox()
          : Column(
              children: [
                CustomTabBar(
                  tabs: _bloc.tabs,
                  controller: _bloc.tabController,
                  isExpanded: false,
                ),
                Expanded(
                    child: CustomTabBarView(
                  tabs: _bloc.tabs,
                  controller: _bloc.tabController,
                )),
                if (Globals.cart != null)
                  StreamBuilder(
                      stream: Globals.cart!.outputValue,
                      initialData: 0.0,
                      builder: (_, snapshot) {
                        double? event = (snapshot.data as double?) ?? 0.0;
                        return CustomBottomBooking(
                            value: event, length: Globals.cart!.getQuantity());
                      })
              ],
            ),
      onRefresh: _bloc.onRefresh,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _bloc.outputTabModels,
        initialData: _bloc.tabs,
        builder: (_, snapshot) {
          List<CustomModelTabBar>? models =
              snapshot.data as List<CustomModelTabBar>?;
          if (_bloc.tabs != null && _bloc.tabController == null) {
            _bloc.tabController = TabController(
                length: _bloc.tabs!.length,
                vsync: this,
                initialIndex: widget.isProduct ? 0 : 1);
          }
          return CustomScaffold(
            title: AppLocalizations.text(LangKey.product_service_information),
            body: _buildBody(models),
          );
        });
  }
}
