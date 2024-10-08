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
    return Column(
      children: [
        Expanded(child: Container(
          child:  CupertinoDatePicker(
            maximumDate: maximumTime ??
                DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, 23, 59, 0),
            initialDateTime: initTime ?? DateTime.now(), //subtract
            minimumYear: minimumTime?.year ?? 1800,
            minimumDate: minimumTime ?? DateTime(1800, 12, 31),
            maximumYear: maximumTime?.year ?? DateTime.now().year,
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