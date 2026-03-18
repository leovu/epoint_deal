
import 'package:epoint_deal_plugin/model/request/booking_staff_request_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_customer_modal.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OrderStaffBloc extends BaseBloc {

  OrderStaffBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamModels.close();
    super.dispose();
  }

  List<BookingStaffModel>? _models;

  final _streamModels = BehaviorSubject<List<BookingStaffModel>?>();
  ValueStream<List<BookingStaffModel>?> get outputModels => _streamModels.stream;
  setModels(List<BookingStaffModel>? event) => set(_streamModels, event);

  search(String event){
    if(event.isEmpty || (_models?.length ?? 0) == 0){
      setModels(_models);
    }
    else{
      List<BookingStaffModel>? results;
      try{
        results = _models!.where((model){
          List<String> searchs = event.toLowerCase().removeAccents().split(" ");
          bool result = true;

          for(String element in searchs){
            if(!((model.fullName ?? "")
                .toLowerCase()
                .removeAccents()
                .contains(element))){
              result = false;
              break;
            }
          }

          return result;
        }).toList();
      }
      catch(_){}

      setModels(results ?? []);
    }
  }

  orderStaff(String event, int? id) async {
    ResponseModel response = await repository.orderStaff(context, BookingStaffRequestModel(
        branchId: id
    ));
    if(response.success!){
      var responseModel = BookingStaffResponseModel.fromJson(response.datas);

      _models = responseModel.data ?? [];
    }
    else{
      _models = [];
    }

    search(event);
  }
}