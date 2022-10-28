
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/connection/http_connection.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/create_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/detail_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/list_deal/list_deal_screen.dart';
import 'package:flutter/material.dart';

import 'epoint_deal_plugin_platform_interface.dart';

class EpointDealPlugin {
  Future<String> getPlatformVersion() {
    return EpointDealPluginPlatform.instance.getPlatformVersion();
  }

  static Future<dynamic>open(BuildContext context, Locale locale,String token, int create, {String domain, String brandCode, String deal_code , Function addMoreProduct, Function createJob}) async {
    if(domain != null) {
      HTTPConnection.domain = domain;
    }
    if(brandCode != null) {
      HTTPConnection.brandCode = brandCode;
    }
    if(token != null) {
      HTTPConnection.asscessToken = token;
    }

    if (addMoreProduct != null) {
      Global.addMoreProduct = addMoreProduct;

    }

    if (createJob != null) {
      Global.createJob = createJob;

    }


    DealConnection.locale = locale;
    DealConnection.buildContext = context;
    await AppLocalizations(DealConnection.locale).load();
    bool result = await DealConnection.init(token,domain: domain);
    if(result) {
      if (create == 0 ) {
        Map<String, dynamic> event =  await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => CreateDealScreen()));
        return event;
      } else if (create == 1) {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => DetailDealScreen(deal_code: deal_code,)));
        return null;
      } else {
        await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ListDealScreen()));
      }
    }else {
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

