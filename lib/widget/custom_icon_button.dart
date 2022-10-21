import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_inkwell.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {

  final Function onTap;
  final String icon;
  final Widget child;
  final Color color;
  final bool isText;

  CustomIconButton({
    this.child,
    this.icon,
    this.onTap,
    this.color,
    this.isText = false
  });

  @override
  Widget build(BuildContext context) {
    return CustomInkWell(
      onTap: onTap,
      child: Container(
        width: isText?null:48.0,
        height: 48.0,
        padding: EdgeInsets.all(48.0 / 5),
        child: Center(
          child: child??CustomImageIcon(
            icon: icon,
            color: color??AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}