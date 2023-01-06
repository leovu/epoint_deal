
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';

class CustomContainerLoadmore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.sizeOnTap,
      child: Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
