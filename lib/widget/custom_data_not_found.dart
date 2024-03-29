import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';

class CustomDataNotFound extends StatelessWidget {
  final String? title;
  final String? content;
  final Color? color;
  final bool isTitle;

  const CustomDataNotFound(
      {Key? key,
      this.title,
      this.content,
      this.color,
      this.isTitle = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width / 8,
            width: MediaQuery.of(context).size.width / 4,
            child: Icon(Icons.not_interested, color: Colors.grey[850],),
          ),
          if (isTitle ?? true)
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0,
                  right: 20.0,
                  left: 20.0,
                  bottom: 8.0),
              child: Text(
                  title ?? AppLocalizations.text(LangKey.searchNotFound)!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.style14Black50Weight400
                      .copyWith(color: Colors.grey[850])),
            )
          else
            Container(height: 20.0),
          if (content != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(content!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.style14Black50Weight400
                      .copyWith(color: AppColors.grey500Color)),
            )
        ],
      ),
    );
  }
}
