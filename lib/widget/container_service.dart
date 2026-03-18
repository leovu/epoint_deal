part of widget;

class ContainerService extends StatelessWidget {
  final ServiceNewResponseModel? model;
  final Function? onLoadmore;
  final Function(ServiceNewModel)? onTap;

  const ContainerService({this.model, this.onLoadmore, this.onTap, Key? key})
      : super(key: key);

  Widget _buildContainer(List<Widget> children,
      {Function? onLoadmore, bool? showLoadmore}) {
    return CustomListView(
      children: children,
      onLoadmore: onLoadmore,
      showLoadmore: showLoadmore,
      separator: Padding(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.maxPadding),
        child: CustomLine(),
      ),
      padding: EdgeInsets.zero,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildContainer(
          List.generate(1, (index) => CustomService()).toList());
    }

    return _buildContainer(
        List.generate(
            model!.items!.length,
            (index) => CustomService(
                model: model!.items![index],
                onTap: onTap == null
                    ? null
                    : () => onTap!(model!.items![index]!))).toList(),
        onLoadmore: onLoadmore,
        showLoadmore: model!.pageInfo?.enableLoadmore);
  }
}

class CustomService extends StatelessWidget {
  final ServiceNewModel? model;
  final GestureTapCallback? onTap;

  const CustomService({this.model, this.onTap, Key? key}) : super(key: key);

  final _imageSize = 80.0;
  final _imageRadius = 10.0;

  Widget _buildContainer(Widget image, List<Widget> children) {
    return Padding(
      padding: EdgeInsets.all(AppSizes.maxPadding),
      child: Row(
        children: [
          SizedBox(
            width: _imageSize,
            height: _imageSize,
            child: image,
          ),
          SizedBox(
            width: AppSizes.maxPadding,
          ),
          Expanded(
              child: CustomListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: children,
          ))
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          CustomSkeleton(
            width: double.infinity,
            height: double.infinity,
            radius: _imageRadius,
          ),
          List.generate(3, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
      child: Container(
        color: AppColors.whiteColor,
        child: _buildContainer(
            CustomNetworkImage(
              width: double.infinity,
              height: double.infinity,
              radius: _imageRadius,
              url: model!.serviceAvatar,
            ),
            [
              CustomRowWithoutTitleInformation(
                icon: Assets.iconTitle,
                text: model!.serviceName ?? "",
                textStyle: AppTextStyles.style14BlackBold,
                maxLines: 2,
              ),
              CustomRowWithoutTitleInformation(
                  icon: Assets.iconBarcode, text: model!.serviceCode ?? ""),
              CustomRowWithoutTitleInformation(
                  icon: Assets.iconMoney,
                  text: formatMoney(model!.newPrice)),
            ]),
      ),
      onTap: onTap,
    );
  }
}