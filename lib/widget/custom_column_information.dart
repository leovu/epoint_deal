part of widget;

class CustomColumnInformation extends StatelessWidget {
  final String? title;
  final Widget? titleSuffix;
  final dynamic titleIcon;
  final IconData? titleSuffixIcon;
  final String? content;
  final IconData? suffixIconData;
  final String? suffixIcon;
  final Widget? child;
  final Color? backgroundColor;
  final Color? borderColor;
  final TextStyle? titleStyle;
  final bool isRequired;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onTitleTap;
  final GestureTapCallback? onSuffixTap;
  final bool enable;
  final double? separatePadding;
  final String? hintText;

  CustomColumnInformation({
    super.key,
    this.title,
    this.titleSuffix,
    this.titleIcon,
    this.titleSuffixIcon,
    this.content,
    this.suffixIconData,
    this.suffixIcon,
    this.child,
    this.backgroundColor,
    this.borderColor,
    this.titleStyle,
    this.isRequired = false,
    this.onTap,
    this.onTitleTap,
    this.onSuffixTap,
    this.enable = true,
    this.separatePadding,
    this.hintText,
  });

  final _titleIconSize = 18.0;

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSkeleton(
            width: AppSizes.maxWidth! / 4,
          ),
          Container(
            height: AppSizes.minPadding,
          ),
          CustomSkeleton(
            height: AppSizes.maxPadding * 2,
            radius: 5.0,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return _buildSkeleton();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    if (titleIcon != null)
                      Padding(
                        padding:
                            EdgeInsets.only(right: AppSizes.minPadding / 2),
                        child: (titleIcon is IconData)
                            ? Icon(
                                titleIcon,
                                size: _titleIconSize,
                                color: AppColors.primaryColor,
                              )
                            : CustomImageIcon(
                                icon: titleIcon,
                                size: _titleIconSize,
                              ),
                      ),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                            text: title,
                            style: titleStyle ?? AppTextStyles.style14BlackBold,
                            children: [
                              TextSpan(
                                text: isRequired ? " *" : "",
                                style: (titleStyle ??
                                        AppTextStyles.style14BlackBold)
                                    .copyWith(color: Colors.red),
                              ),
                            ]),
                      ),
                    ),
                    if (titleSuffixIcon != null)
                      Padding(
                        padding: EdgeInsets.only(left: AppSizes.minPadding / 2),
                        child: Icon(
                          titleSuffixIcon,
                          size: 18.0,
                          color: AppColors.primaryColor,
                        ),
                      ),
                  ],
                ),
              ),
              if (titleSuffix != null) titleSuffix!,
            ],
          ),
          onTap: onTitleTap,
        ),
        Container(
          height: separatePadding ?? AppSizes.minPadding,
        ),
        InkWell(
          child: (child != null && enable)
              ? child
              : Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      color: backgroundColor ?? AppColors.grey50Color,
                      border: borderColor == null
                          ? null
                          : Border.all(color: borderColor!)),
                  padding: EdgeInsets.all(AppSizes.minPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          (content ?? "").isNotEmpty
                              ? content!
                              : (hintText ?? ""),
                          style: (content ?? "").isNotEmpty
                              ? AppTextStyles.style14BlackNormal
                              : AppTextStyles.style14HintNormal,
                        ),
                      ),
                      (suffixIcon == null && suffixIconData == null)
                          ? Container()
                          : InkWell(
                              child: Container(
                                padding:
                                    EdgeInsets.only(left: AppSizes.minPadding),
                                child: suffixIcon != null
                                    ? CustomImageIcon(
                                        icon: suffixIcon,
                                        size: 20.0,
                                        color: AppColors.grey500Color,
                                      )
                                    : Icon(
                                        suffixIconData,
                                        size: 20.0,
                                        color: AppColors.grey500Color,
                                      ),
                              ),
                              onTap: onSuffixTap,
                            )
                    ],
                  ),
                ),
          onTap: enable ? onTap : null,
        )
      ],
    );
  }
}

class CustomColumnIconInformation extends StatelessWidget {
  final String? icon;
  final String? title;
  final String? content;
  final Widget? child;
  final TextStyle? styleContent;
  final TextStyle? styleTile;
  final GestureTapCallback? onTap;

  CustomColumnIconInformation(
      {this.icon,
      this.title,
      this.content,
      this.child,
      this.styleContent,
      this.styleTile,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    double iconSize = 15.0;

    return InkWell(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                CustomImageIcon(
                  icon: icon,
                  size: iconSize,
                  color: AppColors.primaryColor,
                ),
                SizedBox(
                  width: AppSizes.minPadding,
                )
              ],
              Expanded(
                  child: Text(
                title ?? "",
                style: styleTile ?? AppTextStyles.style13BlackBold,
              ))
            ],
          ),
          Container(
            height: AppSizes.minPadding,
          ),
          child ??
              Text(
                (content ?? "").isNotEmpty
                    ? content!
                    : AppLocalizations.text(LangKey.data_empty)!,
                style: (content ?? "").isNotEmpty
                    ? styleContent ??
                        AppTextStyles.style14BlackNormal.copyWith(
                            color: onTap == null
                                ? AppColors.blackColor
                                : AppColors.primaryColor,
                            decoration:
                                onTap == null ? null : TextDecoration.underline)
                    : AppTextStyles.style14HintNormalItalic,
              )
        ],
      ),
      onTap: (content ?? "").isNotEmpty ? onTap : null,
    );
  }
}

