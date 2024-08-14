part of widget;

class CustomContainerList extends StatelessWidget {

  final Widget? child;
  final GestureTapCallback? onTap;

  const CustomContainerList({Key? key, this.child, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.whiteColor,
            boxShadow: [
              BoxShadow(
                  offset: Offset(0.0, 0.0),
                  blurRadius: 4.0,
                  color: AppColors.blackColor.withOpacity(0.25)
              )
            ]
        ),
        child: child,
      ),
      onTap: onTap,
    );
  }
}
