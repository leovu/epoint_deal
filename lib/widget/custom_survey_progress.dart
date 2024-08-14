part of widget;

class CustomSurveyProgress extends StatelessWidget {

  final int total;
  final int? value;

  const CustomSurveyProgress(this.total, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: total == 0
          ? 0
          : value! / total,
      backgroundColor: AppColors.surveyProgress,
      color: AppColors.primaryColor,
    );
  }
}
