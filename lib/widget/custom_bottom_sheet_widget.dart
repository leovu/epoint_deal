import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:flutter/material.dart';

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
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.9,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      width: 40.0,
                      height: 4.0,
                      decoration: BoxDecoration(
                        color: const Color(0xFFCCCCCC),
                        borderRadius: BorderRadius.circular(2.0),
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
                                color: Colors.black,
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
                                    color: Colors.black, size: 20.0),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Divider(height: 1.0),
                  ],
                  Flexible(
                    fit: FlexFit.loose,
                    child: body,
                  ),
                  if (onConfirm != null) ...[
                    const SizedBox(height: 8.0),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 18.0),
                      child: CustomButton(
                        text: confirmText ??
                            AppLocalizations.text(LangKey.confirm),
                        onTap: onConfirm,
                      ),
                    ),
                  ],
                  SizedBox(
                      height:
                          MediaQuery.of(context).padding.bottom + 12.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
