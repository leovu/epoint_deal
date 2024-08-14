part of widget;

class CustomIconText extends StatelessWidget {
  final String? icon;
  final Color? iconColor;
  final String? text;
  final TextStyle? style;
  final GestureTapCallback? onTap;
  final double? size;

  CustomIconText(
      {this.icon, this.text, this.iconColor, this.style, this.onTap, this.size});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(AppSizes.minPadding / 2),
          child: Row(
            children: [
              CustomImageIcon(
                size: size,
                icon: icon,
                color: iconColor ?? AppColors.primaryColor,
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Text(
                text!,
                style: style ?? AppTextStyles.style14WhiteW500,
              )
            ],
          ),
        ));
  }
}
class CustomButtonIconText extends StatelessWidget {
  final String? icon;
  final double? size;
  final Color? iconColor;
  final String? text;
  final TextStyle? style;
  final Function? onTap;
  final bool? isSelected;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  CustomButtonIconText(
      {this.icon,this.size, this.text, this.iconColor, this.style, this.onTap, this.isSelected, this.backgroundColor, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color:backgroundColor ?? AppColors.functionFrequentlyAskedQuestions,
              width: 1.0,
              style: BorderStyle.solid),
          borderRadius:
          BorderRadius.circular(5.0),
          color:backgroundColor ?? AppColors.functionFrequentlyAskedQuestions ),
      padding:padding ?? EdgeInsets.symmetric(vertical: AppSizes.minPadding, horizontal: AppSizes.minPadding),
      child: Center(
          child:Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomImageIcon(
                size:size ?? AppSizes.sizeOnTap! / 2,
                icon: icon,
                color: iconColor ?? AppColors.primaryColor,
              ),
              SizedBox(
                width: AppSizes.minPadding / 2,
              ),
              Text(
                text!,
                style: style ?? AppTextStyles.style14WhiteW500,
              )
            ],
          ),),
    );
  }
}
