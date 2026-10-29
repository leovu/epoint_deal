import 'package:epoint_deal_plugin/widget/custom_glass_app_bar.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/response/get_status_work_response_model.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_customer_modal.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';

class FilterByWorkStatus extends StatefulWidget {
  List<GetStatusWorkData>? statusWorkData;
  FilterByWorkStatus({Key? key, this.statusWorkData}) : super(key: key);

  @override
  _FilterByWorkStatusState createState() => _FilterByWorkStatusState();
}

class _FilterByWorkStatusState extends State<FilterByWorkStatus> {
  final ScrollController _controller = ScrollController();
  final TextEditingController _searchext = TextEditingController();
  final FocusNode _fonusNode = FocusNode();
  List<GetStatusWorkData>? statusWorkData;
  List<GetStatusWorkData>? statusWorkDataDisplay;

  @override
  void initState() {
    super.initState();
    statusWorkData = widget.statusWorkData;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  getData() async {
    keyboardDismissOnTap(context);

    if (statusWorkData == null || statusWorkData!.length == 0) {
      DealConnection.showLoading(context);
      var statusWorkModel = await DealConnection.getStatusWork(context);

      Navigator.of(context).pop();
      if (statusWorkModel != null) {
        statusWorkData = statusWorkModel.data;
        statusWorkDataDisplay = statusWorkData;
      }
    } else {
      statusWorkDataDisplay = statusWorkData;
    }

    setState(() {});
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppGlass.backgroundColor,
        appBar: CustomGlassAppBar(
          title: Text(
            AppLocalizations.text(LangKey.byWorkStatus)!,
            style: const TextStyle(
                color: AppColors.textTitleColor,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        body:
            Container(decoration: AppGlass.background(), child: _buildBody()));
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
      child: Column(
        children: [
          _buildSearch(),
          (statusWorkDataDisplay != null)
              ? (statusWorkDataDisplay!.length > 0)
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
              Navigator.of(context).pop(statusWorkData);
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
    return (statusWorkDataDisplay != null && statusWorkDataDisplay!.length > 0)
        ? List.generate(
            statusWorkDataDisplay!.length,
            (index) => _buildItem(statusWorkDataDisplay![index], () {
                  selectedItem(statusWorkDataDisplay![index]);
                }))
        : [CustomDataNotFound()];
  }

  Widget _buildItem(GetStatusWorkData item, GestureTapCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 40,
            child: Row(
              children: [
                Text(
                  item.manageStatusName!,
                  style: TextStyle(
                      fontSize: 15.0,
                      color: item.selected!
                          ? AppColors.primaryColor
                          : AppColors.textTitleColor,
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
      statusWorkDataDisplay = statusWorkData;
      setState(() {});
    } else {
      try {
        List<GetStatusWorkData> models = statusWorkData!.where((model) {
          List<String> search = value.removeAccents().split(" ");
          bool result = true;
          for (String element in search) {
            if (!((model.manageStatusName ?? "")
                .removeAccents()
                .contains(element))) {
              result = false;
              break;
            }
          }
          return result;
        }).toList();
        statusWorkDataDisplay = models;
        setState(() {});
      } catch (_) {
        setState(() {});
      }
    }
  }

  selectedItem(GetStatusWorkData item) async {
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
