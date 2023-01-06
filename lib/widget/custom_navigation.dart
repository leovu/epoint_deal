import 'package:epoint_deal_plugin/widget/custom_route.dart';
import 'package:flutter/material.dart';

import '../utils/progress_dialog.dart';

class CustomNavigator {
   static showCustomBottomDialog(BuildContext context, Widget screen,
      {bool root = true, isScrollControlled = true, Function func, allowBack= false, disMissAble = true}) {

    return showModalBottomSheet(
        context: context,
        isDismissible: disMissAble,
        useRootNavigator: root,
        isScrollControlled: isScrollControlled,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return GestureDetector(
            child: screen,
            onTap: func ?? () {
              if(allowBack){
                Navigator.pop(context);
              }
            },
            behavior: HitTestBehavior.opaque,
          );
        });
  }

   static pushReplacement(BuildContext context, Widget screen,
      {bool root = true}) {
    // Navigator.of(context, rootNavigator: root).removeHUD();
    Navigator.of(context, rootNavigator: root).pushReplacement(
        CustomRoute(page: screen));
  }

   static canPop(BuildContext context) {
    ModalRoute<dynamic> parentRoute = ModalRoute.of(context);
    return parentRoute?.canPop ?? false;
  }

    static ProgressDialog _pr;
  static showProgressDialog(BuildContext context) {
    if (_pr == null) {
      _pr = ProgressDialog(context);
      _pr.show();
    }
  }

   static hideProgressDialog() {
    if (_pr != null && _pr.isShowing()) {
      _pr.hide();
      _pr = null;
    }
  }
}