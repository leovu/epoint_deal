import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_note_res_model.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/bloc/detail_deal_bloc.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/note_module/bloc/deal_note_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_appbar.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/cupertino.dart';

class ListNoteScreen extends StatefulWidget {
  final DetailDealBloc bloc;
  final DetailDealData model;

  const ListNoteScreen({super.key, required this.bloc, required this.model});

  @override
  ListNoteScreenState createState() => ListNoteScreenState();
}

class ListNoteScreenState extends State<ListNoteScreen> {
  late List<CustomOptionAppBar> _options;
  late DealNoteBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = DealNoteBloc(context);
    _bloc.model = widget.model;
    _options = [
      CustomOptionAppBar(
          icon: Assets.iconPlus,
          onTap:() {
             widget.bloc.onAddNote(() {
            widget.bloc.getListNote(context);
          });
          })
    ];

    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.bloc.getListNote(context));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      padding: EdgeInsets.all(AppSizes.minPadding),
      separator: SizedBox(height: AppSizes.minPadding),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return LoadingWidget(
        padding: EdgeInsets.zero,
        child: CustomListView(
          children: List.generate(
              10,
              (index) => CustomSkeleton(
                    height: 100,
                    radius: 4.0,
                  )),
        ));
  }

  Widget _buildContent() {
    return StreamBuilder(
        stream: widget.bloc.outputListNote,
        initialData: null,
        builder: (_, snapshot) {
          List<NoteData>? models = snapshot.data as List<NoteData>?;
          return ContainerDataBuilder(
              data: models,
              skeletonBuilder: _buildSkeleton(),
              emptyBuilder: CustomEmpty(
                title: AppLocalizations.text(LangKey.data_empty),
              ),
              bodyBuilder: () => _buildContainer(models!
                  .map((e) => noteItem(
                        e,
                        models.indexOf(e),
                      ))
                  .toList()));
        });
  }

  Widget noteItem(NoteData model, int index) {
    String? name, date;

    if (model.createdByName != null) {
      name = model.createdByName ?? "";
      date = model.createdAt ?? "";
    }
    return CustomContainerList(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.minPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.content ?? "",
              style: AppTextStyles.style14BlackWeight600,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: CustomListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Text(
                      name ?? "",
                      style: AppTextStyles.style14HintNormal,
                    ),
                    Text(
                      parseAndFormatDate(date, format: AppFormat.formatDateTime),
                      style: AppTextStyles.style14HintNormal,
                    ),
                  ],
                )),
                SizedBox(
                    width: AppSizes.minPadding,
                  ),
                  CustomIndex(index: index)
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      options: _options,
      title: AppLocalizations.text(LangKey.care_list),
      body: _buildContent(),
      onWillPop: () => CustomNavigator.pop(context, object: false),
    );
  }
}
