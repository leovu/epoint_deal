
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/model/filter_order_model.dart';
import 'package:epoint_deal_plugin/model/request/order_request_model.dart';
import 'package:epoint_deal_plugin/model/response/order_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/filter_order_screen.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_appbar.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../bloc/order_new_bloc.dart';
import 'order_create_screen.dart';
import 'order_detail_screen.dart';

class OrderNewScreen extends StatefulWidget {
  @override
  _OrderNewScreenState createState() => _OrderNewScreenState();
}

class _OrderNewScreenState extends State<OrderNewScreen> {
  FilterOrderModel? _filterModel;

  final FocusNode _focusSearch = FocusNode();
  final TextEditingController _controllerSearch = TextEditingController();

  List<CustomOptionAppBar>? _options;

  late OrderNewBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderNewBloc(context);

    _options = [
      CustomOptionAppBar(icon: Assets.iconFilter, onTap: _filter),
      CustomOptionAppBar(icon: Assets.iconPlus, onTap: _add),
    ];

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
    return _bloc.getOrder(
        requestModel: OrderRequestModel(
            brandCode: Global.brandCode,
            search: _controllerSearch.text,
            status: _filterModel?.statusModel?.id,
            createdAt: _filterModel?.date == null
                ? null
                : "${formatDate(_filterModel!.date)} - ${formatDate(_filterModel!.date)}"),
        isRefresh: isRefresh);
  }

  _filter() async {
    FilterOrderModel? event =
    await CustomNavigator.push(context, FilterOrderScreen(model: _filterModel,));
    if (event != null) {
      _filterModel = event;
      _onRefresh(isRefresh: false);
    }
  }

  _add() async {
    await CustomNavigator.push(context, OrderCreateScreen());
    _onRefresh(isRefresh: false);
  }

  Widget _buildSearchBox() {
    return CustomSearchBox(
      focusNode: _focusSearch,
      controller: _controllerSearch,
      hint: AppLocalizations.text(
          LangKey.search_customer_name_phone_number_order_code),
      onSearch: () => _onRefresh(isRefresh: false),
    );
  }

  Widget _buildEmpty() {
    return CustomEmpty(title: AppLocalizations.text(LangKey.data_empty));
  }

  Widget _buildContent() {
    return StreamBuilder(
        stream: _bloc.outputModel,
        initialData: null,
        builder: (_, snapshot) {
          OrderResponseModel? model = snapshot.data as OrderResponseModel?;
          return ContainerDataBuilder(
            data: model?.items,
            emptyBuilder: _buildEmpty(),
            skeletonBuilder: ContainerOrder(),
            bodyBuilder: () => ContainerOrder(
              model: model,
              onLoadmore: () => _bloc.getOrder(isLoadmore: true),
              onTap: checkVisibilityKey(VisibilityWidgetName.OD000002) ? (event) async {
                bool? result = await CustomNavigator.push(
                    context,
                    OrderDetailScreen(
                      id: event.orderId,
                      onRefresh: _onRefresh,
                    ));
                if((result ?? false)){
                  _onRefresh();
                }
              } : null,
            ),
            onRefresh: _onRefresh,
          );
        });
  }

  Widget _buildBody() {
    return Column(
      children: [_buildSearchBox(), Expanded(child: _buildContent())],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.order_list),
      body: _buildBody(),
      options: _options,
    );
  }
}
