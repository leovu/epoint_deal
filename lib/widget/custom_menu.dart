part of widget;

class CustomMenu extends StatelessWidget {

  final String? icon;
  final Color? iconColor;
  final Color? backgroundColor;
  final String? text;
  final int? number;
  final GestureTapCallback? onTap;

  CustomMenu({
    this.icon,
    this.iconColor,
    this.backgroundColor,
    this.text,
    this.number,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    double iconSize = AppSizes.sizeOnTap! -  AppSizes.minPadding;
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.borderColor.withOpacity(0.2),
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(10.0)
        ),
        padding: EdgeInsets.all(AppSizes.minPadding),
        child: Row(
          children: [
            if(icon != null)
              Container(
                width: iconSize,
                height: iconSize,
                decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    shape: BoxShape.circle
                ),
                alignment: Alignment.center,
                margin: EdgeInsets.only(right: AppSizes.minPadding),
                child: CustomImageIcon(
                  icon: icon,
                  color: iconColor??AppColors.grey500Color,
                  size: iconSize / 3 * 2,
                ),
              ),
            Expanded(child: Text(
              text ?? "",
              style: AppTextStyles.style15BlackBold,
            )),
            Container(width: AppSizes.minPadding,),
            number == null
                ? CustomShimmer(
              child: CustomSkeleton(
                width: 30.0,
              ),
            )
                : CustomChip(
              text: number.toString(),
              backgroundColor: backgroundColor,
              style: AppTextStyles.style14WhiteBold,
            )
          ],
        ),
      ),
      onTap: number == null?null:onTap,
    );
  }
}
