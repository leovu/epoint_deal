part of widget;

class CustomBadge extends StatelessWidget {

  final int? badge;
  final Widget? child;
  final bgd.BadgePosition? position;
  final bool toAnimate;

  CustomBadge({
    this.badge,
    this.child,
    this.position,
    this.toAnimate = true
  });

  @override
  Widget build(BuildContext context) {
    String event;
    if((badge??0) > 9)
      event = "9+";
    else
      event = (badge??0).toString();
    return bgd.Badge(
      badgeContent: Text(
        event,
        style: AppTextStyles.style12WhiteNormal,
      ),
      child: child,
      badgeStyle: bgd.BadgeStyle(
        borderRadius: BorderRadius.circular(10.0),
      ),
      badgeAnimation: bgd.BadgeAnimation.slide(
        toAnimate: toAnimate,
      ),
      showBadge: (badge??0) != 0,
      position: position?? bgd.BadgePosition.topEnd(top: -10, end: -10),
    );
  }
}
