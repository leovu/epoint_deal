
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