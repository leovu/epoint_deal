import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/connection/http_connection.dart';
import 'package:epoint_deal_plugin/model/response/login_response_model.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/create_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/create_deal_from_lead/create_deal_from_lead_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/detail_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/list_deal/list_deal_screen.dart';
import 'package:flutter/material.dart';
import 'epoint_deal_plugin_platform_interface.dart';

class EpointDealPlugin {
  Future<String?> getPlatformVersion() {
    return EpointDealPluginPlatform.instance.getPlatformVersion();
  }

  

  static Future<dynamic> open(
      BuildContext context, Locale locale, String token, int type,Map<String,dynamic>? loginResponseModel,
      {String? domain,
      String? brandCode,
      String? deal_code,
      int? indexTabDetail,
      Function? getListProduct,
      Function? createJob,
      Function(Map<String,dynamic>)?  createCare,
      Function(int)? editJob,
      Function(int)? navigateDetailOrder,
      Function(Map<String,dynamic>)? callHotline,
      Map<String,dynamic>? jsonDetail, // để tạo deal từ lead
      List<Map<String, dynamic>>? permission

      }) async {

    if (permission != null) {
        Global.permissionModels = permission;
    }

    if (domain != null) {
      HTTPConnection.domain = domain;
      Global.domain = domain;
    }
    if (brandCode != null) {
      HTTPConnection.brandCode = brandCode;
      Global.brandCode = brandCode;
    }
    HTTPConnection.asscessToken = token;
    Global.asscessToken = token;

    if (getListProduct != null) {
      Global.getListProduct = getListProduct;
    }

    if (createJob != null) {
      Global.createJob = createJob;
    }
    if (editJob != null) {
      Global.editJob = editJob;
    }

    if (createCare != null) {
      Global.createCare = createCare;
    }

    if (navigateDetailOrder != null) {
      Global.navigateDetailOrder = navigateDetailOrder;
    }

    if (callHotline != null) {
      Global.callHotline = callHotline;
    }

    Global.branch_code = brandCode;

    DealConnection.locale = locale;
    Global.locale = locale;

    Globals.model = LoginResponseModel.fromJson(loginResponseModel!);


    DealConnection.buildContext = context;
    AppSizes.init(context);
    await AppLocalizations(DealConnection.locale).load();
    bool result = await DealConnection.init(token, domain: domain);
    if (result) {
      if (type == 0) {
        Map<String, dynamic>? event = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateDealScreen()));
        return event;
      } else if (type == 1) {
       bool? result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailDealScreen(
                  deal_code: deal_code,
                  indexTab: indexTabDetail ?? 0,
                )));
        return result;
      } else if (type == 2) {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ListDealScreen()));
      } else {
        bool? result = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateDealFromLeadScreen(jsonDetailLead: jsonDetail,)));
          print("result: $result");
          return result;
      }
    } else {
      loginError(DealConnection.buildContext, 'Fail');
      return null;
    }
  }

  static void loginError(BuildContext context, String title) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title:  Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                    child: Text(
                  'Cảnh báo\n',
                  style:
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                )),
                Center(child: Text(title)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Center(child: Text('Đồng ý')),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
