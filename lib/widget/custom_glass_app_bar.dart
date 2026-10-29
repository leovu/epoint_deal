import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart' as lg;

class CustomGlassAppBar extends StatelessWidget implements PreferredSizeWidget {
  static const double toolbarHeight = 52.0;

  final Widget? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final VoidCallback? onBack;
  final IconData? backIcon;
  final bool wrapActions;

  const CustomGlassAppBar({
    Key? key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.onBack,
    this.backIcon,
    this.wrapActions = true,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(toolbarHeight);

  static Widget action({required Widget child, VoidCallback? onTap}) {
    return lg.GlassButton.custom(
      onTap: onTap ?? () {},
      width: 44.0,
      height: 44.0,
      child: Center(
        child: IconTheme.merge(
          data:
              const IconThemeData(color: AppColors.textTitleColor, size: 22.0),
          child: child,
        ),
      ),
    );
  }

  Widget? _buildLeading(BuildContext context) {
    if (leading != null) {
      return leading;
    }
    final bool canPop = ModalRoute.of(context)?.canPop ?? false;
    if (!automaticallyImplyLeading || !canPop) {
      return null;
    }
    return lg.GlassIconButton(
      icon: Icon(
        backIcon ?? CupertinoIcons.back,
        color: AppColors.textTitleColor,
        size: 22.0,
      ),
      onPressed: onBack ?? () => Navigator.of(context).maybePop(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark
          .copyWith(statusBarColor: Colors.transparent),
      child: lg.GlassAppBar(
        backgroundColor: AppGlass.backgroundColor,
        toolbarHeight: toolbarHeight,
        leading: _buildLeading(context),
        title: title == null
            ? null
            : DefaultTextStyle.merge(
                style: const TextStyle(
                    color: AppColors.textTitleColor,
                    fontSize: 17.0,
                    fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                child: title!,
              ),
        actions: wrapActions
            ? actions?.map((e) => action(child: e)).toList()
            : actions,
      ),
    );
  }
}
