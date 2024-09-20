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
      Function(Map<String,dynamic>)? createJob,
      Function(Map<String,dynamic>)?  createCare,
      Function(int)?  editJob,
      Function(Map<String,dynamic>)?  createOrder,
      Map<String,dynamic>? jsonDetail, // để tạo deal từ lead
      }) async {

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

    if (createOrder != null) {
      Global.createOrder = createOrder;
    }

    Global.branch_code = brandCode;
    // GlobalCart.shared.init();

    DealConnection.locale = locale;
    Global.locale = locale;

    Globals.model = LoginResponseModel.fromJson(loginResponseModel!);
    // Globals.model = LoginResponseModel.fromJson({
    //     "staff_id": 1,
    //     "department_id": 1,
    //     "branch_id": 1,
    //     "staff_title_id": 1,
    //     "user_name": "admin@pioapps.vn",
    //     "password": "4V40OdbnuHIEhBQseOB1l.nP32mr1G/LFL0OQxibo/RTYO7m/v0xi",
    //     "salt": "900150983cd24fb0d6963f7d28e17f72",
    //     "full_name": "Admin Epoints",
    //     "birthday": "1986-10-17 00:00:00",
    //     "gender": "male",
    //     "phone1": "0352388084",
    //     "phone2": "",
    //     "email": "admin@pioapps.vn",
    //     "facebook": "",
    //     "date_last_login": "2024-08-23 17:37:25",
    //     "is_admin": 1,
    //     "is_actived": 1,
    //     "is_deleted": 0,
    //     "staff_avatar": null,
    //     "address": "51 Tân Thới Nhất 21, P.Tân Thới Nhất, Q.12, TP.HCM",
    //     "created_by": 1,
    //     "updated_by": 1,
    //     "created_at": "2018-10-03 02:24:40",
    //     "updated_at": "2024-08-23 17:37:25",
    //     "remember_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWZmLWFwaS5zdGFnLmVwb2ludHMudm4vdjIvdXNlci9sb2dpbiIsImlhdCI6MTcyNDQwOTQ0NSwiZXhwIjoxNzI0NDMxMDQ1LCJuYmYiOjE3MjQ0MDk0NDUsImp0aSI6ImRjRmFWYnZqWko0UTk2enAiLCJzdWIiOjEsInBydiI6ImEwZjNlNzRiZWRmNTEyYzQ3NzgyOTdkZTVmOTIwODZkYWQzOWNhOWYiLCJzaWQiOiJhZG1pbkBwaW9hcHBzLnZuIiwiYnJhbmRfY29kZSI6InFjIn0.BHorshzQ-qBJy0fM41msM7En6ui4X048kTeXFXlCyxI",
    //     "is_master": 1,
    //     "staff_code": "",
    //     "salary": "0.000",
    //     "subsidize": "0.000",
    //     "commission_rate": "1.000",
    //     "password_reset": "",
    //     "date_password_reset": null,
    //     "staff_type": "Nhân Viên Chính Thức",
    //     "password_chat": "123456",
    //     "is_allotment": null,
    //     "team_id": null,
    //     "staff_management_id": null,
    //     "bank_name": null,
    //     "bank_branch_name": null,
    //     "bank_number": null,
    //     "token_md5": "1a288e009b393c4a81b6107c7ff92d80",
    //     "staff_manager_id": null,
    //     "check_in_limit": 1,
    //     "department_name": "IT",
    //     "staff_title_name": "Quản trị hệ thống",
    //     "staff_manager_name": null,
    //     "branch_name": "BonBoz Clinic",
    //     "branch_code": "CN_2021010601",
    //     "branch_address": "21-23 Đồng Nai, Phường 15",
    //     "access_token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWZmLWFwaS5zdGFnLmVwb2ludHMudm4vdjIvdXNlci9sb2dpbiIsImlhdCI6MTcyNDQxMjEwNiwiZXhwIjoxNzI0NDMzNzA2LCJuYmYiOjE3MjQ0MTIxMDYsImp0aSI6InFSdkRjZ0k1SUp0dDQ5VFIiLCJzdWIiOjEsInBydiI6ImEwZjNlNzRiZWRmNTEyYzQ3NzgyOTdkZTVmOTIwODZkYWQzOWNhOWYiLCJzaWQiOiJhZG1pbkBwaW9hcHBzLnZuIiwiYnJhbmRfY29kZSI6InFjIn0.MFH4CzQ23HxXuCR-xbKQ38mrQkr0h6DUZEh8tgO9kws",
    //     "queue_name": "",
    //     "queue_role": "",
    //     "oncall_info": {
    //         "host": "bonboz.phonenet.io",
    //         "extension_number": "100086",
    //         "extension_password": "123456789",
    //         "type": "callio"
    //     },
    //     "is_checkin_wifi": 0,
    //     "is_checkin_gps": 1,
    //     "link_get_ip": "https://api.ipify.org/",
    //     "decimal_number": "0",
    //     "is_disabled_price": 0
    // });

    jsonDetail = {
        "avatar": null,
        "customer_lead_id": 1310,
        "customer_lead_code": "LEAD_220820241310",
        "full_name": "ductttttttt",
        "birthday": "2000-10-20 00:00:00",
        "phone": "0123456789",
        "hotline": null,
        "tax_code": null,
        "customer_source": 3,
        "customer_source_name": "Giới thiệu",
        "customer_type": "business",
        "pipeline_code": "PIPELINE_1201202201",
        "pipeline_name": null,
        "journey_code": "JOURNEY_1210202313",
        "journey_name": "Suy nghĩ thêm",
        "email": "vund@gmail.com",
        "gender": "male",
        "province_id": 1,
        "province_type": "Thành Phố",
        "province_name": "Hà Nội",
        "district_id": 1,
        "district_type": "Quận",
        "district_name": "Ba Đình",
        "ward_id": 1,
        "ward_type": "Phường",
        "ward_name": "Phúc Xá",
        "address": "12 CMT8 abc",
        "zalo": "WAO",
        "zalo_id": null,
        "fanpage": "wao",
        "facebook_id": null,
        "sale_id": 96,
        "sale_name": "Đoàn Huỳnh Ngọc Hân",
        "is_convert": 0,
        "representative": "phu",
        "business_clue": "123ABC",
        "business_clue_name": null,
        "bussiness_id": 1,
        "business_name": "NÔNG NGHIỆP, LÂM NGHIỆP VÀ THỦY SẢN",
        "employees": 244,
        "time_revoke_lead": null,
        "date_revoke": "2024-09-12 17:31:49",
        "allocation_date": "2024-09-12 17:31:49",
        "amount": 0,
        "date_last_care": "2024-08-22 22:42:24",
        "customer_type_name": "Doanh nghiệp",
        "customer_group_id": 1,
        "customer_group_name": "Mặc định",
        "customer_lead_refer_id": 3,
        "customer_lead_refer_name": "Hoàng đăng ý thảo",
        "gender_vi": "Nam",
        "branch_code": null,
        "branch_name": null,
        "employ_qty": 0,
        "created_at": "2024-08-22 22:42:24",
        "created_by_name": "Admin Epoints",
        "updated_at": "2024-08-24 16:24:30",
        "updated_by_name": "Admin Epoints",
        "assign_by": 1,
        "assign_by_name": "Admin Epoints",
        "note": "note",
        "tag": [
            {
                "tag_id": 5,
                "keyword": "lieu-trinh-da",
                "tag_name": "Liệu Trình Da "
            }
        ],
        "diff_day": 26,
        "related_work": 0,
        "appointment": 0,
        "journey_tracking": [],
        "full_address": "12 CMT8 abc, Phúc Xá, Ba Đình, Hà Nội",
        "customer_contact_id": 7,
        "customer_contact_name": "phu phu",
        "tab_configs": [
            {
                "code": "deal",
                "tab_name_vi": "CƠ HỘI BÁN HÀNG",
                "tab_name_en": "DEAL",
                "total": 3
            },
            {
                "code": "care",
                "tab_name_vi": "CHĂM SÓC KHÁCH HÀNG",
                "tab_name_en": "CARE",
                "total": 0
            },
            {
                "code": "contact",
                "tab_name_vi": "NGƯỜI LIÊN HỆ",
                "tab_name_en": "CONTACT",
                "total": 4
            },
            {
                "code": "note",
                "tab_name_vi": "GHI CHÚ",
                "tab_name_en": "NOTES",
                "total": 3
            },
            {
                "code": "file",
                "tab_name_vi": "TẬP TIN",
                "tab_name_en": "FILES",
                "total": 2
            }
        ]
    };



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
