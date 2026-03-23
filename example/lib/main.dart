import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:flutter/material.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await PatchAllLocales.patchNumberSeperators(
  //   patchForSamsungKeyboards: true,
  // );
  runApp(const MaterialApp(
    locale: Locale('vi', 'VN'),
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
// final Locale locale;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: InkWell(
            child: const Text("Open deal"),
            onTap: () {
              EpointDealPlugin.open(
                  context,
                  const Locale(LangKey.langEn, 'en'),
                  'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWZmLWFwaS5kZXYubWF0dGhld3NsaXF1b3IuY29tLmF1L3VzZXIvbG9naW4iLCJpYXQiOjE3NzQyMzkwMTksImV4cCI6MTc3NDI2MDYxOSwibmJmIjoxNzc0MjM5MDE5LCJqdGkiOiJPOWhCWDE1N0JFRkg3QWIwIiwic3ViIjoyMDcsInBydiI6ImEwZjNlNzRiZWRmNTEyYzQ3NzgyOTdkZTVmOTIwODZkYWQzOWNhOWYiLCJzaWQiOiJhZG1pbkBtYXR0aGV3c2xpcXVvci5jb20iLCJwaG9uZSI6ImFkbWluQG1hdHRoZXdzbGlxdW9yLmNvbSIsImJyYW5kX2NvZGUiOiJtYXR0aGV3c2xpcXVvciIsImltZWkiOiI0MjY3OGQzZGQ2MGUzZmJjIn0.YY4v7sTNT1ZiQEWZJSXR0ICpHhtmEy_rqF_nLnoUM7U',
                  2,
                  {},
                  jsonDetail: jsonDetail,
                  domain: 'https://staff-api.dev.matthewsliquor.com.au',
                  brandCode: 'matthewsliquor');
            },
          ),
        ),
      ),
    );
  }
}