class CustomColumnCenterInformation extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? contentColor;
  final bool isBold;
  final Widget? child;
  final bool isContentRight;
  final String? titleContentRight;

  const CustomColumnCenterInformation(
      {Key? key,
      this.title,
      this.content,
      this.contentColor,
      this.isBold = false,
      this.child,
      this.isContentRight = false,
      this.titleContentRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title ?? "",
                style: AppTextStyles.style14BlackNormal.copyWith(
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
              ),
            ),
            isContentRight == true
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      titleContentRight ?? "",
                      style: AppTextStyles.style14BlackNormal.copyWith(
                          fontWeight:
                              isBold ? FontWeight.bold : FontWeight.normal),
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: AppSizes.minPadding,
        ),
        child ??
            Container(
              decoration: BoxDecoration(
                  color: contentColor!.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(AppSizes.minPadding),
              alignment: Alignment.center,
              child: Text(
                content ?? "",
                style: AppTextStyles.style14BlackBold
                    .copyWith(color: contentColor ?? AppColors.primaryColor),
                textAlign: TextAlign.center,
              ),
            )
      ],
    );
  }
}

class CustomColumnContainerInformation extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? color;
  final String? icon;
  final double? size;
  final TextStyle? styleTitle, styleContent;

  const CustomColumnContainerInformation(
      {Key? key,
      this.title,
      this.content,
      this.color,
      this.icon,
      this.size,
      this.styleTitle,
      this.styleContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color ?? AppColors.primaryColor),
      padding: EdgeInsets.symmetric(vertical: AppSizes.ultraPadding!),
      child: Stack(
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  title ?? "",
                  style: styleTitle ?? AppTextStyles.style13WhiteNormal,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: AppSizes.minPadding,
                ),
                Text(
                  (content ?? 0).toString(),
                  style: styleContent ?? AppTextStyles.style14WhiteBold,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          icon != null
              ? Positioned(
                  left: -5,
                  bottom: -10,
                  child: CustomImageIcon(
                    size: size,
                    icon: icon,
                    color: AppColors.whiteColor,
                  ))
              : SizedBox(),
        ],
      ),
    );
  }
}

class CustomColumnStackInformation extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? color;
  final String? icon;
  final double? size;
  final TextStyle? styleTitle, styleContent;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;

  const CustomColumnStackInformation(
      {Key? key,
      this.title,
      this.content,
      this.color,
      this.icon,
      this.size,
      this.styleTitle,
      this.styleContent,
      this.height,
      this.width,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: color ?? AppColors.primaryColor),
      padding: padding ?? EdgeInsets.symmetric(vertical: AppSizes.minPadding),
      child: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title ?? "",
                  style: styleTitle ?? AppTextStyles.style13WhiteNormal,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: AppSizes.minPadding,
                ),
                Text(
                  (content ?? 0).toString(),
                  style: styleContent ?? AppTextStyles.style14WhiteBold,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          icon != null
              ? Positioned(
                  left: -5,
                  bottom: -0.5,
                  child: CustomImageIcon(
                    size: size,
                    icon: icon,
                    color: AppColors.whiteColor,
                  ))
              : SizedBox(),
        ],
      ),
    );
  }
}

class CustomColumnListInformation extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? contentColor;
  final bool isBold;
  final Widget? child;
  final bool isContentRight;
  final String? titleContentRight;
  final TextStyle? styleTitle;

  const CustomColumnListInformation(
      {Key? key,
      this.title,
      this.content,
      this.contentColor,
      this.isBold = false,
      this.child,
      this.isContentRight = false,
      this.titleContentRight,
      this.styleTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title ?? "",
                style: styleTitle ??
                    AppTextStyles.style16BlackNormal.copyWith(
                        fontWeight:
                            isBold ? FontWeight.bold : FontWeight.normal,
                        color: AppColors.primaryColor),
              ),
            ),
            isContentRight == true
                ? Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      titleContentRight ?? "",
                      style: AppTextStyles.style14BlackNormal.copyWith(
                          fontWeight:
                              isBold ? FontWeight.bold : FontWeight.normal),
                    ),
                  )
                : Container(),
          ],
        ),
        SizedBox(
          height: AppSizes.minPadding,
        ),
        child ??
            Container(
              decoration: BoxDecoration(
                  color: contentColor!.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5.0)),
              padding: EdgeInsets.all(AppSizes.minPadding),
              alignment: Alignment.center,
              child: Text(
                content ?? "",
                style: AppTextStyles.style14BlackBold
                    .copyWith(color: contentColor ?? AppColors.primaryColor),
                textAlign: TextAlign.center,
              ),
            )
      ],
    );
  }
}
