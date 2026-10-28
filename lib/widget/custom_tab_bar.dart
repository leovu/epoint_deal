import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final bool isExpanded;
  final List<CustomModelTabBar>? tabs;
  final AutoSizeGroup? group;
  final TabController? controller;

  CustomTabBar(
      {this.tabs, this.group, this.controller, this.isExpanded = true});

  Widget _buildTitle(CustomModelTabBar model){
    return AutoSizeText(
      model.name!,
      maxLines: 1,
      group: group ?? AutoSizeGroup(),
      minFontSize: 6.0,
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    return tabs == null?Container():Container(
      margin: EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      padding: EdgeInsets.all(3.0),
      decoration: AppGlass.pill(color: AppGlass.surfaceLight),
      child: TabBar(
      labelColor: AppColors.whiteColor,
      unselectedLabelColor: AppColors.textSecondaryColor,
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: BoxDecoration(
        gradient: AppGlass.activeGradient,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: AppGlass.buttonShadow,
      ),
      dividerColor: Colors.transparent,
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      tabAlignment: TabAlignment.start,
      unselectedLabelStyle: TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.textSecondaryColor,
      fontWeight: FontWeight.w500),
      labelStyle: TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.w600),
      labelPadding: EdgeInsets.symmetric(horizontal: isExpanded?0.0:20.0),
      isScrollable: true,
      tabs: tabs!.map((model){
        return Tab(
            child: Container(
              width: isExpanded
                  ? (MediaQuery.of(context).size.width - 30.0) / tabs!.length
                  : null,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  model.icon == null?Container():Container(
                      padding: EdgeInsets.only(right: 5.0),
                      child: ImageIcon(
                        AssetImage(model.icon!),
                        size: 20,
                      )
                  ),
                  isExpanded?Flexible(
                      fit: FlexFit.loose,
                      child: _buildTitle(model)
                  ):_buildTitle(model)
                ],
              )
            )
        );
      }).toList(),
      controller: controller,
    ),
    );
  }
}

class CustomTabBarView extends StatelessWidget {
  final List<CustomModelTabBar>? tabs;
  final TabController? controller;
  final ScrollPhysics? physics;

  CustomTabBarView({this.tabs, this.controller, this.physics});

  @override
  Widget build(BuildContext context) {
    return TabBarView(
        controller: controller,
        children: tabs!.map((model) => model.child ?? Container()).toList(),
      physics: physics,
    );
  }
}

class CustomModelTabBar {
  final String? name;
  final String? icon;
  final Widget? child;

  CustomModelTabBar({this.name, this.icon, this.child});
}