part of widget;

class CustomBottomBooking extends StatelessWidget {
  final double value;
  final bool showLength;
  final double? length;
  final GestureTapCallback? onTap;

  const CustomBottomBooking(
      {super.key,
      required this.value,
      this.length,
      this.showLength = true,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return CustomBottom(
      child: CustomButton(
        child: Row(
          children: [
            if (showLength) ...[
              Container(
                margin: EdgeInsets.symmetric(vertical: AppSizes.minPadding),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(color: AppColors.whiteColor)),
                padding:
                    EdgeInsets.symmetric(horizontal: AppSizes.minPadding / 2),
                child: Text(
                  (length ?? 0).toString(),
                  style: AppTextStyles.style13WhiteNormal,
                ),
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
            ],
            Text(
              AppLocalizations.text(LangKey.confirm)!,
              style: AppTextStyles.style14WhiteNormal,
            ),
            SizedBox(
              width: AppSizes.minPadding,
            ),
            Expanded(
                child: Text(
              formatMoney(value),
              style: AppTextStyles.style14WhiteBold,
              textAlign: TextAlign.right,
            ))
          ],
        ),
        onTap: onTap ?? () => CustomNavigator.pop(context),
      ),
    );
  }
}
