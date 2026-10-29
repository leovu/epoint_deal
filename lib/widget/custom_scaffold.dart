import 'dart:io';

import 'package:auto_size_text_plus/auto_size_text_plus.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/widget/container_scrollable.dart';
import 'package:epoint_deal_plugin/widget/custom_appbar.dart';
import 'package:epoint_deal_plugin/widget/custom_glass_app_bar.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? body;
  final String? title;
  final Widget? customTitle;
  final List<CustomOptionAppBar>? options;
  final CustomRefreshCallback? onRefresh;
  final bool isBottom;
  final Color? backgroundColor;
  final Widget? floatingActionButton;
  final List<KeyboardActionsItem>? actions;
  final IconData? icon;
  final List<CustomModelTabBar>? tabs;
  final TabController? tabController;
  final GestureTapCallback? onWillPop;
  final bool isBottomSheet;
  final bool isExpanded;
  final String? backgroundImage;

  CustomScaffold(
      {this.body,
      this.title,
      this.customTitle,
      this.options,
      this.onRefresh,
      this.isBottom = false,
      this.backgroundColor,
      this.floatingActionButton,
      this.actions,
      this.icon,
      this.tabs,
      this.tabController,
      this.onWillPop,
      this.isBottomSheet = false,
      this.isExpanded = true,
      this.backgroundImage});

  bool get _hasHeader => title != null || customTitle != null;

  Widget _buildOption(CustomOptionAppBar model) {
    final Widget child = model.child ??
        (model.text != null
            ? Text(
                model.text!,
                style: AppTextStyles.style15WhiteNormal
                    .copyWith(color: AppColors.textTitleColor),
              )
            : CustomImageIcon(
                icon: model.icon,
                color: AppColors.textTitleColor,
                size: 22.0,
              ));
    if (model.child != null) {
      return child;
    }
    return CustomGlassAppBar.action(child: child, onTap: model.onTap);
  }

  PreferredSizeWidget? _buildAppBar(BuildContext context) {
    if (!_hasHeader) {
      return null;
    }
    return CustomGlassAppBar(
      title: customTitle ?? Text(title!),
      onBack: onWillPop,
      backIcon: icon,
      actions: options?.map((e) => _buildOption(e)).toList(),
      wrapActions: false,
    );
  }

  Widget _buildContent() {
    return Column(
      children: [
        tabs == null
            ? Container()
            : CustomTabBar(
                tabs: tabs,
                group: AutoSizeGroup(),
                controller: tabController,
                isExpanded: isExpanded,
              ),
        Expanded(
            child: tabs == null
                ? ContainerScrollable(child: body, onRefresh: onRefresh)
                : CustomTabBarView(
                    controller: tabController,
                    tabs: tabs,
                  ))
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppGlass.backgroundColor,
      appBar: _buildAppBar(context),
      body: SafeArea(
        top: false,
        left: false,
        right: false,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: backgroundColor == null && backgroundImage == null
                ? AppGlass.background()
                : null,
            child: backgroundImage == null
                ? _buildContent()
                : Stack(
                    fit: StackFit.expand,
                    children: [
                      SingleChildScrollView(
                        child: Container(
                          child: Image.asset(
                            backgroundImage!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      _buildContent()
                    ],
                  )),
      ),
      floatingActionButton: floatingActionButton,
      resizeToAvoidBottomInset: !isBottomSheet,
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardActions(
      config: configKeyboardActions(actions ?? []),
      disableScroll: true,
      enable: Platform.isIOS || Platform.isMacOS,
      child: onWillPop == null
          ? _buildBody(context)
          : PopScope(
              child: _buildBody(context),
              canPop: false,
              onPopInvokedWithResult: (event, _) {
                if (!event) {
                  onWillPop!();
                }
              },
            ),
    );
  }
}

configKeyboardActions(List<KeyboardActionsItem> actions) {
  return KeyboardActionsConfig(
      // keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: AppColors.surfaceColor,
      actions: actions);
}
