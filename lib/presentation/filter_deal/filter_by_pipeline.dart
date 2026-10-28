import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_customer_modal.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';

class FilterByPipeline extends StatefulWidget {
    List<PipelineData>? pipeLineData = <PipelineData>[];
  FilterByPipeline(this.pipeLineData);

  @override
  _FilterByPipelineState createState() => _FilterByPipelineState();
}

class _FilterByPipelineState extends State<FilterByPipeline> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchext = TextEditingController();
  final FocusNode _fonusNode = FocusNode();
  List<PipelineData>? pipeLineData;
  List<PipelineData>? pipeLineDataDisplay;

  @override
  void initState() {
    super.initState();
    pipeLineData = widget.pipeLineData;
    pipeLineDataDisplay = widget.pipeLineData;
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppGlass.backgroundColor,
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          shape: AppGlass.appBarShape,
          flexibleSpace: Container(decoration: AppGlass.header()),
          title: Text(
            AppLocalizations.text(LangKey.choosePipeline)!,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        body: Container(
            decoration: AppGlass.background(),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
      child: Column(
        children: [
          _buildSearch(),
          (pipeLineDataDisplay != null)
              ? (pipeLineDataDisplay!.length > 0)
                  ? Expanded(
                      child: CustomListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(
                          top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _controller,
                      separator: Divider(color: AppColors.primaryColorMix),
                      children: _listWidget(),
                    ))
                  : Expanded(child: CustomDataNotFound())
              : Expanded(child: Container()),
          CustomButton(
            text: AppLocalizations.text(LangKey.confirm),
            onTap: () {
              Navigator.of(context).pop(pipeLineData);
            },
          ),
          Container(
            height: 20.0,
          ),
        ],
      ),
    );
  }

  List<Widget> _listWidget() {
    return (pipeLineDataDisplay != null && pipeLineDataDisplay!.length > 0)
        ? List.generate(
            pipeLineDataDisplay!.length,
            (index) => _buildItem(pipeLineDataDisplay![index], () {
                  selectedItem(pipeLineDataDisplay![index]);
                }))
        : [CustomDataNotFound()];
  }

  Widget _buildItem(PipelineData item, GestureTapCallback ontap) {
    return InkWell(
      onTap: ontap ,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            child: Row(
              children: [
                Text(
                  item.pipelineName!,
                  style: TextStyle(
                      fontSize: 15.0,
                      color:
                          item.selected! ? AppColors.primaryColor : AppColors.textTitleColor,
                      fontWeight:
                          item.selected! ? FontWeight.bold : FontWeight.normal),
                )
              ],
            ),
          ),
          item.selected!
              ? Icon(
                  Icons.check_box,
                  color: AppColors.primaryColor,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: AppColors.textMutedColor,
                )
        ],
      ),
    );
  }

  Widget _buildSearch() {
    return TextField(
      enabled: true,
      controller: _searchext,
      focusNode: _fonusNode,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        isCollapsed: true,
        contentPadding: EdgeInsets.all(12.0),
        filled: true,
        fillColor: AppGlass.surface,
        border: AppGlass.inputBorder(color: AppColors.primaryColorMix),
        enabledBorder: AppGlass.inputBorder(color: AppColors.primaryColorMix),
        disabledBorder: AppGlass.inputBorder(color: AppColors.primaryColorMix),
        focusedBorder: AppGlass.inputBorder(color: AppColors.primaryColor),
        // hintText: AppLocalizations.text(LangKey.filterNameCodePhone),
        hintText: AppLocalizations.text(LangKey.inputSearch),
        isDense: true,
      ),
      onChanged: (event) {
        searchModel(event);
      },
    );
  }

  searchModel(String value) {
    if (value.isEmpty) {
      pipeLineDataDisplay = pipeLineData;
      setState(() {});
    } else {
      try {
        List<PipelineData> models = pipeLineData!.where((model) {
          List<String> search = value.removeAccents().split(" ");
          bool result = true;
          for (String element in search) {
            if (!((model.pipelineName ?? "").removeAccents().contains(element))) {
              result = false;
              break;
            }
          }
          return result;
        }).toList();
        pipeLineDataDisplay = models;
        setState(() {});
      } catch (_) {
        setState(() {});
      }
    }
  }

  selectedItem(PipelineData item) async {
    item.selected = !item.selected!;

    // var event = models.firstWhere((element) => element.name == item.name);

    // if (event != null) {
    //   event.selected = !event.selected;
    // }

    setState(() {
      // widget.tagsData = models;
    });
  }
}