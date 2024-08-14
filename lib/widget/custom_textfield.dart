import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_inkwell.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? hintText;
  final IconData? suffixIconData;
  final String? suffixIcon;
  final String? suffixText;
  final Color? borderColor;
  final Color? backgroundColor;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool? readOnly;
  final bool? autofocus;
  final TextAlign? textAlign;
  final TextInputAction? textInputAction;
  final int? maxLength;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final GestureTapCallback? onSuffixTap;
  final GestureTapCallback? onTap;
  final bool? obscureText;
  final IconData? titleIconData;
  final String? titleIcon;
  final Color? colorIcons;
  final BoxShadow? shadow;
  final Widget? widgetRight;
  final GestureTapCallback? onTapTitleIcon;
  final double? suffixIconSize;
  final String? titleImage;
  final Color? prefixIconColor;

  CustomTextField(
      {this.focusNode,
      this.controller,
      this.hintText,
      this.suffixIconData,
      this.suffixIcon,
      this.suffixText,
      this.borderColor,
      this.backgroundColor,
      this.maxLines,
      this.minLines,
      this.keyboardType,
      this.inputFormatters,
      this.readOnly,
      this.autofocus,
      this.textAlign,
      this.textInputAction,
      this.maxLength,
      this.onSubmitted,
      this.onChanged,
      this.onSuffixTap,
      this.onTap,
      this.obscureText,
      this.titleIcon,
      this.titleIconData,
      this.colorIcons,
      this.shadow,
      this.widgetRight,
      this.onTapTitleIcon,
      this.suffixIconSize,
      this.titleImage,
      this.prefixIconColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: backgroundColor ?? AppColors.grey50Color,
            boxShadow: [
              shadow ??
                  BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 0,
                      color: AppColors.black.withOpacity(0))
            ],
            border:
                borderColor == null ? null : Border.all(color: borderColor!)),
        child: Row(
          children: [
            (titleImage == null && titleIcon == null && titleIconData == null)
                ? Container()
                : InkWell(
                    onTap: onTapTitleIcon,
                    splashColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.only(left: AppSizes.minPadding),
                      child: titleImage != null
                          ? Image.asset(
                              titleImage!,
                              width: 18.0,
                            )
                          : titleIcon != null
                              ? CustomImageIcon(
                                  icon: titleIcon,
                                  size: 18.0,
                                  color: prefixIconColor ?? colorIcons ?? AppColors.grey500Color,
                                )
                              : Icon(
                                  titleIconData,
                                  size: 18.0,
                                  color: prefixIconColor ?? colorIcons ?? AppColors.grey500Color,
                                ),
                    ),
                  ),
            Expanded(
              child: TextField(
                focusNode: focusNode,
                controller: controller,
                style: AppTextStyles.style14BlackNormal,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(AppSizes.minPadding),
                  hintText: hintText,
                  hintStyle: AppTextStyles.style14HintNormal,
                  border: InputBorder.none,
                ),
                minLines: minLines ?? 1,
                maxLines: maxLines ?? 1,
                keyboardType: keyboardType,
                inputFormatters: inputFormatters,
                enabled: !(readOnly ?? false),
                autofocus: autofocus ?? false,
                textInputAction: textInputAction,
                onSubmitted: onSubmitted,
                onChanged: onChanged,
                textAlign: textAlign ?? TextAlign.start,
                maxLength: maxLength,
                obscureText: obscureText ?? false,
              ),
            ),
            (suffixText == null)
                ? Container()
                : InkWell(
                    splashColor: Colors.transparent,
                    child: Container(
                        padding: EdgeInsets.only(right: AppSizes.minPadding),
                        child: Text(
                          suffixText!,
                          style: AppTextStyles.style14WhiteNormal
                              .copyWith(color: AppColors.grey500Color),
                        ))),
            (suffixIcon == null && suffixIconData == null)
                ? Container()
                : InkWell(
                    splashColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.only(right: AppSizes.minPadding),
                      child: (suffixIcon != null)
                          ? CustomImageIcon(
                              icon: suffixIcon,
                              size: suffixIconSize ?? 20.0,
                              color: colorIcons ?? AppColors.grey500Color,
                            )
                          : Icon(
                              suffixIconData,
                              size: suffixIconSize ?? 20.0,
                              color: colorIcons ?? AppColors.grey500Color,
                            ),
                    ),
                    onTap: onSuffixTap,
                  ),
            widgetRight ?? Container(),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

class CustomQuantityTextField extends StatelessWidget {
  final TextEditingController controller;
  final int? limit;

  CustomQuantityTextField({required this.controller, this.limit});

  @override
  Widget build(BuildContext context) {
    if (controller.text.isEmpty) {
      if (limit != null) {
        if (limit! <= 1) {
          controller.text = limit.toString();
        } else {
          controller.text = "1";
        }
      } else {
        controller.text = "1";
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        CustomQuantityButton(
            isPlus: false,
            onTap: () {
              int event = int.tryParse(controller.text)!;
              if (event > 1) {
                event = event - 1;

                controller.text = event.toString();
              }
            }),
        Container(
          width: 5.0,
        ),
        Container(
          width: 40.0,
          child: TextField(
            controller: controller,
            style: TextStyle(
                fontSize: AppTextSizes.size13,
                color: Colors.black,
                fontWeight: FontWeight.normal),
            readOnly: true,
            decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.all(0.0),
                border: InputBorder.none),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 5.0,
        ),
        CustomQuantityButton(onTap: () {
          int event = int.tryParse(controller.text)!;
          if (event < 99) {
            if (limit != null) {
              if (event < limit!) {
                event = event + 1;
              }
            } else {
              event = event + 1;
            }

            controller.text = event.toString();
          }
        }),
      ],
    );
  }
}
