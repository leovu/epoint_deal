part of widget;

class CustomPickerColor extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? borderColor;
  final IconData? titleIconData;
  final String? titleIcon;
  final Color? pickerColor;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTapColor;
  final Color? colorIcons;

  CustomPickerColor(
      {this.text,
      this.backgroundColor,
      this.borderColor,
      this.titleIcon,
      this.titleIconData,
      this.pickerColor,
      this.onTap,
      this.onTapColor, this.colorIcons});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: backgroundColor ?? AppColors.whiteColor,
            boxShadow: [
                  BoxShadow(
                      offset: Offset(0.0, 0.0),
                      blurRadius: 1,
                      color: AppColors.blackColor.withOpacity(0.25))
            ],
            border:
                borderColor == null ? null : Border.all(color: borderColor!)),
        child: Row(
          children: [
            (titleIcon == null && titleIconData == null)
                ? Container()
                : InkWell(
                    splashColor: Colors.transparent,
                    child: Container(
                      padding: EdgeInsets.only(
                        left: AppSizes.minPadding,
                      ),
                      child: titleIcon != null
                          ? CustomImageIcon(
                              icon: titleIcon,
                              size: 18.0,
                              color:colorIcons ?? AppColors.grey500Color,
                            )
                          : Icon(
                              titleIconData,
                              size: 18.0,
                              color:colorIcons ?? AppColors.grey500Color,
                            ),
                    ),
                  ),
            Expanded(child: Padding(
              padding: EdgeInsets.all(AppSizes.minPadding),
              child: Text(
                text ?? AppLocalizations.text(LangKey.data_empty)!,
                style: AppTextStyles.style14HintNormal,
              ),
            ),),
            Padding(
                padding: EdgeInsets.only(right: AppSizes.minPadding),
              child: InkWell(
              onTap: onTapColor,
              child: Container(
                height: 20.0,
                width: 60.0,
                decoration: BoxDecoration(
                    color: pickerColor ?? AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            )),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
