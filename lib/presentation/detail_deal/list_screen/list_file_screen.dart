import 'package:auto_size_text/auto_size_text.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_file_response_model.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/bloc/detail_deal_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class ListFileScreen extends StatefulWidget {
  final DetailDealBloc bloc;

  const ListFileScreen({super.key, required this.bloc});

  @override
  ListFileScreenState createState() => ListFileScreenState();
}

class ListFileScreenState extends State<ListFileScreen> {

  @override
  void initState() {
    super.initState();


    WidgetsBinding.instance
        .addPostFrameCallback((_) => widget.bloc.getListFile(context));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
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

  _buildCustomerType() {
    return RichText(
              text: TextSpan(
                  text: widget.bloc.detail?.typeCustomer == "customer"
                      ? "${AppLocalizations.text(LangKey.customerVi)} - "
                      : "${AppLocalizations.text(LangKey.sales_leads)} - ",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                  children: [
                TextSpan(
                    text: widget.bloc.detail?.dealName,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold))
              ]));
  }

   Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap10,
          _buildCustomerType(),
          Gaps.vGap10,
          Text(
            textAlign: TextAlign.start,
            AppLocalizations.text(LangKey.list)!,
            style: AppTextStyles.style16PrimaryBold),
          Gaps.vGap10,
          Expanded(
              child: _buildContent())
        ],
      ),
    );
  }

  Widget _buildContent() {
    return StreamBuilder(
      stream: widget.bloc.outputDealsFile,
      initialData: null,
      builder: (_, snapshot){
        List<DealFilesModel>? models = snapshot.data as List<DealFilesModel>?;
        return (models != null && models.isNotEmpty) ? CustomListView(
          padding: EdgeInsets.symmetric(horizontal: 8,vertical: 10),
          
          children: models
              .map((e) => _fileItem(e, models.indexOf(e)))
              .toList(),
        ) : _buildSkeleton();
      }
    );
  }

  Widget _fileItem(DealFilesModel model, int index) {
    String? name, date;

    if (model.createdBy != null) {
      name = model.createdBy ?? "";
      date = model.createdAt ?? "";
    }
    return GestureDetector(
      onTap: () {
        widget.bloc.onOpenFile(model.fileName ?? "", model.path);
      },
      child: CustomContainerList(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.minPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          pathToImage(model.path!)!,
                          width: 24,
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Container(
                          child: AutoSizeText(
                            model.fileName!,
                            style: AppTextStyles.style14BlackNormal,
                            minFontSize: 1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
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
                        parseAndFormatDate(date,
                            format: AppFormat.formatDateTime),
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.file),
      body: _buildBody(),
      onWillPop: () => CustomNavigator.pop(context, object: false),
    );
  }
}