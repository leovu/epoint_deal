
import 'package:epoint_deal_plugin/model/response/preview_print_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/material.dart';

class PreviewPrintOrderBloc extends BaseBloc {

  PreviewPrintOrderBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<PreviewPrintResponseModel?>getPrintOrder(int? orderId, String? brandCode) async {
    CustomNavigator.showProgressDialog(context);
    ResponseModel response = await repository.getPrintOrder(context, orderId, brandCode);
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      PreviewPrintResponseModel responseModel = PreviewPrintResponseModel.fromJson(response.data!);
      return responseModel;
    }
    return null;
  }
}