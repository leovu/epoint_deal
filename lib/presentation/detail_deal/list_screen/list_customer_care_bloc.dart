import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/response/care_deal_response_model.dart';
import 'package:epoint_deal_plugin/model/response/get_status_work_response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ListCustomerCareBloc extends BaseBloc {

  ListCustomerCareBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  final _streamStatusWorkData = BehaviorSubject<List<CustomDropdownModel>?>();
   ValueStream<List<CustomDropdownModel>?> get outputStatusWorkData => _streamStatusWorkData.stream;
  setStatusWorkData(List<CustomDropdownModel>? event) => set(_streamStatusWorkData, event);

    final _streamCareDeal = BehaviorSubject<List<CareDealData>?>();
  ValueStream<List<CareDealData>?> get outputCareDeal => _streamCareDeal.stream;
  setCareDeal(List<CareDealData>? event) => set(_streamCareDeal, event);

  List<CustomDropdownModel>? statusWorkData;
  CustomDropdownModel? statusWorkDataSelected;

  getStatusWork() async {
    try {
      var statusWorkModel = await DealConnection.getStatusWork(context!);
     List<GetStatusWorkData> model = statusWorkModel?.data ?? [];
     statusWorkData = convertToDropdownModel(model);
      setStatusWorkData(convertToDropdownModel(model));
    } catch (e) {
      // Handle any errors if necessary
      setStatusWorkData([]);
    }
  }

  List<CustomDropdownModel> convertToDropdownModel(List<GetStatusWorkData> statusWorkDataList) {
  return statusWorkDataList.map((statusWorkData) {
    return CustomDropdownModel(
      id: statusWorkData.manageStatusId,
      text: statusWorkData.manageStatusName,
      color: HexColor(statusWorkData.manageStatusColor),
      data: statusWorkData,
    );
  }).toList();
}
  List<CareDealData>? listCareDeal;

  onChange(CustomDropdownModel value) {
    statusWorkDataSelected = value;
    setCareDeal(listCareDeal?.where((element) => element.manageStatusId == value.id).toList() ?? []);
    setStatusWorkData(statusWorkData);
  }

  onRemove() {
    statusWorkDataSelected = null;
    setCareDeal(listCareDeal ?? []);
    setStatusWorkData(statusWorkData);
  }
}

class HexColor extends Color {
  static int getColorFromHex(String? hexColor) {
    if((hexColor ?? "") == ""){
      hexColor = "000000";
    }
    hexColor = hexColor!.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String? hexColor) : super(getColorFromHex(hexColor));
}