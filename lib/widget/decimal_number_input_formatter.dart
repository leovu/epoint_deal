import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:flutter/services.dart';

class DecimalNumberInputFormatter extends TextInputFormatter {
  final int? decimalNumber;

  DecimalNumberInputFormatter({this.decimalNumber});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text != "") {
      try {
        String newEvent = newValue.text;
        if(newEvent.endsWith(",")){
          newEvent = newEvent.replaceFirst(",", decimalSymbol, newEvent.length - 1);
        }
        String integer, decimal;
        List<String> valueSplit = newEvent.split(decimalSymbol);
        if(valueSplit.length > 1){
          integer = valueSplit.first;
          decimal = valueSplit.last;
        }
        else if(valueSplit.isEmpty){
          integer = newEvent;
          decimal = "";
        }
        else{
          integer = valueSplit.first;
          decimal = "";
        }

        if((decimalNumber ?? 0) > 0 && (decimal.length >= decimalNumber!)){
          decimal = decimal.substring(0, decimalNumber);
        }

        double value = parseMoney(integer);
        String newString;
        if(valueSplit.length <= 1){
          newString = formatMoney(value);
        }
        else{
          newString = "${formatMoney(value)}$decimalSymbol$decimal";
        }
        print("5-$newString");
        return TextEditingValue(
            text: newString,
            composing: newValue.composing,
            selection: TextSelection.collapsed(offset: newString.length));
      } catch (_) {
        return oldValue;
      }
    }

    return newValue;
  }
}
