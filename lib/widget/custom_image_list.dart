part of widget;

class CustomImageList extends StatelessWidget {
  final List<CustomerOrderPhotoModel>? models;
  final Function(List<File>)? onAdd;
  final Function(int)? onRemove;
  final Function(File)? onSingleAdd;

  CustomImageList(
      {this.models, this.onAdd, this.onRemove, Key? key, this.onSingleAdd})
      : super(key: key);

  static const _imagePerRow = 4;
  final _imageWidth = (AppSizes.maxWidth! -
      AppSizes.maxPadding * 2 -
      AppSizes.minPadding * (_imagePerRow - 1) -
      1) /
      _imagePerRow;
  final _radius = 5.0;

  Widget _buildAdd(BuildContext context) {
    return InkWell(
      child: Container(
        width: _imageWidth,
        height: _imageWidth,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_radius),
            border: Border.all(color: AppColors.primaryColor)),
        padding: EdgeInsets.symmetric(horizontal: AppSizes.minPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Icon(
              Icons.add,
              size: _imageWidth / 2,
              color: AppColors.primaryColor,
            ),
            AutoSizeText(
              AppLocalizations.text(LangKey.image)!,
              style: AppTextStyles.style14PrimaryRegular,
              minFontSize: 1.0,
              maxLines: 1,
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
      onTap: () {
        if (onAdd != null) {
          CustomImagePicker.showMultiPicker(context, onAdd as Function(List<File>));
        } else {
          CustomImagePicker.showPicker(context, onSingleAdd!);
        }
      },
    );
  }

  Widget _buildContainer(List<Widget> children) {
    return Wrap(
      spacing: AppSizes.minPadding,
      runSpacing: AppSizes.minPadding,
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return _buildContainer([
      CustomShimmer(
          child: CustomSkeleton(
            width: _imageWidth,
            height: _imageWidth,
            radius: _radius,
          ))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (models == null) {
      return _buildSkeleton();
    }

    List<Widget> children = List.generate(models?.length ?? 0, (index) {
      String? url = models![index].url;
      String? code = models![index].code;

      return InkWell(
        child: Stack(
          children: [
            CustomNetworkImage(
              width: _imageWidth,
              height: _imageWidth,
              url: url,
              radius: _radius,
            ),
            if (onRemove != null)
              Positioned(
                  top: 5.0,
                  right: 5.0,
                  child: InkWell(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          color: AppColors.blackColor.withOpacity(0.5)),
                      padding: EdgeInsets.all(5.0),
                      child: CustomImageIcon(
                        icon: Assets.iconTrash,
                        size: 20.0,
                        color: AppColors.whiteColor,
                      ),
                    ),
                    onTap: () => onRemove!(index),
                  )),
            if((code ?? "").isNotEmpty)
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(bottom: Radius.circular(_radius)),
                      color: AppColors.blackColor.withOpacity(0.5)
                  ),
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    code!,
                    style: AppTextStyles.style12WhiteNormal,
                  ),
                ),
              )
          ],
        ),
        onTap: () => CustomNavigator.push(
            context,
            CustomerOrderPhotoScreen(
              models,
              initialIndex: index,
            )),
      );
    }).toList();

    if (onAdd != null || onSingleAdd != null) {
      children.add(_buildAdd(context));
    }

    return _buildContainer(children);
  }
}
