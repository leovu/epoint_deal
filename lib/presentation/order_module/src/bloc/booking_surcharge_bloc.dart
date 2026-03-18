import 'package:epoint_deal_plugin/model/response/other_free_branch_response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class BookingSurchargeBloc extends BaseBloc {

  BookingSurchargeBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamSurchargeModels.close();
    super.dispose();
  }

  final _streamSurchargeModels = BehaviorSubject<List<OtherFreeBranchModel>>();
  ValueStream<List<OtherFreeBranchModel>> get outputSurchargeModels => _streamSurchargeModels.stream;
  setSurchargeModels(List<OtherFreeBranchModel> event) => set(_streamSurchargeModels, event);

  onChange(OtherFreeBranchModel model, List<OtherFreeBranchModel> models){
    model.isSelected = !model.isSelected;
    setSurchargeModels(models);
    if(model.isSelected){
      fieldFocus(context!, model.focusNode);
    }
  }

  onTypeChange(OtherFreeBranchModel model, List<OtherFreeBranchModel> models){
    model.isMoney = !model.isMoney;
    model.controller.clear();
    setSurchargeModels(models);
    fieldFocus(context!, model.focusNode);
  }
}