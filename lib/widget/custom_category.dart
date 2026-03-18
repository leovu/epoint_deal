part of widget;

class CustomCategory extends StatelessWidget {
  final Widget category;
  final Widget child;

  const CustomCategory({super.key, required this.category, required this.child});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: AppSizes.maxWidth! / 4,
          child: category,
        ),
        SizedBox(
          width: AppSizes.minPadding,
        ),
        Expanded(child: child)
      ],
    );
  }
}