Map<String, dynamic>? jsonDetail = {
  "deal_id": 18,
  "deal_code": "DEALS_1903202618",
  "deal_name": "deal test",
  "phone": "0708983434",
  "type_customer": "lead",
  "customer_code": "LEAD_18032026441",
  "pipeline_code": "PIPELINE_1903202604",
  "pipeline_name": "Pipeline Test Deal 1",
  "journey_name": "Journey Test 1",
  "journey_code": "JOURNEY_1903202620",
  "background_color_journey": null,
  "closing_date": "2026-03-19",
  "closing_due_date": null,
  "reason_lose_code": null,
  "branch_code": "CN_0104202202",
  "branch_id": null,
  "branch_name": "Office Australia",
  "order_source_id": 2,
  "order_source_name": "Order online",
  "tag": [
    {"tag_id": 5, "type": "tag", "keyword": null, "name": "Tag test 1"}
  ],
  "probability": 50,
  "deal_description": "test hehe",
  "sale_id": 305,
  "staff_name": "TEST XONG ĂN TẾT",
  "time_revoke_lead": 1000,
  "created_at": "2026-03-19 13:05:46",
  "updated_at": "2026-03-19 09:05:48",
  "date_last_care": "2026-03-19 20:05:46",
  "expected_revenue": 100000,
  "total": 49040,
  "discount": 0,
  "discount_type": null,
  "discount_value": 0,
  "voucher_code": null,
  "total_other_fee": 0,
  "amount_before_vat": 49040,
  "total_vat": 0,
  "amount": 49040,
  "is_convert": 0,
  "convert_object_type": null,
  "convert_object_id": null,
  "customer_name": "name test",
  "customer_avatar": null,
  "customer_source_name": "Online",
  "customer_email": null,
  "customer_gender": null,
  "province": "Northern Territory",
  "district": "LEE POINT",
  "ward": null,
  "address": "name house",
  "business_clue": null,
  "fanpage": null,
  "zalo": null,
  "diff_day": 1,
  "related_work": 1,
  "appointment": 0,
  "journey_tracking": [
    {
      "journey_code": "9",
      "journey_id": 18,
      "journey_name": "Start",
      "pipeline_id": 4,
      "pipeline_code": "PIPELINE_1903202604",
      "background_color_journey": null,
      "check": true
    },
    {
      "journey_code": "10",
      "journey_id": 19,
      "journey_name": "End",
      "pipeline_id": 4,
      "pipeline_code": "PIPELINE_1903202604",
      "background_color_journey": null,
      "check": true
    },
    {
      "journey_code": "JOURNEY_1903202620",
      "journey_id": 20,
      "journey_name": "Journey Test 1",
      "pipeline_id": 4,
      "pipeline_code": "PIPELINE_1903202604",
      "background_color_journey": null,
      "check": true
    },
    {
      "journey_code": "JOURNEY_1903202621",
      "journey_id": 21,
      "journey_name": "Journey Test 2",
      "pipeline_id": 4,
      "pipeline_code": "PIPELINE_1903202604",
      "background_color_journey": null,
      "check": false
    }
  ],
  "product_buy": [
    {
      "deal_detail_id": 28,
      "deal_code": "DEALS_1903202618",
      "object_id": 1,
      "object_name": "Margaret River Skywater Bay Rose'/12Pack",
      "object_type": "product",
      "object_code": "9963|12",
      "price": 100,
      "quantity": 10,
      "position": null,
      "discount": 10,
      "discount_value": 10,
      "discount_type": "money",
      "amount": 1000,
      "voucher_code": null,
      "object_description": "NOTE TEST",
      "unit_id": 3,
      "unit_name": "pack",
      "products_description": null,
      "product_id": 1,
      "product_child_type": "conversion",
      "product_child_base_id": 3,
      "service_other_flag_id": null,
      "service_other_flag_name": null
    },
    {
      "deal_detail_id": 29,
      "deal_code": "DEALS_1903202618",
      "object_id": 2,
      "object_name": "Margaret River Skywater Bay Rose'/6 Pack",
      "object_type": "product",
      "object_code": "9963|6",
      "price": 200,
      "quantity": 100,
      "position": null,
      "discount": 2000,
      "discount_value": 10,
      "discount_type": "percent",
      "amount": 20000,
      "voucher_code": null,
      "object_description": "NOTE TEST 2",
      "unit_id": 2,
      "unit_name": "case",
      "products_description": null,
      "product_id": 1,
      "product_child_type": "conversion",
      "product_child_base_id": 3,
      "service_other_flag_id": null,
      "service_other_flag_name": null
    },
    {
      "deal_detail_id": 30,
      "deal_code": "DEALS_1903202618",
      "object_id": 2172,
      "object_name": "Hahn Ultra Low Carb Bt 330Ml/6pk",
      "object_type": "product",
      "object_code": "9780|6",
      "price": 300,
      "quantity": 100,
      "position": null,
      "discount": 0,
      "discount_value": 0,
      "discount_type": null,
      "amount": 30000,
      "voucher_code": null,
      "object_description": null,
      "unit_id": 3,
      "unit_name": "pack",
      "products_description": null,
      "product_id": 714,
      "product_child_type": "conversion",
      "product_child_base_id": 2173,
      "service_other_flag_id": null,
      "service_other_flag_name": null
    },
    {
      "deal_detail_id": 31,
      "deal_code": "DEALS_1903202618",
      "object_id": 21864,
      "object_name": "Carlton Pure Blonde Bt 355Ml/Case",
      "object_type": "product",
      "object_code": "226|24",
      "price": 50,
      "quantity": 1,
      "position": null,
      "discount": 0,
      "discount_value": 0,
      "discount_type": null,
      "amount": 50,
      "voucher_code": null,
      "object_description": null,
      "unit_id": 2,
      "unit_name": "case",
      "products_description": null,
      "product_id": 7326,
      "product_child_type": "conversion",
      "product_child_base_id": 21866,
      "service_other_flag_id": null,
      "service_other_flag_name": null
    }
  ],
  "product_name_buy":
      "Margaret River Skywater Bay Rose'/12Pack, Margaret River Skywater Bay Rose'/6 Pack, Hahn Ultra Low Carb Bt 330Ml/6pk, Carlton Pure Blonde Bt 355Ml/Case",
  "other_fee": [],
  "tab_configs": [
    {
      "code": "order",
      "tab_name_vi": "ĐƠN HÀNG",
      "tab_name_en": "ORDERS",
      "total": 0
    },
    {
      "code": "product",
      "tab_name_vi": "SẢN PHẨM",
      "tab_name_en": "PRODUCTS",
      "total": 4
    },
    {
      "code": "care",
      "tab_name_vi": "CHĂM SÓC",
      "tab_name_en": "CARE",
      "total": 0
    },
    {
      "code": "note",
      "tab_name_vi": "GHI CHÚ",
      "tab_name_en": "NOTES",
      "total": 1
    },
    {
      "code": "file",
      "tab_name_vi": "TẬP TIN",
      "tab_name_en": "FILES",
      "total": 0
    }
  ]
};
