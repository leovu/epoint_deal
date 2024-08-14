import 'package:auto_size_text/auto_size_text.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final Color? backgroundColor;
  final Color? borderColor;
  final String? icon;
  final String? text;
  final TextStyle? style;
  final GestureTapCallback? onTap;
  final bool isExpand;
  final bool isIcon;
  final Color? iconColor;
  final bool enable;
  final double? height;
  final Widget? child;

  CustomButton(
      {this.backgroundColor,
      this.borderColor,
      this.icon,
      this.text,
      this.style,
      this.onTap,
      this.isExpand = true,
      this.isIcon = false,
      this.iconColor,
      this.enable = true,
      this.height,
      this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          decoration: BoxDecoration(
              color: enable
                  ? (backgroundColor ?? AppColors.primaryColor)
                  : AppColors.grey200Color,
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: borderColor == null
                  ? null
                  : Border.all(
                      color: borderColor!,
                      width: 1.0,
                      style: BorderStyle.solid)),
          height: height ?? AppSizes.sizeOnTap,
          padding: EdgeInsets.symmetric(horizontal: AppSizes.minPadding),
          child: child ??
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon == null
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(right: 5.0),
                          child: isIcon
                              ? CustomImageIcon(
                                  icon: icon,
                                  color: iconColor ??
                                      (enable
                                          ? AppColors.whiteColor
                                          : AppColors.grey500Color),
                                  size: 20.0,
                                )
                              : Image.asset(
                                  icon!,
                                  width: 20,
                                ),
                        ),
                  isExpand
                      ? Flexible(
                          fit: FlexFit.loose,
                          child: Text(
                            text ?? "",
                            style: style ??
                                AppTextStyles.style15WhiteNormal.copyWith(
                                    color: enable
                                        ? AppColors.whiteColor
                                        : AppColors.grey500Color),
                            textAlign: TextAlign.center,
                          ))
                      : Text(
                          text ?? "",
                          style: style ??
                              AppTextStyles.style15WhiteNormal.copyWith(
                                  color: enable
                                      ? AppColors.whiteColor
                                      : AppColors.grey500Color),
                          textAlign: TextAlign.center,
                        )
                ],
              ),
        ),
        onTap: enable ? onTap : null);
  }
}


class CustomQuantityButton extends StatelessWidget {
  final bool isPlus;
  final GestureTapCallback? onTap;

  CustomQuantityButton({this.isPlus = true, this.onTap});

  @override
  Widget build(BuildContext context) {
    final double iconSize = 20.0;
    return InkWell(
      child: Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
            shape: BoxShape.circle, color: AppColors.primaryColor),
        alignment: Alignment.center,
        child: Text(
          isPlus ? "+" : "-",
          style: AppTextStyles.style14WhiteWeight600,
        ),
      ),
      onTap: onTap,
    );
  }
}