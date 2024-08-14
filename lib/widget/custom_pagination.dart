part of widget;

class CustomPagination {
  static SwiperCustomPagination pagination({double? padding, Color? activeColor, Color? inactiveColor}) => SwiperCustomPagination(
      builder:(_, SwiperPluginConfig config){
        List<Widget> list = [];

        int itemCount = config.itemCount;
        int activeIndex = config.activeIndex;

        for (int i = 0; i < itemCount; ++i) {
          bool active = i == activeIndex;
          list.add(CustomActivePagination(active: active, activeColor: activeColor, inactiveColor: inactiveColor));
        }
        return Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.all(padding??5.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: list,
          ),
        );
      }
  );
}

class CustomActivePagination extends StatelessWidget {

  final bool? active;
  final Color? activeColor;
  final Color? inactiveColor;

  CustomActivePagination({this.active, this.activeColor, this.inactiveColor});

  @override
  Widget build(BuildContext context) {
    Color _activeColor = activeColor??AppColors.primaryColor;
    Color _inactiveColor = inactiveColor??AppColors.hintColor;

    double size = 6.0;
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: 4.0
      ),
      child: Container(
        width: active!?size * 4:size,
        height: size,
        decoration: BoxDecoration(
            color: active!?_activeColor:AppColors.whiteColor,
            borderRadius: BorderRadius.all(Radius.circular(50.0)),
            border: active! ? null : Border.all(color: _inactiveColor)
        ),
      ),
    );
  }
}