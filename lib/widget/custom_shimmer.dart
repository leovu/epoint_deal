part of widget;

class CustomShimmer extends StatelessWidget {

  final Widget child;

  CustomShimmer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.grey200Color,
      highlightColor: Colors.white,
      child: child,
    );
  }
}
