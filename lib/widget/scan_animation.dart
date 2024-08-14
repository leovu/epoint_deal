part of widget;

class ScanAnimation extends StatefulWidget {

  final double size;

  ScanAnimation(this.size);

  @override
  ScanAnimationState createState() => ScanAnimationState();
}

class ScanAnimationState extends State<ScanAnimation> with SingleTickerProviderStateMixin {

  late AnimationController _animationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.size,
      height: widget.size,
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
            vertical: 20.0,
            horizontal: 3.0
        ),
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (_, child) {
            return Container(
              alignment: Alignment(0.0, _animationController.value - 1 + _animationController.value),
              child: child,
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(15.0)),
              gradient: LinearGradient(
                end: Alignment.topCenter,
                begin: Alignment.bottomCenter,
                stops: [
                  0.0,
                  0.35,
                  0.65,
                  1
                ],
                colors: [
                  AppColors.primaryColor.withOpacity(0.0),
                  AppColors.primaryColor.withOpacity(0.5),
                  AppColors.primaryColor.withOpacity(0.5),
                  AppColors.primaryColor.withOpacity(0.0),
                ],
              ),
            ),
            height: 40.0,
          ),
        ),
      ),
    );
  }
}
