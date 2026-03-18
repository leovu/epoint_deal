import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:flutter/cupertino.dart';

class DealNoteBloc extends BaseBloc {
  
  DealNoteBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    super.dispose();
  }
  late DetailDealData model;

  // onAdd(Function? onReload) async {
  //   bool? event = await CustomNavigator.showCustomBottomDialog(context!, CreateNoteScreen(
  //     model: model,
  //   ));
  //   if (event == null || event){
  //     onReload?.call();
  //   }
  // }
}