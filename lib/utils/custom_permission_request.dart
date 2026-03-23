import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

enum PermissionRequestType {
  CAMERA,
  LOCATION,
  STORAGE,
  NOTIFICATION,
  MICROPHONE,
}

class CustomPermissionRequest {
  static Future<bool> request(
      BuildContext context, PermissionRequestType type) async {
    final permission = _toPermission(type);
    final status = await permission.request();

    if (status.isGranted) return true;

    if (status.isPermanentlyDenied) {
      String? permissionName;
      if (type == PermissionRequestType.CAMERA) {
        permissionName = AppLocalizations.text(LangKey.camera);
      } else if (type == PermissionRequestType.LOCATION) {
        permissionName = AppLocalizations.text(LangKey.location);
      } else if (type == PermissionRequestType.STORAGE) {
        permissionName = AppLocalizations.text(LangKey.storage);
      } else if (type == PermissionRequestType.NOTIFICATION) {
        permissionName = AppLocalizations.text(LangKey.notification);
      }
      DealConnection.showMyDialogWithFunction(
        context,
        "${AppLocalizations.text(LangKey.message_permission)} $permissionName",
        ontap: () {
          Navigator.pop(context);
          openAppSettings();
        },
      );
    }

    return false;
  }

  static Future<bool> check(PermissionRequestType type) async {
    return (await _toPermission(type).status).isGranted;
  }

  static Permission _toPermission(PermissionRequestType type) {
    switch (type) {
      case PermissionRequestType.CAMERA:
        return Permission.camera;
      case PermissionRequestType.LOCATION:
        return Permission.location;
      case PermissionRequestType.STORAGE:
        return Permission.storage;
      case PermissionRequestType.NOTIFICATION:
        return Permission.notification;
      case PermissionRequestType.MICROPHONE:
        return Permission.microphone;
    }
  }
}

/// Kept for backward compatibility with any direct usages in host apps.
class PermissionRequest {
  static void openSetting() => openAppSettings();

  static Future<bool> request(
      PermissionRequestType type, Function onDontAskAgain) async {
    final permission = CustomPermissionRequest._toPermission(type);
    final status = await permission.request();
    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) onDontAskAgain();
    return false;
  }

  static Future<bool> check(PermissionRequestType type) async {
    return (await CustomPermissionRequest._toPermission(type).status).isGranted;
  }
}
