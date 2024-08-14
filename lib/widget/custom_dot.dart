part of widget;

class CustomDot extends StatelessWidget {

  final double size;
  final Color? color;

  const CustomDot({Key? key, this.size = 6.0, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? AppColors.primaryColor
      ),
    );
  }
}

class CustomIndex extends StatelessWidget {
  final int index;
  const CustomIndex({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(4.0)
      ),
      padding: EdgeInsets.all(4.0),
      child: Row(
        children: [
          CustomDot(),
          SizedBox(width: 2.0,),
          Text(
            (index + 1).toString(),
            style: AppTextStyles.style12PrimaryBold,
          )
        ],
      ),
    );
  }
}
