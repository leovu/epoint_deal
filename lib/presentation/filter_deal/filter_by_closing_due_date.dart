import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/model/closing_due_date_model.dart';
import 'package:epoint_deal_plugin/model/filter_screen_model.dart';
import 'package:epoint_deal_plugin/widget/custom_date_picker.dart';
import 'package:epoint_deal_plugin/widget/custom_meni_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FilterByClosingDueDate extends StatefulWidget {
      FilterScreenModel? filterScreenModel = FilterScreenModel();
  List<ClosingDueDateModel>? closingDueDateOptions = <ClosingDueDateModel>[];
  String? id_closing_due_date;
  FilterByClosingDueDate({Key? key, this.closingDueDateOptions, this.filterScreenModel,this.id_closing_due_date});

  @override
  _FilterByClosingDueDateState createState() => _FilterByClosingDueDateState();
}

class _FilterByClosingDueDateState extends State<FilterByClosingDueDate> {

  DateTime? _fromDate;
  DateTime? _toDate;
  DateTime _now = DateTime.now();
  final TextEditingController _fromDateText = TextEditingController();
  final TextEditingController _toDateText = TextEditingController();

  @override
  void initState() {
    super.initState();
    // _toDate = _now;

    if (widget.filterScreenModel!.fromDate_closing_due_date != null) {
      _fromDateText.text = DateFormat("dd/MM/yyyy").format(widget.filterScreenModel!.fromDate_closing_due_date!);
      _fromDate = widget.filterScreenModel!.fromDate_closing_due_date;
    }

    if (widget.filterScreenModel!.toDate_closing_due_date != null) {
      _toDateText.text = DateFormat("dd/MM/yyyy").format(widget.filterScreenModel!.toDate_closing_due_date!);
      _toDate = widget.filterScreenModel!.toDate_closing_due_date;
    }

    if (widget.filterScreenModel!.id_closing_due_date != "") {
      for (int i = 0; i < widget.closingDueDateOptions!.length ; i++) {
          if (widget.closingDueDateOptions![i].closingDueDateID == int.parse(widget.filterScreenModel!.id_closing_due_date!) ) {
            widget.closingDueDateOptions![i].selected = true;
            widget.id_closing_due_date =  "${widget.closingDueDateOptions![i].closingDueDateID}";
          } else {
            widget.closingDueDateOptions![i].selected = false;
          }
      }
    }
     else {
      widget.id_closing_due_date = "";
    }

    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {

    if (widget.id_closing_due_date == "" ) {
      _fromDateText.text = "";
      _toDateText.text = "";
      _fromDate = null;
      _toDate = null;

    } ;

    return (widget.closingDueDateOptions != null)
        ? Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 16.0),
                child: Wrap(
                  children: List.generate(
                      widget.closingDueDateOptions!.length,
                      (index) => _optionItem(
                              widget.closingDueDateOptions![index].closingDueDateName,
                              widget.closingDueDateOptions![index].selected!, () {
                            selectedSource(index);
                          })),
                  spacing: 20,
                  runSpacing: 20,
                ),
              ),
              (widget.id_closing_due_date == "6")
                  ? Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // khung thời gian tự chọn
                        Text(
                          AppLocalizations.text(LangKey.customerTimeFrame)!,
                          style: TextStyle(
                              fontSize: 15.0,
                              color: const Color(0xFF8E8E8E),
                              fontWeight: FontWeight.normal),
                        ),
                        Container(height: 10,),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                margin: const EdgeInsets.only(bottom: 10.0),
                                width:
                                    (MediaQuery.of(context).size.width - 60) / 2 -
                                        8,
                                child: _buildDatePicker(
                                    AppLocalizations.text(LangKey.fromDate),
                                     widget.id_closing_due_date != "" ? _fromDateText : "" as TextEditingController, () {
                                  _showFromDatePickerClosingDueDate();
                                })),
                            Container(
                                margin: EdgeInsets.only(left: 15, right: 5),
                                child: Text(
                                  "-",
                                  style: TextStyle(color: Color(0xFF8E8E8E)),
                                )),
                            Container(
                                margin:
                                    const EdgeInsets.only(bottom: 10.0, left: 10.0),
                                width:
                                    (MediaQuery.of(context).size.width - 60) / 2 -
                                        4,
                                child: _buildDatePicker(
                                    AppLocalizations.text(LangKey.toDate),
                                    widget.id_closing_due_date != "" ? _toDateText : "" as TextEditingController, () {
                                  _showToDatePickerClosingDueDate();
                                }))
                          ],
                        ),
                    ],
                  )
                  : Container(),
            ],
          )
        : Container();
  }

  _showFromDatePickerClosingDueDate() {
    DateTime selectedDate = widget.filterScreenModel!.fromDate_closing_due_date ?? _fromDate ?? _toDate ?? _now;

    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: CustomMenuBottomSheet(
              title: AppLocalizations.text(LangKey.fromDate),
              widget: CustomDatePicker(
                initTime: selectedDate,
                maximumTime: _toDate,
                dateOrder: DatePickerDateOrder.dmy,
                onChange: (DateTime date) {
                  selectedDate = date;
                },
              ),
              onTapConfirm: () {

                 if (_toDate == null) {
                  Global.validateClosingDueDate = false;
                } else {
                  Global.validateClosingDueDate = true;
                }
                _fromDate = selectedDate;
                widget.filterScreenModel!.fromDate_closing_due_date = selectedDate;

                _fromDateText.text =
                    DateFormat("dd/MM/yyyy").format(selectedDate).toString();
                widget.filterScreenModel!.filterModel!.closingDueDate = "${DateFormat("dd/MM/yyyy").format(_fromDate!)} - ${DateFormat("dd/MM/yyyy").format(_toDate ?? _now)}";
                print(widget.filterScreenModel!.filterModel!.closingDueDate);
                Navigator.of(context).pop();
              },
              haveBnConfirm: true,
            ),
          );
        });
  }

  _showToDatePickerClosingDueDate() {
    DateTime selectedDate = _toDate ?? _now;
    DateTime? maximumTime = _now;
    if (_toDate?.year == _now.year &&
        _toDate?.month == _now.month &&
         (_toDate?.day ?? 0) > _now.day) maximumTime = _toDate;
    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: CustomMenuBottomSheet(
              title: AppLocalizations.text(LangKey.toDate),
              widget: CustomDatePicker(
                initTime: selectedDate,
                maximumTime: maximumTime,
                minimumTime: _fromDate,
                dateOrder: DatePickerDateOrder.dmy,
                onChange: (DateTime date) {
                  selectedDate = date;
                },
              ),
              onTapConfirm: () {
                if (_fromDate == null) {
                  Global.validateClosingDueDate = false;
                } else {
                  Global.validateClosingDueDate = true;
                }

                _toDate = selectedDate;
                widget.filterScreenModel!.toDate_closing_due_date = selectedDate;
                _toDateText.text =
                    DateFormat("dd/MM/yyyy").format(selectedDate).toString();
                widget.filterScreenModel!.filterModel!.closingDueDate = "${DateFormat("dd/MM/yyyy").format(_fromDate ?? _toDate ?? _now)} - ${DateFormat("dd/MM/yyyy").format(_toDate!)}";
                print(widget.filterScreenModel!.filterModel!.closingDueDate);
                Navigator.of(context).pop();
              },
              haveBnConfirm: true,
            ),
          );
        });
  }

  Widget _buildDatePicker(
      String? hintText, TextEditingController fillText, Function ontap) {
    return InkWell(
      onTap: ontap as void Function()?,
      child: TextField(
        enabled: false,
        controller: fillText,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // focusedBorder: OutlineInputBorder(
          //   borderSide: BorderSide(width: 1, color: Color(0xFFB8BFC9)),
          // ),
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF8E8E8E),
              fontWeight: FontWeight.normal),
          isDense: true,
        ),
        // },
      ),
    );
  }

  Widget _optionItem(String? name, bool selected, Function ontap) {
    return InkWell(
      onTap: ontap as void Function()?,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          selected
              ? Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  height: 40,
                  // width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                          width: 1.0,
                          color: Colors.blue,
                          style: BorderStyle.solid)),
                  child: Center(
                    child: Text(
                      name!,
                      style: TextStyle(
                          color: Color(0xFF0067AC),
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                )
              : Container(
                  padding: EdgeInsets.only(left: 8.0, right: 8.0),
                  height: 40,
                  // width: 100,
                  decoration: BoxDecoration(
                      color: Color(0xFFEAEAEA),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Center(
                    child: Text(
                      name!,
                      style: TextStyle(color: Color(0xFF8E8E8E)),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  selectedSource(int index) async {
    if (index != 6) {
      Global.validateClosingDueDate = true;
      _fromDateText.text = "";
      _toDateText.text = "";

      widget.filterScreenModel!.fromDate_closing_due_date = null;
      widget.filterScreenModel!.toDate_closing_due_date = null;
      _fromDate = null;
      _toDate = null;
    } else {
      Global.validateClosingDueDate = false;
    }

    List<ClosingDueDateModel> models = widget.closingDueDateOptions!;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    widget.id_closing_due_date = "${models[index].closingDueDateID}";
    widget.filterScreenModel!.id_closing_due_date = "${index}";
    switch (index) {
      case 0:
      widget.filterScreenModel!.filterModel!.closingDueDate = "${DateFormat("dd/MM/yyyy").format(_now)} - ${DateFormat("dd/MM/yyyy").format(_now)}";
      print(widget.filterScreenModel!.filterModel!.closingDueDate);
        break;
      case 1:
        widget.filterScreenModel!.filterModel!.closingDueDate = "${DateFormat("dd/MM/yyyy").format(_now.subtract( Duration(days: 1)))} - ${DateFormat("dd/MM/yyyy").format(_now.subtract(Duration(days: 1)))}";
         print(widget.filterScreenModel!.filterModel!.closingDueDate);
        break;
      case 2:
        widget.filterScreenModel!.filterModel!.closingDueDate = "${DateFormat("dd/MM/yyyy").format(_now.subtract( Duration(days: 7)))} - ${DateFormat("dd/MM/yyyy").format(_now)}";
         print(widget.filterScreenModel!.filterModel!.closingDueDate);
        break;
      case 3:
        widget.filterScreenModel!.filterModel!.closingDueDate = "${DateFormat("dd/MM/yyyy").format(_now.subtract( Duration(days: 31)))} - ${DateFormat("dd/MM/yyyy").format(_now.subtract(Duration(days: 1)))}";
         print(widget.filterScreenModel!.filterModel!.closingDueDate);
        break;
      case 4:
        widget.filterScreenModel!.filterModel!.closingDueDate = "${DateFormat("dd/MM/yyyy").format(DateTime.parse(DateTime(_now.year, _now.month, 1).toString()))} - ${DateFormat("dd/MM/yyyy").format(DateTime.parse(DateTime(_now.year, _now.month +1, 0).toString()))}";
         print(widget.filterScreenModel!.filterModel!.closingDueDate);
        break;
      case 5:
       var lastmonth = _now.month - 1;
        widget.filterScreenModel!.filterModel!.closingDueDate = "${DateFormat("dd/MM/yyyy").format(DateTime.parse(DateTime(_now.year, _now.month - 1, 1).toString()))} - ${DateFormat("dd/MM/yyyy").format(DateTime.parse(DateTime(_now.year, lastmonth +1, 0).toString()))}";
         print(widget.filterScreenModel!.filterModel!.closingDueDate);
        break;
      case 6:
        widget.filterScreenModel!.filterModel!.closingDueDate = "";
        break;
      default:
    }

    setState(() {});
  }
}
