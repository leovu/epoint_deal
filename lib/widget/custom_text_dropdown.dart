part of widget;

class CustomTextDropdown extends StatelessWidget {

  final String? text;
  final GestureTapCallback? onTap;

  CustomTextDropdown({this.text, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Text(
            text ?? "",
            style: AppTextStyles.style13PrimaryNormal,
          ),
          Container(width: AppSizes.minPadding,),
          Icon(
            Icons.keyboard_arrow_down,
            color: AppColors.primaryColor,
            size: 13.0,
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomTextDropdownIconRight extends StatelessWidget {

  final String? text;
  final GestureTapCallback? onTap;
  final TextStyle? style;
  final IconData? icon;

  CustomTextDropdownIconRight({this.text, this.onTap, this.style, this.icon});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Row(
        children: [
          Icon(
            icon ?? Icons.keyboard_arrow_down,
            color: AppColors.primaryColor,
            size: 20.0,
          ),
          Container(width: AppSizes.minPadding / 2,),
          Text(
            text ?? "",
            style: style ?? AppTextStyles.style13PrimaryNormal,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}
