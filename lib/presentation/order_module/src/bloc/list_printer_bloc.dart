
import 'package:epoint_deal_plugin/model/request/print_devices_request_model.dart';
import 'package:epoint_deal_plugin/model/response/print_devices_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class ListPrinterBloc extends BaseBloc {
  ListPrinterBloc(BuildContext context) {
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _streamModels.close();

    super.dispose();
  }

  final _streamModels = BehaviorSubject<List<PrintDevicesModel>?>();

  ValueStream<List<PrintDevicesModel>?> get outputModels =>
      _streamModels.stream;

  setModels(List<PrintDevicesModel> event) => set(_streamModels, event);

  printDevices(PrintDevicesRequestModel model, bool isRefresh) async {
    ResponseModel response = await repository.printDevices(context, model);

    if (response.success!) {
      var responseModel = PrintDevicesResponseModel.fromJson(response.datas);

      setModels(responseModel.data ?? []);
    } else {
      if (!isRefresh) {
        setModels([]);
      }
    }
  }
}
