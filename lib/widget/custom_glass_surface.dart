import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart' as lg;

class CustomGlassSurface extends StatelessWidget {
  final Widget? child;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final BoxConstraints? constraints;
  final double borderRadius;
  final bool floating;

  const CustomGlassSurface({
    Key? key,
    this.child,
    this.margin,
    this.padding,
    this.height,
    this.constraints,
    this.borderRadius = AppGlass.sheetRadius + 8.0,
    this.floating = true,
  }) : super(key: key);

  static EdgeInsets sheetMargin(BuildContext context) => EdgeInsets.fromLTRB(
      12.0, 0.0, 12.0, 12.0 + MediaQuery.of(context).padding.bottom);

  @override
  Widget build(BuildContext context) {
    final Widget surface = lg.GlassContainer(
      useOwnLayer: true,
      settings: AppGlass.sheetSettings,
      shape: lg.LiquidRoundedSuperellipse(borderRadius: borderRadius),
      margin: margin ?? (floating ? sheetMargin(context) : null),
      padding: padding,
      height: height,
      clipBehavior: Clip.antiAlias,
      child: child,
    );
    if (constraints == null) {
      return surface;
    }
    return ConstrainedBox(constraints: constraints!, child: surface);
  }
}
