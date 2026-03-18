
import 'package:epoint_deal_plugin/model/request/booking_staff_request_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_customer_modal.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OrderMultiStaffBloc extends BaseBloc {

  OrderMultiStaffBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamModels.close();
    super.dispose();
  }

  List<BookingStaffModel>? models;
  late int? branchId;

  final _streamModels = BehaviorSubject<List<BookingStaffModel>?>();
  ValueStream<List<BookingStaffModel>?> get outputModels => _streamModels.stream;
  setModels(List<BookingStaffModel>? event) => set(_streamModels, event);

  search(String event){
    if(event.isEmpty){
      setModels(models);
    }
    else{
      List<BookingStaffModel>? results;
      try{
        results = models?.where((model){
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

  selected(BookingStaffModel model){
    model.selected = !model.selected;
    setModels(models);
  }

  selectAll(){
    for(var e in models ?? <BookingStaffModel>[]){
      e.selected = true;
    }
    setModels(models);
  }

  delete(String event){
    try{
      var results = models!.where((element) => element.selected).toList();
      for(var e in results){
        e.selected = false;
      }
    }
    catch(_){}

    search(event);
  }

  confirm(){
    List<BookingStaffModel> models = [];
    try{
      var results = this.models!.where((element) => element.selected).toList();
      models = results;
    }
    catch(_){}

    CustomNavigator.pop(context!, object: models);
  }

  orderStaff(String event) async {
    List<BookingStaffModel> events = [];
    if((models?.length ?? 0) != 0){
      events = models!.where((element) => element.selected).toList();
    }
    ResponseModel response = await repository.orderStaff(context, BookingStaffRequestModel(
        branchId: branchId
    ));
    if(response.success!){
      var responseModel = BookingStaffResponseModel.fromJson(response.datas);

      models = responseModel.data ?? [];

      _handleStaffs(events);
    }
    else{
      models = [];
    }

    search(event);
  }

  _handleStaffs(List<BookingStaffModel> events){
    for(var e in events){
      try{
        models!.firstWhere((element) => element.staffId == e.staffId).selected = true;
      }
      catch(_){}
    }
  }
}