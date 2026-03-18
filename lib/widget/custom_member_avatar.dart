part of widget;

class CustomMemberAvatar extends StatelessWidget {

  final String? urlAvatar;
  final double? sizeAvatar;
  final String? name;
  final TextStyle? style;

  CustomMemberAvatar({this.urlAvatar, this.name, this.style, this.sizeAvatar});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomAvatar(
          size: sizeAvatar ?? AppSizes.sizeOnTap! - 10,
          url: urlAvatar,
          name: name,
        ),
        SizedBox(
          width: AppSizes.minPadding,
        ),
        Text(
          name!,
          style: style ?? AppTextStyles.style14BlackNormal,
        )
      ],
    );
  }
}
