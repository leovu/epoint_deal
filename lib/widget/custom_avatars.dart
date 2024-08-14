part of widget;

class CustomAvatars extends StatelessWidget {

  final List<WorkJobStaffModel>? models;

  CustomAvatars({this.models});

  final double _size = 30.0;
  final int _maxAvatar = 5;

  @override
  Widget build(BuildContext context) {

    if((models?.length ?? 0) == 0){
      return Container();
    }

    int overflow = models!.length - _maxAvatar;
    int length = overflow > 0? _maxAvatar: models!.length;

    return Container(
      height: _size,
      child: Stack(
        children: List.generate(length, (index){
          return Container(
            padding: EdgeInsets.only(
              left: (length - index - 1) * (_size * 0.7),
            ),
            child: Stack(
              children: [
                CustomAvatar(
                  size: _size,
                  borderColor: AppColors.whiteColor,
                  url: models![models!.length - index - 1].staffAvatar,
                  name: models![models!.length - index - 1].staffName,
                ),
                if(index == 0 && overflow > 0)
                  Container(
                    width: _size,
                    height: _size,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.blackColor.withOpacity(0.3)
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "+$overflow",
                      style: AppTextStyles.style12WhiteNormal,
                    ),
                  ),
              ],
            )
          );
        }).toList(),
      ),
    );
  }
}
