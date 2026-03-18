part of widget;

class CustomErrorText extends StatelessWidget {

  final String? error;
  final TextAlign? textAlign;

  const CustomErrorText(this.error, {Key? key, this.textAlign}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      error ?? "",
      style: AppTextStyles.style14DarkRedBold,
      textAlign: textAlign ?? TextAlign.left,
    );
  }
}
