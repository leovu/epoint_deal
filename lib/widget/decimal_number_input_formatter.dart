import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:flutter/services.dart';

class DecimalNumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text != "") {
      try {
        String value = newValue.text.replaceAll(",", decimalSympol);
        TextSelection? selection;
        if (decimalSympol.allMatches(value).length > 1) {
          value = value.substring(0, value.length - 1);
          selection = TextSelection.collapsed(offset: value.length);
        }

        if (value == decimalSympol) {
          value = "0.";
          selection = TextSelection.collapsed(offset: value.length);
        }

        return TextEditingValue(
            text: value,
            composing: newValue.composing,
            selection: selection ?? newValue.selection);
      } catch (_) {
        return oldValue;
      }
    }
    return newValue;
  }
}
