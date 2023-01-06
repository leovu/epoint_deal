
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatelessWidget {

  final bool value;
  final Color color;
  final Function(bool) onChanged;

  const CustomCheckbox(this.value, this.onChanged, {Key key, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value ?? false,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeColor: color ?? AppColors.primaryColor,
      onChanged: onChanged ?? (_){},
    );
  }
}

class CustomSurveyCheckbox extends CustomCheckbox {

  final bool value;
  final Function(bool) onChanged;
  final bool isHistory;

  const CustomSurveyCheckbox(
      this.value,
      this.onChanged,
      this.isHistory,
      {Key key}) : super(
    value,
    isHistory? null: onChanged,
    key: key,
    color: isHistory
        ? AppColors.primaryColor
        : AppColors.red500,
  );
}
