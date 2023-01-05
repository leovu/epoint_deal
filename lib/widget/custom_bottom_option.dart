import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_line.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';

class CustomBottomOption extends StatelessWidget {

  final List<CustomBottomOptionModel> options;

  CustomBottomOption({this.options});

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      shrinkWrap: true,
      separator: CustomLine(),
      children: (options?.length ?? 0) == 0? [CustomEmpty(
        title: AppLocalizations.text(LangKey.data_empty),
      )]: options.map((e) => InkWell(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            children: [
              e.icon == null?Container():Container(
                padding: EdgeInsets.only(right: 10.0),
                child: CustomImageIcon(
                  icon: e.icon,
                  size: 15.0,
                  color: e.textColor ?? Color(0xFFD8D8D8),
                ),
              ),
              Expanded(
                child: Text(
                  e.text ?? "",
                  style: AppTextStyles.style15BlackNormal.copyWith(
                      color: e.textColor ?? AppColors.black
                  ),
                ),
              ),
              if(e.isSelected != null && e.isSelected)
                Container(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.check,
                    color: AppColors.primaryColor,
                    size: 15.0,
                  ),
                )
            ],
          ),
        ),
        onTap: e.onTap,
      )).toList()
    );
  }
}

class CustomBottomOptionModel{
  final String icon;
  final String text;
  final Color textColor;
  final bool isSelected;
  final Function onTap;

  CustomBottomOptionModel({this.icon, this.text, this.textColor, this.isSelected, this.onTap});
}