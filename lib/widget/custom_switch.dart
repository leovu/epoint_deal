part of widget;

class CustomSwitch extends StatelessWidget {

  final bool? value;
  final ValueChanged<bool>? onChanged;

  CustomSwitch({this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value??true,
      onChanged: onChanged,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      activeColor: AppColors.primaryColor,
      activeTrackColor: AppColors.primaryColor.withValues(alpha: 0.2),
    );
  }
}
