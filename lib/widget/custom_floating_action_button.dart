part of widget;

class CustomFloatingActionButton extends StatelessWidget {

  final String? icon;
  final GestureTapCallback? onTap;

  CustomFloatingActionButton({this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: null,
        child: CustomImageIcon(
          icon: icon,
          color: AppColors.whiteColor,
          size: 24.0,
        ),
        backgroundColor: AppColors.primaryColor,
        onPressed: onTap
    );
  }
}
