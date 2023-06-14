import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';

class CustomLine extends StatelessWidget{

  final bool isVertical;
  final double? size;
  final Color? color;

  CustomLine({
    this.isVertical = true,
    this.size,
    this.color
  }):assert(isVertical != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return isVertical?Container(
      color: color??AppColors.borderColor,
      height: size ?? 0.5,
    ):Container(
      color: color??AppColors.borderColor,
      width: size ?? 0.5,
    );
  }
}