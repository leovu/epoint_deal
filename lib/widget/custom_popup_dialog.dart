part of widget;

class CustomPopupDialog extends StatelessWidget {
  final Widget child;
  final bool isExpanded;

  CustomPopupDialog({required this.child, this.isExpanded = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: isExpanded
          ? CustomGlassSurface(
              floating: false,
              borderRadius: AppRadius.card + 4.0,
              height: MediaQuery.of(context).size.height * 0.5,
              child: child,
            )
          : CustomGlassSurface(
              floating: false,
              borderRadius: AppRadius.card + 4.0,
              child: child,
            ),
      onTap: hideKeyboard,
    );
  }
}
