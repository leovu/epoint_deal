import 'dart:io';
import 'package:epoint_deal_plugin/connection/http_connection.dart';
import 'package:epoint_deal_plugin/model/acount.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/list_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/description_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_allocator_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_option_model_response.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class DealConnection {
  
  static  BuildContext buildContext;
  static HTTPConnection connection = HTTPConnection();
  static Account account;
  // static Locale locale = Locale('vi', 'VN');
  static  Locale locale;

  static Future<bool> init(String token, {String domain}) async {
    if (domain != null) {
      HTTPConnection.domain = domain;
      HTTPConnection.asscessToken = token;
       return true;
    } else {
      return false;
    }
  }

  static Future<ListDealModelResponse> getList(
      BuildContext context, ListDealModelRequest model) async {
    showLoading(context);
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/list-deal', model.toJson());
    Navigator.of(context).pop();
    if (responseData.isSuccess) {
      if (responseData.data != null) {
        ListDealModelResponse data =
            ListDealModelResponse.fromJson(responseData.data);
        return data;
      }
      return null;
    }
    return null;
  }

  static Future<DetailDealModelResponse> getdetailPotential(
      BuildContext context, String deal_code) async {
    showLoading(context);
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/detail-deal',
        {"deal_code": deal_code});
    Navigator.of(context).pop();
    if (responseData.isSuccess) {
      DetailDealModelResponse data =
          DetailDealModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

  static Future<BranchModelResponse> getBranch(
      BuildContext context) async {
    ResponseData responseData = await connection
        .post('/customer-lead/customer-lead/get-branch', {});
    if (responseData.isSuccess) {
      BranchModelResponse data =
          BranchModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

   static Future<GetCustomerOptionModelReponse> getCustomerOption(
      BuildContext context) async {
    ResponseData responseData = await connection
        .post('/customer-lead/customer-lead/get-customer-option', {});
    if (responseData.isSuccess) {
      GetCustomerOptionModelReponse data =
          GetCustomerOptionModelReponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }
  

    static Future<OrderSourceModelResponse> getOrderSource(
      BuildContext context) async {
    ResponseData responseData = await connection
        .post('/customer-lead/customer-lead/get-order-source', {});
    if (responseData.isSuccess) {
      OrderSourceModelResponse data =
          OrderSourceModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }


  static Future<GetPipelineModelReponse> getPipeline(
      BuildContext context) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/get-pipeline',
        {"pipeline_category_code": "CUSTOMER"});
    if (responseData.isSuccess) {
      GetPipelineModelReponse data =
          GetPipelineModelReponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

  static Future<GetJourneyModelReponse> getJourney(
      BuildContext context, String pipeline_code) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/get-journey',
        {"pipeline_code": pipeline_code});
    if (responseData.isSuccess) {
      GetJourneyModelReponse data =
          GetJourneyModelReponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }


  static Future<GetAllocatorModelReponse> getAllocator(
      BuildContext context) async {
    ResponseData responseData =
        await connection.post('/customer-lead/customer-lead/get-allocator', {});
    if (responseData.isSuccess) {
      GetAllocatorModelReponse data =
          GetAllocatorModelReponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

  static Future<AddDealModelRequest> addLead(
      BuildContext context, AddDealModelRequest model) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/add-deals', model.toJson());
    // if (responseData.isSuccess) {
    //   AddLeadModelResponse data =
    //       AddLeadModelResponse.fromJson(responseData.data);
    //   return data;
    // }
    return null;
  }

  static Future<DescriptionModelResponse> deleteDeal(
      BuildContext context, String deal_code) async {
    showLoading(context);
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/delete-deal',
        {"customer_lead_code": deal_code});
    Navigator.of(context).pop();
    if (responseData.isSuccess) {
      DescriptionModelResponse data =
          DescriptionModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

  // static Future<GetDealModelReponse> getDealName(BuildContext context) async {
  //   ResponseData responseData =
  //       await connection.post('/customer-lead/customer-lead/get-deal-name', {});
  //   if (responseData.isSuccess) {
  //     GetDealModelReponse data =
  //         GetDealModelReponse.fromJson(responseData.data);
  //     return data;
  //   }
  //   return null;
  // }

  // static Future<GetBranchModelReponse> getBranch(BuildContext context) async {
  //   ResponseData responseData =
  //       await connection.post('/customer-lead/customer-lead/get-branch', {});
  //   if (responseData.isSuccess) {
  //     GetBranchModelReponse data =
  //         GetBranchModelReponse.fromJson(responseData.data);
  //     return data;
  //   }
  //   return null;
  // }

  // static Future<GetTagModelReponse> getTag(BuildContext context) async {
  //   ResponseData responseData =
  //       await connection.post('/customer-lead/customer-lead/get-tag', {});
  //   if (responseData.isSuccess) {
  //     GetTagModelReponse data = GetTagModelReponse.fromJson(responseData.data);
  //     return data;
  //   }
  //   return null;
  // }

  // static Future<DescriptionModelResponse> updateLead(
  //     BuildContext context, EditPotentialRequestModel model) async {
  //   showLoading(context);
  //   ResponseData responseData = await connection.post(
  //       '/customer-lead/customer-lead/update-lead', model.toJson());
  //   Navigator.of(context).pop();
  //   if (responseData.isSuccess) {
  //     DescriptionModelResponse data =
  //         DescriptionModelResponse.fromJson(responseData.data);
  //     return data;
  //   }
  //   return null;
  // }

  // static Future<DescriptionModelResponse> assignRevokeLead(
  //     BuildContext context, AssignRevokeLeadRequestModel model) async {
  //   showLoading(context);
  //   ResponseData responseData = await connection.post(
  //       '/customer-lead/customer-lead/assign-revoke-lead', model.toJson());
  //   Navigator.of(context).pop();
  //   if (responseData.isSuccess) {
  //     DescriptionModelResponse data =
  //         DescriptionModelResponse.fromJson(responseData.data);
  //     return data;
  //   }
  //   return null;
  // }

  static Future showLoading(BuildContext context) async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return SimpleDialog(
            elevation: 0.0,
            backgroundColor: Colors.transparent,
            children: <Widget>[
              Center(
                child: Platform.isAndroid
                    ? const CircularProgressIndicator()
                    : const CupertinoActivityIndicator(),
              )
            ],
          );
        });
  }

  static Future showMyDialog(BuildContext context, String title) async {
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
                  'Thông báo\n',
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
