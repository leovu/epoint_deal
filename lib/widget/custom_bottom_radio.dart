part of widget;

class CustomBottomRadio extends StatelessWidget {

  final List<CustomBottomRadioModel>? options;
  final EdgeInsetsGeometry? padding;
  final Function? onLoadMore;

  CustomBottomRadio({this.options,  this.padding, this.onLoadMore});

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      padding:padding ?? EdgeInsets.symmetric(horizontal: AppSizes.maxPadding ),
      shrinkWrap: true,
      children: (options?.length ?? 0) == 0? [CustomEmpty(
        title: AppLocalizations.text(LangKey.data_empty),
      )]: options!.map((e) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: AppSizes.minPadding/ 2),
          child: Row(
            children: [
              e.icon == null?Container():Container(
                padding: EdgeInsets.only(right: AppSizes.minPadding),
                child: Icon(e.icon, color: AppColors.functionFrequentlyAskedQuestions,)
              ),
              Expanded(
                child: Text(
                  e.text ?? "",
                  style: AppTextStyles.style14BlackNormal.copyWith(
                      color: e.textColor ?? null
                  ),
                ),
              ),
            ],
          ),
        ),
        onTap: e.onTap,
      )).toList(),
      onLoadmore: onLoadMore,
    );
  }
}

class CustomBottomRadioModel{
  final IconData? icon;
  final String? text;
  final Color? textColor;
  final bool? isSelected;
  final GestureTapCallback? onTap;


  CustomBottomRadioModel({this.icon, this.text, this.textColor, this.isSelected, this.onTap});
}