import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:flutter/cupertino.dart';

class CustomDatePicker extends StatelessWidget {
  final DateTime? initTime;
  final String? title;
  final bool haveBnConfirm;
  final bool? enableButton;
  final Function(DateTime) onChange;
  final DateTime? maximumTime;
  final DateTime? minimumTime;
  final GestureTapCallback? onTap;
  final DatePickerDateOrder? dateOrder;
  const CustomDatePicker(
      {Key? key,
      this.initTime,
      required this.onChange,
      this.title,
      this.maximumTime, this.onTap,
      this.minimumTime,
      this.haveBnConfirm = false,
      this.enableButton, this.dateOrder})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    DateTime maxDate = (maximumTime ??
        DateTime(now.year, now.month, now.day, 23, 59, 0)).toLocal();
    DateTime minDate = (minimumTime ?? DateTime(1800, 12, 31)).toLocal();
    
    if (minDate.isAfter(maxDate)) {
      maxDate = DateTime(minDate.year + 100); 
    }

    DateTime initial = (initTime ?? now).toLocal();
    if (initial.isAfter(maxDate)) {
      initial = maxDate;
    }
    if (initial.isBefore(minDate)) {
      initial = minDate;
    }

    return Column(
      children: [
        Expanded(child: Container(
          child:  CupertinoDatePicker(
            maximumDate: maxDate,
            initialDateTime: initial,
            minimumYear: minDate.year,
            minimumDate: minDate,
            maximumYear: maxDate.year,
            onDateTimeChanged: onChange,
            mode: CupertinoDatePickerMode.date,
            dateOrder: dateOrder,
          )
        ),),
        Container(
          height: 15.0,
        ),
        if (haveBnConfirm)
          CustomButton(
            text: AppLocalizations.text(LangKey.confirm),
            onTap: onTap,enable: enableButton ?? false,
          ),
        Container(
          height: 15.0,
        ),
      ],
    );
  }
}