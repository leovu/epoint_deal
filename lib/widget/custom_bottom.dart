import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:flutter/material.dart';

class CustomBottom extends StatelessWidget {
  final String? text;
  final Color? color;
  final TextStyle? textStyle;
  final GestureTapCallback? onTap;
  final String? subText;
  final GestureTapCallback? onSubTap;
  final Color? subColor;
  final Widget? child;

  const CustomBottom(
      {Key? key,
      this.text,
      this.color,
      this.textStyle,
      this.onTap,
      this.subText,
      this.onSubTap,
      this.subColor,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(color: Color(0xFFE5E5E5)),
      )),
      child: Column(
        children: [
          if (child != null)
            Padding(
              padding: EdgeInsets.only(bottom: 10.0),
              child: child,
            ),
          if (subText != null || text != null)
            Row(
              children: [
                if (subText != null)
                  Expanded(
                      child: CustomButton(
                    text: subText,
                    backgroundColor: subColor ?? Color(0xFFF44336),
                    style: TextStyle(
                        fontSize: AppTextSizes.size14,
                        color: AppColors.white,
                        fontWeight: FontWeight.bold),
                    onTap: onSubTap,
                  )),
                if (subText != null && text != null)
                  SizedBox(
                    width: 10.0,
                  ),
                if (text != null)
                  Expanded(
                      child: CustomButton(
                    text: text,
                    backgroundColor: color ?? AppColors.primaryColor,
                    style: textStyle ??
                        TextStyle(
                            fontSize: AppTextSizes.size14,
                            color: AppColors.white,
                            fontWeight: FontWeight.bold),
                    onTap: onTap,
                  )),
              ],
            )
        ],
      ),
    );
  }
}
