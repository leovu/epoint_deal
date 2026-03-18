part of widget;


class CustomRowImageContentWidget extends StatelessWidget {
  const CustomRowImageContentWidget({super.key,  this.icon, this.title,this.child, this.iconColor, this.titleStyle, this.paddingBottom = 13.0});
  final String? icon;
  final String? title;
  final TextStyle? titleStyle;
  final Widget? child;
  final Color? iconColor;
  final double paddingBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: paddingBottom),
      margin: EdgeInsets.only(left: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            height: 15.0,
            width: 15.0,
            child: Image.asset(icon ?? Assets.iconAddress, color:iconColor ,),
          ),
          Expanded(
            child: child ?? Text(
              title ?? "",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.start,
              style: titleStyle ?? TextStyle(
                  color: AppColors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal),
              // maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}