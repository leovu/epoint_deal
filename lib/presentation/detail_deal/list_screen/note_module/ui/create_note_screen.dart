import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/request/create_order_request_model.dart';
import 'package:epoint_deal_plugin/model/request/get_history_req_model.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/note_module/bloc/create_note_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateNoteScreen extends StatefulWidget {
  final DetailDealData model;

  const CreateNoteScreen({super.key, required this.model});

  @override
  CreateNoteScreenState createState() => CreateNoteScreenState();
}

class CreateNoteScreenState extends State<CreateNoteScreen> {
  late CreateNoteBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = CreateNoteBloc(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomBottomSheet(
      title: AppLocalizations.text(LangKey.add_note),
      isBottomSheet: false,
      body: CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          CustomTextField(
            controller: _bloc.controllerNote,
            focusNode: _bloc.focusNote,
            hintText: AppLocalizations.text(LangKey.enter_note),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            backgroundColor: Colors.transparent,
            borderColor: AppColors.borderColor,
            maxLines: 3,
            autofocus: true,
          ),
          CustomButton(
            text: AppLocalizations.text(LangKey.add),
            onTap: () {
              if (_bloc.controllerNote.text.trim().isEmpty) {
                CustomNavigator.showCustomAlertDialog(
                    context,
                    AppLocalizations.text(LangKey.notification),
                    AppLocalizations.text(LangKey.customer_create_note_error));
                return;
              }
              _bloc.customerNoteStore(CreateNoteReqModel(
                  customer_deal_id: widget.model.dealId,
                  content: _bloc.controllerNote.text));
            },
          )
        ],
      ),
    );
  }
}