import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/filter_model.dart';
import 'package:epoint_deal_plugin/model/filter_order_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/filter_order_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_bottom.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class FilterOrderScreen extends StatefulWidget {
  final FilterOrderModel? model;

  const FilterOrderScreen({Key? key, this.model}) : super(key: key);

  @override
  _FilterOrderScreenState createState() => _FilterOrderScreenState();
}

class _FilterOrderScreenState extends State<FilterOrderScreen> {
  DateTime? _date;

  List<FilterModel>? _statusModels;

  late FilterOrderBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = FilterOrderBloc(context);

    _statusModels = Globals.orderStatusModels
        .map((e) => FilterModel(id: e.id, text: e.text, color: e.color))
        .toList();
    _statusModels!.insert(0, FilterModel(
      text: AppLocalizations.text(LangKey.all),
      color: AppColors.primaryColor,
    ));

    if (widget.model != null) {
      try {
        _statusModels!
            .firstWhere((element) => element.id == widget.model!.statusModel?.id)
            .selected = true;
      } catch (_) {}

      _date = widget.model!.date;
    } else {
      _statusModels!.first.selected = true;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  _delete() {
    _statusModels!.firstWhere((element) => element.selected).selected = false;
    _statusModels!.first.selected = true;
    _bloc.setStatusModels(_statusModels);
    _deleteDate();
  }

  _apply() {
    CustomNavigator.pop(context,
        object: FilterOrderModel(
            statusModel:
                _statusModels!.firstWhere((element) => element.selected),
            date: _date));
  }

  _showDate() {
    DateTime now = DateTime.now();
    DatePicker.showDatePicker(context,
        minTime: minDateTime,
        maxTime: now.add(Duration(days: 365)),
        currentTime: _date ?? now,
        locale: Globals.localeType, onConfirm: (event) {
      _bloc.setDate(event);
    });
  }

  _deleteDate() {
    _bloc.setDate(null);
  }

  _selectStatus(FilterModel model) {
    if (model.selected) {
      return;
    }

    _statusModels!.firstWhere((element) => element.selected).selected = false;

    model.selected = true;
    _bloc.setStatusModels(_statusModels);
  }

  Widget _buildStatus() {
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.status),
      titleIcon: Assets.iconProjectStatus,
      child: StreamBuilder(
          stream: _bloc.outputStatusModels,
          initialData: _statusModels,
          builder: (_, snapshot) {
            return Wrap(
              spacing: AppSizes.minPadding,
              runSpacing: AppSizes.minPadding,
              children: _statusModels!
                  .map((e) => CustomChipSelected(
                        text: e.text,
                        type: true,
                        selected: e.selected,
                        colorSelected: e.color,
                        onTap: () => _selectStatus(e),
                      ))
                  .toList(),
            );
          }),
    );
  }

  Widget _buildDate() {
    return StreamBuilder(
        stream: _bloc.outputDate,
        initialData: _date,
        builder: (_, snapshot) {
          _date = snapshot.data as DateTime?;
          return CustomColumnInformation(
            title: AppLocalizations.text(LangKey.order_date),
            titleIcon: Assets.iconCalendarFill,
            content: formatDate(_date),
            backgroundColor: Colors.transparent,
            borderColor: AppColors.borderColor,
            hintText: "${AppLocalizations.text(LangKey.select)} ${AppLocalizations.text(LangKey.order_date)!.toLowerCase()}",
            suffixIcon: _date == null ? Assets.iconCalendar1 : Assets.iconTrash,
            onSuffixTap: _date == null ? _showDate : _deleteDate,
            onTap: _showDate,
          );
        });
  }

  Widget _buildContent() {
    return CustomListView(
      separatorPadding: AppSizes.maxPadding,
      children: [_buildStatus(), _buildDate()],
    );
  }

  Widget _buildBottom() {
    return CustomBottom(
      text: AppLocalizations.text(LangKey.apply),
      onTap: _apply,
      subText: AppLocalizations.text(LangKey.delete),
      onSubTap: _delete,
    );
  }

  Widget _buildBody() {
    return Column(
      children: [Expanded(child: _buildContent()), _buildBottom()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.filter_orders),
      body: _buildBody(),
    );
  }
}
