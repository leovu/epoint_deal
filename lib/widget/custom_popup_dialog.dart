part of widget;

class CustomPopupDialog extends StatelessWidget {

  final Widget child;
  final bool isExpanded;

  CustomPopupDialog({
    required this.child,
    this.isExpanded = false
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: isExpanded?Container(
        decoration: AppGlass.dialog(),
        height: MediaQuery.of(context).size.height * 0.5,
        child: child,
      ):Container(
        decoration: AppGlass.dialog(),
        child: child,
      ),
      onTap: hideKeyboard,
    );
  }
}
