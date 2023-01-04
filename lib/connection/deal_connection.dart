import 'dart:io';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/http_connection.dart';
import 'package:epoint_deal_plugin/model/acount.dart';
import 'package:epoint_deal_plugin/model/request/add_business_areas_model_request.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/add_tag_model_request.dart';
import 'package:epoint_deal_plugin/model/request/add_work_model_request.dart';
import 'package:epoint_deal_plugin/model/request/assign_revoke_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/get_journey_model_request.dart';
import 'package:epoint_deal_plugin/model/request/get_list_staff_request_model.dart';
import 'package:epoint_deal_plugin/model/request/list_customer_lead_model_request.dart';
import 'package:epoint_deal_plugin/model/request/list_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/list_project_model_request.dart';
import 'package:epoint_deal_plugin/model/request/update_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/add_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/description_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_allocator_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_option_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/get_status_work_response_model.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_type_work_response_model.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_business_areas_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_customer_lead_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/list_project_model_response.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/model/response/update_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/work_list_branch_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/work_list_department_response_model.dart';
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

    static Future<ListCustomLeadModelReponse> getListPotentialCustomer(
      BuildContext context, ListCustomLeadModelRequest model) async {
    showLoading(context);
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/list-customer-lead', model.toJson());
    Navigator.of(context).pop();
    if (responseData.isSuccess) {
      if (responseData.data != null) {
        ListCustomLeadModelReponse data =
            ListCustomLeadModelReponse.fromJson(responseData.data);
        return data;
      }
      return null;
    }
    return null;
  }

   static Future<GetCustomerModelResponse> getCustomer(
      BuildContext context) async {
    ResponseData responseData = await connection
        .post('/customer-lead/customer-lead/get-customer', {});
    if (responseData.isSuccess) {
      GetCustomerModelResponse data =
          GetCustomerModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

  static Future<DetailDealModelResponse> getdetailDeal(
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
        {"pipeline_category_code": "DEAL"});
    if (responseData.isSuccess) {
      GetPipelineModelReponse data =
          GetPipelineModelReponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

  static Future<GetJourneyModelReponse> getJourney(
      BuildContext context, GetJourneyModelRequest model) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/get-journey',
        {"pipeline_code": model.toJson()});
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

  static Future<AddDealModelResponse> addDeal(
      BuildContext context, AddDealModelRequest model) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/add-deals', model.toJson());
    if (responseData.isSuccess) {
      var data =
          AddDealModelResponse.fromJson(responseData.data);
      // print("Thanh conmg");
      return data;
    }
    return null;
  }

  static Future<UpdateDealModelResponse> updateDeal(
      BuildContext context, UpdateDealModelRequest model) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/update-deal', model.toJson());
    if (responseData.isSuccess) {
      var data =
          UpdateDealModelResponse.fromJson(responseData.data);
      // print("Thanh conmg");
      return data;
    }
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

    static Future<DescriptionModelResponse> assignRevokeLead(
      BuildContext context, AssignRevokeDealModelRequest model) async {
    showLoading(context);
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/assign-revoke-deal', model.toJson());
    Navigator.of(context).pop();
    if (responseData.isSuccess) {
      DescriptionModelResponse data =
          DescriptionModelResponse.fromJson(responseData.data);
      return data;
    }
  }
    

  static Future<GetTagModelReponse> getTag(BuildContext context) async {
    ResponseData responseData =
        await connection.post('/customer-lead/customer-lead/get-tag', {});
    if (responseData.isSuccess) {
      GetTagModelReponse data = GetTagModelReponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

   static Future<WorkListBranchResponseModel> workListBranch(
      BuildContext context) async {
    // showLoading(context);
    ResponseData responseData = await connection.post(
        '/manage-work/list-branch',{});
    if (responseData.isSuccess) {
      WorkListBranchResponseModel data =
          WorkListBranchResponseModel.fromJson(responseData.data);
      return data;
    }
    return null;
  }

  static Future<WorkListStaffResponseModel> workListStaff(
      BuildContext context, WorkListStaffRequestModel model) async {
    // showLoading(context);
    ResponseData responseData = await connection.post(
        '/manage-work/list-staff',model.toJson());
    if (responseData.isSuccess) {
      WorkListStaffResponseModel data =
          WorkListStaffResponseModel.fromJson(responseData.data);
      return data;
    }
    return null;
  }

   static Future<WorkListDepartmentResponseModel> workListDepartment(
      BuildContext context) async {
    ResponseData responseData = await connection.post(
        '/manage-work/list-department',{});
    if (responseData.isSuccess) {
      WorkListDepartmentResponseModel data =
          WorkListDepartmentResponseModel.fromJson(responseData.data);
      return data;
    }
    return null;
  }

       static Future<GetTypeWorkModelResponse> getTypeWork(
      BuildContext context) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/get-type-work',{});
    if (responseData.isSuccess) {
      GetTypeWorkModelResponse data =
          GetTypeWorkModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }
    static Future<ListBusinessAreasModelResponse> getListBusinessAreas(
      BuildContext context) async {
    // showLoading(context);
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/list-business-areas',{});
    if (responseData.isSuccess) {
      
      ListBusinessAreasModelResponse data =
          ListBusinessAreasModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

       static Future<DescriptionModelResponse> addBusinessAreas(
      BuildContext context, AddBusinessAreasModelRequest model) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/add-business-areas',model.toJson());
    if (responseData.isSuccess) {
      DescriptionModelResponse data =
          DescriptionModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

    static Future<DescriptionModelResponse> addTag(
      BuildContext context, AddTagModelRequest model) async {
    ResponseData responseData = await connection.post(
        '/customer-lead/customer-lead/add-tag', model.toJson());
    if (responseData.isSuccess) {
      DescriptionModelResponse data =
          DescriptionModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

    static Future<ListProjectModelResponse> getListProject(
      BuildContext context, ListProjectModelRequest model) async {
    showLoading(context);
    ResponseData responseData = await connection.post(
        '/project-management/list-project', model.toJson());
    Navigator.of(context).pop();
    if (responseData.isSuccess) {
      if (responseData.data != null) {
        ListProjectModelResponse data =
            ListProjectModelResponse.fromJson(responseData.data);
        return data;
      }
      return null;
    }
    return null;
  }

   static Future<GetStatusWorkResponseModel> getStatusWork(
      BuildContext context) async {
    ResponseData responseData = await connection
        .post('/customer-lead/customer-lead/get-status-work', {});
    if (responseData.isSuccess) {
      GetStatusWorkResponseModel data =
          GetStatusWorkResponseModel.fromJson(responseData.data);
      return data;
    }
    return null;
  }

    static Future<DescriptionModelResponse> addWork(
      BuildContext context, AddWorkRequestModel model) async {
    // showLoading(context);
    ResponseData responseData =
        await connection.post('/manage-work/add-work', model.toJson());
    if (responseData.isSuccess) {
      DescriptionModelResponse data =
          DescriptionModelResponse.fromJson(responseData.data);
      return data;
    }
    return null;
  }

  

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

 static Future showMyDialog(BuildContext context, String title, {bool warning = false}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Center(
                    child: Text(
                  warning ? AppLocalizations.text(LangKey.warning) : AppLocalizations.text(LangKey.notify) + "\n",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                )),
                Container(height: 10,),
                Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.grey[700]),
                )),
              ],
            ),
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 15.0),
              height: 40,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                child: Center(
                    child: Text(
                  AppLocalizations.text(LangKey.argree),
                  style: TextStyle(color: AppColors.white),
                )),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        );
      },
    );
  }

  static Future showMyDialogWithFunction(BuildContext context, String title,
      {Function ontap}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          // title:  Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(),
                    Center(
                        child: Text(
                      AppLocalizations.text(LangKey.notify) + "\n",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    )),

                    InkWell(
                      child: Icon(Icons.clear,size: 20,),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
                Center(
                    child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[700]),
                )),
              ],
            ),
          ),
          actions: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    child: Center(
                        child: Text(
                      AppLocalizations.text(LangKey.no),
                      style: TextStyle(color: Color(0xFF0067AC)),
                    )),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child:
                        Center(child: Text(AppLocalizations.text(LangKey.yes))),
                    onPressed: ontap,
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
