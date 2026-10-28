library progress_dialog;

import 'dart:io';

import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class ProgressDialog {
  bool _isShowing = false;

  BuildContext? buildContext;

  ProgressDialog(this.buildContext);

  show() {
    _showDialog();
    _isShowing = true;
  }

  bool isShowing() {
    return _isShowing;
  }

  hide() {
    _isShowing = false;
    Navigator.of(buildContext!).pop();
  }

  _showDialog() {
    Navigator.of(buildContext!, rootNavigator: true).push(
      PageRouteBuilder(
        opaque: false,
        // settings: RouteSettings(name: AppKeys.keyHUD),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return PopScope(
            child: Scaffold(
              backgroundColor: AppGlass.barrierColor,
              body: Container(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Platform.isAndroid?CircularProgressIndicator():CupertinoActivityIndicator(),
                ),
              ),
            ),
            canPop: false,
          );
        },
      ),
    );
  }
}