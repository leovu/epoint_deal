part of widget;

class CustomActivity extends StatelessWidget {

  final List<CustomActivityModel>? models;

  const CustomActivity({Key? key, this.models}) : super(key: key);

  final double _pointSize = 20.0;

  Widget _buildSkeleton(){
    return CustomShimmer(
      child: CustomListView(
        children: List.generate(4, (index) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomSkeleton(width: AppSizes.maxWidth! / 4,),
                CustomSkeleton(width: AppSizes.maxWidth! / 4,),
              ],
            ),
            Container(height: AppSizes.minPadding,),
            CustomSkeleton()
          ],
        )),
      ),
    );
  }

  Widget _buildItem(CustomActivityModel model){
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: _pointSize,
              height: _pointSize,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor
              ),
            ),
            Container(width: AppSizes.minPadding,),
            Expanded(child: Text(
              model.title ?? "",
              style: AppTextStyles.style14BlackBold,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )),
            if(model.subTitle != null)
              ...[
                Container(width: AppSizes.minPadding,),
                Text(
                  model.subTitle!,
                  style: AppTextStyles.style13HintNormal,
                )
              ]
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: _pointSize / 2),
          decoration: BoxDecoration(
              border: Border(
                  left: BorderSide(color: AppColors.grey500Color)
              )
          ),
          padding: EdgeInsets.only(
              left: _pointSize / 2
          ),
          child: Container(
            padding: EdgeInsets.all(AppSizes.minPadding),
            alignment: Alignment.centerLeft,
            child: CustomHtml(
              model.content,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(models == null){
      return _buildSkeleton();
    }
    return ListView(
      padding: EdgeInsets.all(AppSizes.maxPadding),
      children: models!.map((e) => _buildItem(e)).toList(),
    );
  }
}

class CustomActivityModel {
  final String? title;
  final String? subTitle;
  final String? content;

  CustomActivityModel({this.title, this.subTitle, this.content});
}