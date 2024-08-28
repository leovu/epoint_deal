import 'package:epoint_deal_plugin/model/request/get_history_req_model.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_note_res_model.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/note_module/ui/create_note_screen.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
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

  onAdd(Function? onReload) async {
    bool? event = await CustomNavigator.showCustomBottomDialog(context!, CreateNoteScreen(
      model: model,
    ));
    if (event == null || event){
      onReload?.call();
    }
  }
}