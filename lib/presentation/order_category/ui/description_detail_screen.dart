import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_html.dart';
import 'package:flutter/material.dart';

class DescriptionDetailScreen extends StatefulWidget {

  final String? html;

  DescriptionDetailScreen(this.html);

  @override
  DescriptionDetailScreenState createState() => DescriptionDetailScreenState();
}

class DescriptionDetailScreenState extends State<DescriptionDetailScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: AppLocalizations.text(LangKey.detail_description),
      body: CustomHtml(widget.html),
    );
  }
}
