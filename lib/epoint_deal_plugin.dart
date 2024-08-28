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
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:flutter/material.dart';

import 'epoint_deal_plugin_platform_interface.dart';

class EpointDealPlugin {
  Future<String?> getPlatformVersion() {
    return EpointDealPluginPlatform.instance.getPlatformVersion();
  }

  

  static Future<dynamic> open(
      BuildContext context, Locale locale, String token, int create,
      {String? domain,
      String? brandCode,
      String? deal_code,
      int? indexTabDetail,
      Function? getListProduct,
      Function? createJob,
      Function? editJob,
      Map<String,dynamic>? jsonDetail
      
      }) async {

    if (domain != null) {
      HTTPConnection.domain = domain;
      Global.domain = domain;
    }
    if (brandCode != null) {
      HTTPConnection.brandCode = brandCode;
      Global.brandCode = brandCode;
    }
    if (token != null) {
      HTTPConnection.asscessToken = token;
      Global.asscessToken = token;
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
    // GlobalCart.shared.init();

    DealConnection.locale = locale;
    Global.locale = locale;

    Globals.model = LoginResponseModel.fromJson({
        "staff_id": 1,
        "department_id": 1,
        "branch_id": 1,
        "staff_title_id": 1,
        "user_name": "admin@pioapps.vn",
        "password": "4V40OdbnuHIEhBQseOB1l.nP32mr1G/LFL0OQxibo/RTYO7m/v0xi",
        "salt": "900150983cd24fb0d6963f7d28e17f72",
        "full_name": "Admin Epoints",
        "birthday": "1986-10-17 00:00:00",
        "gender": "male",
        "phone1": "0352388084",
        "phone2": "",
        "email": "admin@pioapps.vn",
        "facebook": "",
        "date_last_login": "2024-08-23 17:37:25",
        "is_admin": 1,
        "is_actived": 1,
        "is_deleted": 0,
        "staff_avatar": null,
        "address": "51 Tân Thới Nhất 21, P.Tân Thới Nhất, Q.12, TP.HCM",
        "created_by": 1,
        "updated_by": 1,
        "created_at": "2018-10-03 02:24:40",
        "updated_at": "2024-08-23 17:37:25",
        "remember_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWZmLWFwaS5zdGFnLmVwb2ludHMudm4vdjIvdXNlci9sb2dpbiIsImlhdCI6MTcyNDQwOTQ0NSwiZXhwIjoxNzI0NDMxMDQ1LCJuYmYiOjE3MjQ0MDk0NDUsImp0aSI6ImRjRmFWYnZqWko0UTk2enAiLCJzdWIiOjEsInBydiI6ImEwZjNlNzRiZWRmNTEyYzQ3NzgyOTdkZTVmOTIwODZkYWQzOWNhOWYiLCJzaWQiOiJhZG1pbkBwaW9hcHBzLnZuIiwiYnJhbmRfY29kZSI6InFjIn0.BHorshzQ-qBJy0fM41msM7En6ui4X048kTeXFXlCyxI",
        "is_master": 1,
        "staff_code": "",
        "salary": "0.000",
        "subsidize": "0.000",
        "commission_rate": "1.000",
        "password_reset": "",
        "date_password_reset": null,
        "staff_type": "Nhân Viên Chính Thức",
        "password_chat": "123456",
        "is_allotment": null,
        "team_id": null,
        "staff_management_id": null,
        "bank_name": null,
        "bank_branch_name": null,
        "bank_number": null,
        "token_md5": "1a288e009b393c4a81b6107c7ff92d80",
        "staff_manager_id": null,
        "check_in_limit": 1,
        "department_name": "IT",
        "staff_title_name": "Quản trị hệ thống",
        "staff_manager_name": null,
        "branch_name": "BonBoz Clinic",
        "branch_code": "CN_2021010601",
        "branch_address": "21-23 Đồng Nai, Phường 15",
        "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWZmLWFwaS5zdGFnLmVwb2ludHMudm4vdjIvdXNlci9sb2dpbiIsImlhdCI6MTcyNDQxMjEwNiwiZXhwIjoxNzI0NDMzNzA2LCJuYmYiOjE3MjQ0MTIxMDYsImp0aSI6InFSdkRjZ0k1SUp0dDQ5VFIiLCJzdWIiOjEsInBydiI6ImEwZjNlNzRiZWRmNTEyYzQ3NzgyOTdkZTVmOTIwODZkYWQzOWNhOWYiLCJzaWQiOiJhZG1pbkBwaW9hcHBzLnZuIiwiYnJhbmRfY29kZSI6InFjIn0.MFH4CzQ23HxXuCR-xbKQ38mrQkr0h6DUZEh8tgO9kws",
        "queue_name": "",
        "queue_role": "",
        "oncall_info": {
            "host": "bonboz.phonenet.io",
            "extension_number": "100086",
            "extension_password": "123456789",
            "type": "callio"
        },
        "is_checkin_wifi": 0,
        "is_checkin_gps": 1,
        "link_get_ip": "https://api.ipify.org/",
        "decimal_number": "0",
        "is_disabled_price": 0
    });



    DealConnection.buildContext = context;
    AppSizes.init(context);
    await AppLocalizations(DealConnection.locale).load();
    bool result = await DealConnection.init(token, domain: domain);
    if (result) {
      if (create == 0) {
        Map<String, dynamic>? event = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateDealScreen()));
        return event;
      } else if (create == 1) {
       bool? result = await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => DetailDealScreen(
                  deal_code: deal_code,
                  indexTab: indexTabDetail ?? 0,
                )));
        return result;
      } else if (create == 2) {
        await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ListDealScreen()));
      } else {
        bool? result = await Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => CreateDealFromLeadScreen(jsonDetailLead: jsonDetail,)));

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
