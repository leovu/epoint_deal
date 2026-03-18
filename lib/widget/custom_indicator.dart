import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';

class CustomIndicator extends StatelessWidget {
  final Color? color;
  final Color textColor;
  final String? text;
  final bool? isSquare;
  final double size;

  CustomIndicator({
    this.color,
    this.textColor = Colors.white,
    this.text,
    this.isSquare,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare! ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
      ],
    );
  }
}

class CustomTextIndicator extends StatelessWidget {
  final Color? color;
  final Color textColor;
  final String? name;
  final bool? isSquare;
  final double size;
  final TextStyle? style;


  CustomTextIndicator({
    this.color,
    this.textColor = Colors.white,
    this.name,
    this.isSquare,
    this.size = 16,
    this.style
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(AppSizes.minPadding),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.all(Radius.circular(5.0))
            ),
          ),
        ),
        SizedBox(width: 2.0,),
        Text(name!, style: style ?? AppTextStyles.style14BlackBold.copyWith(
            color: textColor),)
      ],
    );
  }
}