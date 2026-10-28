
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield_lead.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSearchLocation extends StatelessWidget {
  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final String? hint;
  final TextInputType? inputType;
  final String? suffixIcon;
  final GestureTapCallback? onTapSuffix;
  final TextSelectionControls? selectionControls;
  final List<TextInputFormatter>? inputFormatters;
   CustomSearchLocation(this.focusNode, this.controller, this.onChanged,
      {this.hint, this.inputType, this.inputFormatters, this.onSubmitted, this.selectionControls, this.suffixIcon, this.onTapSuffix});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(AppSizes.minPadding),
      child: CustomTextField(
        keyboardType: inputType != null ? inputType : TextInputType.text,
        prefixIcon: Assets.iconSearch,
        prefixIconColor: AppColors.textSecondaryColor,selectionControls: selectionControls,
        hintText:
            hint != null ? hint : AppLocalizations.text(LangKey.enter_keyword),
        controller: controller,
        focusNode: focusNode,
        radius: AppRadius.sm,
        inputFormatters: inputFormatters,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.textSecondaryColor,
        onSuffixIconTap: onTapSuffix,
        textInputAction: TextInputAction.search,
      ),
    );
  }
}
