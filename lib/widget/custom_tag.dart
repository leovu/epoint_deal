part of widget;

class CustomTag extends StatelessWidget {

  final String? name;
  final String? icon;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Color? borderColor;

  const CustomTag({Key? key, this.name, this.icon, this.textColor, this.backgroundColor, this.padding, this.style, this.borderColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomChip(
          text: name,
          icon: icon,
          iconAsset: false,
          style: style ?? AppTextStyles.style10WhiteBold.copyWith(
            color: textColor ?? AppColors.white
          ),
          borderColor: borderColor ?? null,
          radius: 5.0,
          backgroundColor: backgroundColor ?? AppColors.primaryColor,
          padding: padding ?? EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 4.0
          ),
        )
      ],
    );
  }
}

class CustomTagSelected extends StatelessWidget {

  final String? name;
  final String? icon;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Color? borderColor;
  final bool? isSelected;
  final GestureTapCallback? onTap;
  final double? radius;

  const CustomTagSelected({Key? key, this.name, this.icon, this.textColor, this.backgroundColor, this.padding, this.style, this.borderColor, this.isSelected = true, this.onTap, this.radius}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomChip(
          onTap: onTap,
          text: name,
          icon: icon,
          iconAsset: false,
          style: style ?? AppTextStyles.style10WhiteBold.copyWith(
              color: isSelected! ? AppColors.white : AppColors.primaryColor
          ),
          borderColor: isSelected! ? Colors.transparent : AppColors.primaryColor,
          radius: radius ?? AppSizes.minPadding / 2,
          backgroundColor:isSelected! ? backgroundColor : Colors.transparent ,
          padding: padding ?? EdgeInsets.symmetric(
              vertical: 2.0,
              horizontal: 4.0
          ),
        )
      ],
    );
  }
}

class CustomTagIndicator extends StatelessWidget {

  final String? name;
  final String? icon;
  final Color? textColor;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final TextStyle? style;
  final Color? borderColor;
  final Color? indicatorColor;

  const CustomTagIndicator({Key? key, this.name, this.icon, this.textColor, this.backgroundColor, this.padding, this.style, this.borderColor, this.indicatorColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
                color:Colors.transparent,
                width: 1.0,
                style: BorderStyle.solid),
            borderRadius: BorderRadius.circular(5.0),
            color:backgroundColor ?? AppColors.primaryColor),
      padding: padding ?? EdgeInsets.symmetric(vertical: 2.0, horizontal: 4.0),
      child: Row(
          children: [
            CustomIndicator(
                  isSquare: false,
                  color: indicatorColor ?? AppColors.primaryColor,
                  size: 12,
            ),
            SizedBox(
              width: 2.0,
            ),
            Text(name!, style: style ?? AppTextStyles.style10WhiteBold.copyWith(
              color: textColor ?? AppColors.white), maxLines: 1,)
          ],
        ),
    );
  }
}
