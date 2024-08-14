part of widget;

class CustomTabBarItem extends StatelessWidget {

  final String icon;
  final String? title;
  final int? badge;

  CustomTabBarItem(this.icon, this.title, {this.badge});

  @override
  Widget build(BuildContext context) {
    Widget child = ImageIcon(AssetImage(icon));
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: Center(
              child: CustomBadge(
                child: child,
                badge: badge,
                toAnimate: false,
              )),
        ),
        Text(
          title ?? "",
          style: AppTextStyles.style10BlackNormal,
        ),
      ],
    );
  }
}

class CustomTabBarItemModel{
  final Widget? icon;
  final Widget? child;

  CustomTabBarItemModel({this.icon, this.child});
}