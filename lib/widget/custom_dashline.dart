part of widget;

class CustomDashLine extends StatelessWidget {

  final bool isVertical;
  final Color? color;

  CustomDashLine({this.isVertical = false, this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = isVertical?constraints.constrainHeight():constraints.constrainWidth();
        final size = 2.0;
        final int count = (boxWidth / (size * 2)).floor();
        return Flex(
          children: List.generate(count, (index) {
            return Container(
              width: isVertical
                  ? 1
                  : size,
              height: isVertical
                  ? size
                  : 1,
                color: color??AppColors.borderColor
            );
          }),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: isVertical?Axis.vertical:Axis.horizontal,
        );
      },
    );
  }
}
