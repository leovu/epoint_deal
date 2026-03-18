import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/request/get_history_req_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/cupertino.dart';

class CreateNoteBloc extends BaseBloc {
  CreateNoteBloc(BuildContext context) {
    setContext(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final FocusNode focusNote = FocusNode();
  final TextEditingController controllerNote = TextEditingController();

  customerNoteStore(CreateNoteReqModel model) async {
    CustomNavigator.showProgressDialog(context);
    ResponseModel response = await repository.addNote(context, model);
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      await CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          response.errorDescription ?? "");
      CustomNavigator.pop(context!, object: true);
    }
  }
}
