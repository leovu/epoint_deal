
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String? title;
  final String? content;
  final String? textSubmitted;
  final GestureTapCallback? onSubmitted;
  final String? textSubSubmitted;
  final GestureTapCallback? onSubSubmitted;
  final Color? colorSubmitted;
  final bool enableCancel;
  final bool isTicket;
  final Widget? child;

  CustomAlertDialog(
      {
        required this.title,
        this.content,
        this.onSubmitted,
        this.textSubmitted,
        this.onSubSubmitted,
        this.textSubSubmitted,
        this.colorSubmitted,
        this.enableCancel = false,
        this.isTicket = false,
        this.child
      })
      : assert(enableCancel != null);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              color: Colors.white),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(AppSizes.maxPadding!),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: AppSizes.sizeOnTap! - AppSizes.maxPadding!),
                      child: Text(
                        title ?? "",
                        style: AppTextStyles.style20BlackBold,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: AppSizes.minPadding,
                    ),
                    child ?? Text(
                      content ?? "",
                      style: AppTextStyles.style15BlackNormal,
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      height: AppSizes.minPadding,
                    ),
                    CustomButton(
                      text: textSubmitted ?? AppLocalizations.text(LangKey.i_get_it),
                      backgroundColor: colorSubmitted ?? AppColors.primaryColor,
                      onTap: onSubmitted ?? () => Navigator.of(context).pop(),
                    ),
                    textSubSubmitted == null
                        ? Container()
                        : Container(
                            padding: EdgeInsets.only(top: AppSizes.minPadding!),
                            child: CustomButton(
                              text: textSubSubmitted,
                              backgroundColor: AppColors.subColor,
                              onTap: onSubSubmitted ??
                                  () => Navigator.of(context).pop(),
                            ))
                  ],
                ),
              )
            ],
          ),
        ),
        enableCancel
            ? InkWell(
                child: Icon(
                  Icons.close,
                  size: 24,
                  color: AppColors.primaryColor,
                ),
                onTap: () =>  Navigator.of(context).pop(),
              )
            : Container()
      ],
    );
  }
}
