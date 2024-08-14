import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';

class CustomRadioButton extends StatelessWidget {

  final bool value;
  final Color? activeColor;
  final Function(bool?)? onChanged;

  const CustomRadioButton(this.value, this.onChanged, {Key? key, this.activeColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Radio<bool>(
      groupValue: true,
      value: value,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeColor: activeColor??AppColors.primaryColor,
      onChanged: onChanged ?? (dynamic _){},
    );
  }
}
class CustomSurveyRadioButton extends CustomRadioButton {

  final bool value;
  final Function(bool?) onChanged;
  final bool isHistory;

  const CustomSurveyRadioButton(
      this.value,
      this.onChanged,
      this.isHistory, {Key? key}) : super(
      value,
      (isHistory? null: onChanged),
      key: key,
      activeColor: isHistory
          ? AppColors.primaryColor
          : AppColors.red500
  );
}