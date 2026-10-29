import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:epoint_deal_plugin/widget/custom_glass_surface.dart';

class CustomBottomSheet extends StatelessWidget {
  final String? title;
  final Widget body;
  final GestureTapCallback? onConfirm;
  final String? confirmText;

  const CustomBottomSheet({
    Key? key,
    this.title,
    required this.body,
    this.onConfirm,
    this.confirmText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {},
            child: CustomGlassSurface(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: 38.0,
                      height: 5.0,
                      decoration: BoxDecoration(
                        color:
                            AppColors.primaryDarkColor.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                    ),
                  ),
                  if (title != null) ...[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Center(
                            child: Text(
                              title!,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textTitleColor,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Icon(Icons.close,
                                    color: AppColors.textSecondaryColor,
                                    size: 20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                        height: 1.0, color: AppColors.primaryColorMix),
                  ],
                  Flexible(
                    fit: FlexFit.loose,
                    child: body,
                  ),
                  if (onConfirm != null) ...[
                    const SizedBox(height: 8.0),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18.0),
                      child: CustomButton(
                        text: confirmText ??
                            AppLocalizations.text(LangKey.confirm),
                        onTap: onConfirm,
                      ),
                    ),
                  ],
                  const SizedBox(height: 12.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
