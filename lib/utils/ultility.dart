
import 'package:flutter/material.dart';

void keyboardDismissOnTap(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  FocusScopeNode rootScope = WidgetsBinding.instance.focusManager.rootScope;

  if (currentFocus != rootScope) {
    if (currentFocus.hasFocus && !currentFocus.hasPrimaryFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

extension IterableModifier<E> on Iterable<E> {
  E firstWhereOrNull(bool Function(E) test) =>
      cast<E>().firstWhere((v) => v != null && test(v), orElse: () => null);
}

class Validators {
  var validatePhone = RegExp(r'(0)+([0-9]{9,10})\b');
  var validateNumber = RegExp(r"^[\d]*$");

 bool isValidPhone(String phone){
    if (phone!=null&&phone.isNotEmpty&&validatePhone.hasMatch(phone)){
      return true;
    }
    return false;
  }

  bool isNumber(String number){
    if (number!=null&&number.isNotEmpty&&validateNumber.hasMatch(number)){
      return true;
    }
    return false;
  }

}

// extension NavigatorStateExtension on NavigatorState {
//   removeHUD() {
//     bool isHUDOn = false;
//     popUntil((route) {
//       if (route.settings.name == AppKeys.keyHUD) {
//         isHUDOn = true;
//       }
//       return true;
//     });

//     if(isHUDOn)
//       CustomNavigator.hideProgressDialog();
//   }
// }