import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/order_history_model_response.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/bloc/detail_deal_bloc.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_info_item.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class ListOrderHistoryScreen extends StatefulWidget {
  final DetailDealBloc bloc;

  const ListOrderHistoryScreen({super.key, required this.bloc});

  @override
  ListOrderHistoryScreenState createState() => ListOrderHistoryScreenState();
}

class ListOrderHistoryScreenState extends State<ListOrderHistoryScreen> {

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.bloc.getOrderHistory(context));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }

  Widget _buildContainer(List<Widget> children){
    return CustomListView(
      padding: EdgeInsets.all(AppSizes.minPadding),
      separator: SizedBox(height: AppSizes.minPadding),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return LoadingWidget(
        padding: EdgeInsets.zero,
        child: CustomListView(
          children: List.generate(
              10,
              (index) => CustomSkeleton(
                    height: 100,
                    radius: 4.0,
                  )),
        ));
  }

  Widget _buildContent() {
    return StreamBuilder(
      stream: widget.bloc.outputListOrderHistory,
      initialData: null,
      builder: (_, snapshot){
        List<OrderHistoryData>? models = snapshot.data as List<OrderHistoryData>?;
        return ContainerDataBuilder(
            data: models,
            skeletonBuilder: _buildSkeleton(),
            emptyBuilder: CustomEmpty(
              title: AppLocalizations.text(LangKey.data_empty),
            ),
            bodyBuilder: () => _buildContainer(
                models!
                    .map((e) => orderHistoryItem(
                  e,
                ))
                    .toList()));
      }
    );
  }

 Widget orderHistoryItem(OrderHistoryData item) {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              color: Colors.black.withOpacity(0.3),
            )
          ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: CustomInfoItem(
                      icon: Assets.iconDeal, title: item.orderCode ?? NULL_VALUE)),
              Container(
                height: 24,
                // width: 55,
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                // margin: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                    color: Color(0xFF11B482),
                    borderRadius: BorderRadius.circular(50.0)),
                child: Center(
                  child: Text(item.processStatusName ?? NULL_VALUE,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
          CustomInfoItem(icon: Assets.iconTime, title: item.createdAt ?? NULL_VALUE),
          CustomInfoItem(
              icon: Assets.iconBranch, title: item.branchName ?? NULL_VALUE),
          CustomInfoItem(
              icon: Assets.iconShipper,
              title:
                  "${AppLocalizations.text(LangKey.ship)} - ${item.deliveryRequestDate ?? NULL_VALUE}"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: CustomInfoItem(
                      icon: Assets.iconDeal,
                      title: "${item.countProd ?? 0} sản phẩm")),
              Row(
                children: [
                  Image.asset(
                    Assets.iconTag,
                    scale: 2.5,
                  ),
                  SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    AppFormat.moneyFormatDot.format(item.amount ?? 0) + " VND",
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )
                ],
              )
            ],
          ),
        ],
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.order_history),
      body: _buildContent(),
      onWillPop: () => CustomNavigator.pop(context, object: false),
    );
  }
}