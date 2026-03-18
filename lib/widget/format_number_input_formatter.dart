
import 'package:flutter/services.dart';
import 'package:intl/intl.dart' as intl;

class FormatNumberInputFormatter extends TextInputFormatter {

  final intl.NumberFormat format;

  FormatNumberInputFormatter(this.format);

  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if(newValue.text != ""){
      try{
        double number = double.parse(newValue.text);

        String value = format.format(number);

        return TextEditingValue(
            text: value,
            composing: newValue.composing,
            selection: TextSelection.collapsed(offset: value.length)
        );

      }
      catch(_){return oldValue;}
    }

    return newValue;
  }
}