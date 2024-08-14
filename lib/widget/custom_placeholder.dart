part of widget;

class CustomPlaceholder extends StatelessWidget {

  final double? width;
  final double? height;

  CustomPlaceholder({
    this.width,
    this.height
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.iconDeal,
      fit: BoxFit.contain,
      width: width,
      height: height,
    );
  }
}
