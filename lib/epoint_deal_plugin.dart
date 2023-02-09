import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/connection/http_connection.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/create_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/create_deal_from_lead/create_deal_from_lead_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/detail_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/list_deal/list_deal_screen.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:flutter/material.dart';

import 'epoint_deal_plugin_platform_interface.dart';

class EpointDealPlugin {
  Future<String> getPlatformVersion() {
    return EpointDealPluginPlatform.instance.getPlatformVersion();
  }

  

  static Future<dynamic> open(
      BuildContext context, Locale locale, String token, int create,
      {String domain,
      String brandCode,
      String deal_code,
      int indexTabDetail,
      Function getListProduct,
      Function createJob,
      Function editJob}) async {

        Map<String,dynamic> jsonDetail = {
        "avatar": null,
        "customer_lead_id": 256,
        "customer_lead_code": "LEAD_06022023256",
        "full_name": "Công ty TNHH DỊCH VỤ MINH LONG",
        "birthday": "2010-02-06 00:00:00",
        "phone": "0975123456",
        "hotline": null,
        "tax_code": null,
        "customer_source": 2,
        "customer_source_name": "Nguồn ABC",
        "customer_type": "business",
        "pipeline_code": "PIPELINE_0806202208",
        "pipeline_name": "Khách hàng tiềm năng 1",
        "journey_code": "PJD_CUSTOMER_NEW",
        "journey_name": "Mới",
        "email": "admin@minhlong.com",
        "gender": null,
        "province_id": 79,
        "province_type": "Thành Phố",
        "province_name": "Hồ Chí Minh",
        "district_id": 773,
        "district_type": "Quận",
        "district_name": "4",
        "ward_id": 27271,
        "ward_type": "Phường",
        "ward_name": "10",
        "address": "44 Nguyễn Tất Thành",
        "zalo": null,
        "zalo_id": null,
        "fanpage": null,
        "facebook_id": null,
        "sale_id": 204,
        "sale_name": "Dương Thanh Tâm",
        "is_convert": 0,
        "representative": "Lê Minh Long",
        "business_clue": null,
        "business_clue_name": null,
        "bussiness_id": 1,
        "business_name": "Truyền thông tin",
        "employees": 30,
        "time_revoke_lead": 30,
        "date_revoke": null,
        "allocation_date": "2023-02-06 17:54:13",
        "amount": null,
        "date_last_care": "2023-02-06 17:54:13",
        "tag": [
            {
                "tag_id": 7,
                "keyword": "tag2",
                "tag_name": "tag2"
            },
            {
                "tag_id": 8,
                "keyword": "tag3",
                "tag_name": "tag3"
            },
            {
                "tag_id": 9,
                "keyword": null,
                "tag_name": "abc"
            },
            {
                "tag_id": 10,
                "keyword": null,
                "tag_name": "456"
            }
        ],
        "diff_day": 3,
        "related_work": 0,
        "appointment": 0,
        "journey_tracking": [
            {
                "journey_code": "PJD_CUSTOMER_NEW",
                "journey_id": 27,
                "journey_name": "Mới",
                "pipeline_id": 8,
                "pipeline_code": "PIPELINE_0806202208",
                "background_color_journey": "#0066CC",
                "check": true
            },
            {
                "journey_code": "PJD_CUSTOMER_FAIL",
                "journey_id": 28,
                "journey_name": "Thất bại",
                "pipeline_id": 8,
                "pipeline_code": "PIPELINE_0806202208",
                "background_color_journey": null,
                "check": false
            },
            {
                "journey_code": "PJD_CUSTOMER_SUCCESS",
                "journey_id": 29,
                "journey_name": "Thành công",
                "pipeline_id": 8,
                "pipeline_code": "PIPELINE_0806202208",
                "background_color_journey": null,
                "check": false
            }
        ]
    };


    if (domain != null) {
      HTTPConnection.domain = domain;
    }
    if (brandCode != null) {
      HTTPConnection.brandCode = brandCode;
    }
    if (token != null) {
      HTTPConnection.asscessToken = token;
    }

    if (getListProduct != null) {
      Global.getListProduct = getListProduct;
    }

    if (createJob != null) {
      Global.createJob = createJob;
    }
    if (editJob != null) {
      Global.editJob = editJob;
    }

    Global.branch_code = brandCode;
    GlobalCart.shared.init();

    DealConnection.locale = locale;
    DealConnection.buildContext = context;
    AppSizes.init(context);
    await AppLocalizations(DealConnection.locale).load();
    bool result = await DealConnection.init(token, domain: domain);
    if (result) {
      if (create == 0) {
        Map<String, dynamic> event = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateDealScreen()));
        return event;
      } else if (create == 1) {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailDealScreen(
                  deal_code: deal_code,
                  indexTab: indexTabDetail ?? 0,
                )));
        return null;
      } else if (create == 2) {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ListDealScreen()));
      } else {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateDealFromLeadScreen(jsonDetailLead: jsonDetail,)));
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
