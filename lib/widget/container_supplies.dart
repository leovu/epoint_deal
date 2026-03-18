part of widget;

class ContainerSupplies extends StatelessWidget {

  final String? title;
  final List<Widget>? children;

  ContainerSupplies({this.title, this.children});
  
  Widget _buildSkeleton(){
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
            left: AppSizes.maxPadding,
            right: AppSizes.maxPadding,
            bottom: AppSizes.minPadding),
          alignment: Alignment.centerLeft,
          child: CustomShimmer(
            child: CustomSkeleton(width: AppSizes.maxWidth! / 3,),
          ),
        ),
        ContainerSuppliesContent()
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(title == null){
      return  _buildSkeleton();
    }
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(
              bottom: AppSizes.minPadding),
          alignment: Alignment.centerLeft,
          child: Text(
            title!,
            style: AppTextStyles.style16BlackBold,
          ),
        ),
        CustomListView(
          padding: EdgeInsets.all(0.0),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: children ?? [],
        )
      ],
    );
  }
}

class ContainerSuppliesContent extends StatelessWidget {

  final List<Widget>? children;
  final GestureTapCallback? onTap;

  ContainerSuppliesContent({this.children, this.onTap});

  Widget _buildSkeleton(){
    return Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(10.0)
        ),
        alignment: Alignment.topCenter,
        child: CustomListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.maxPadding,
              vertical: AppSizes.minPadding),
          separator: Column(
            children: [
              Container(height: AppSizes.minPadding,),
              CustomDashLine(),
              Container(height: AppSizes.minPadding,),
            ],
          ),
          children: List.generate(5, (index) => CustomRowInformation()),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    if(children == null){
      return  _buildSkeleton();
    }
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(10.0)
        ),
        child: CustomListView(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.maxPadding,
              vertical: AppSizes.minPadding),
          separator: Column(
            children: [
              Container(height: AppSizes.minPadding,),
              CustomDashLine(),
              Container(height: AppSizes.minPadding,),
            ],
          ),
          children: children,
        ),
      ),
      onTap: onTap,
    );
  }
}
