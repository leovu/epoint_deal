import 'package:epoint_deal_plugin/model/request/get_history_req_model.dart';
import 'package:epoint_deal_plugin/model/response/care_deal_response_model.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_note_res_model.dart';
import 'package:epoint_deal_plugin/model/response/order_history_model_response.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/list_customer_care_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/list_order_history_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/note_module/ui/list_note_screen.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class DetailDealBloc extends BaseBloc {
  DetailDealBloc(BuildContext context) {
    setContext(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

    final _streamModel = BehaviorSubject<DetailDealData?>();
  ValueStream<DetailDealData?> get outputModel =>
      _streamModel.stream;
  setModel(DetailDealData? event) => set(_streamModel, event);

  final _streamListOrderHistory = BehaviorSubject<List<OrderHistoryData>?>();
  ValueStream<List<OrderHistoryData>?> get outputListOrderHistory =>
      _streamListOrderHistory.stream;

  setListOrderHistory(List<OrderHistoryData>? event) =>
      set(_streamListOrderHistory, event);

  final _streamListCareDealData = BehaviorSubject<List<CareDealData>?>();
  ValueStream<List<CareDealData>?> get outputListCareDealData =>
      _streamListCareDealData.stream;

  setListCareDealData(List<CareDealData>? event) =>
      set(_streamListCareDealData, event);

  final _streamListNote = BehaviorSubject<List<NoteData>?>();
  ValueStream<List<NoteData>?> get outputListNote => _streamListNote.stream;

  setListNoteData(List<NoteData>? event) =>
      set(_streamListNote, event);

      final _streamOrderHistory = BehaviorSubject<List<OrderHistoryData>?>();
  ValueStream<List<OrderHistoryData>?> get outputOrderHistory => _streamOrderHistory.stream;
  setOrderHistory(List<OrderHistoryData>? event) => set(_streamOrderHistory, event);

  final _streamCareDeal = BehaviorSubject<List<CareDealData>?>();
  ValueStream<List<CareDealData>?> get outputCareDeal => _streamCareDeal.stream;
  setCareDeal(List<CareDealData>? event) => set(_streamCareDeal, event);

  final _streamExpandOrderHistory = BehaviorSubject<bool>();
  ValueStream<bool> get outputExpandOrderHistory => _streamExpandOrderHistory.stream;
  setExpandOrderHistory(bool event) => set(_streamExpandOrderHistory, event);

  final _streamExpandCareDeal = BehaviorSubject<bool>();
  ValueStream<bool> get outputExpandCareDeal => _streamExpandCareDeal.stream;
  setExpandCareDeal(bool event) => set(_streamExpandCareDeal, event);

  final _streamExpandListNote = BehaviorSubject<bool>();
  ValueStream<bool> get outputExpandListNote => _streamExpandListNote.stream;
  setExpandListNote(bool event) => set(_streamExpandListNote, event);

  final _streamExpandListFile = BehaviorSubject<bool>();
  ValueStream<bool> get outputExpandListFile => _streamExpandListFile.stream;
  setExpandListFile(bool event) => set(_streamExpandListFile, event);
  
  List<NoteData> listNoteData = [];
  List<CareDealData> listCareDeal = [];
  List<OrderHistoryData> listOrderHistory = [];
  DetailDealData? detail;

  List<Widget>? children;

  bool expandOrderHistory = false;
  bool expandCareDeal = false;
  bool expandListNote = false;
  bool expandListFile = false;


  resetExpand() {
    expandOrderHistory = false;
    expandCareDeal = false;
    expandListNote = false;
    expandListFile = false;
  }

  onSetExpand(Function onFunction) {
    resetExpand();
    onFunction();
    resetStreamExpand();
  }

  resetStreamExpand() {
    setExpandOrderHistory(expandOrderHistory);
    setExpandCareDeal(expandCareDeal);
    setExpandListNote(expandListNote);
    setExpandListFile(expandListFile);
  }



  Future<List<OrderHistoryData>?> getOrderHistory(BuildContext context) async {
    ResponseModel responseData = await repository.getOrderHistory(
        context, GetHistoryReqModel(deal_code: detail?.dealCode));
    if (responseData.success ?? false) {
      var response = OrderHistoryResponseModel.fromList(responseData.datas);

      listOrderHistory = response.data ?? [];
      setListOrderHistory(listOrderHistory);
      return listOrderHistory;
    }
    return null;
  }

  Future<List<CareDealData>?> getCareDeal(BuildContext context) async {
    ResponseModel responseData = await repository.getCareDeal(
        context, GetCareDealModel(deal_id: detail?.dealId));
    if (responseData.success ?? false) {
      var response = CareDealResponseModel.fromList(responseData.datas);

      listCareDeal = response.data ?? [];
      setListCareDealData(listCareDeal);
      return listCareDeal;
    }
    return null;
  }

  Future<List<NoteData>?> getListNote(BuildContext context) async {
    ResponseModel responseData = await repository.getListNote(
        context, GetListNoteModel(customer_deal_id: detail?.dealId));
    if (responseData.success ?? false) {
      var response = ListNoteResponseModel.fromList(responseData.datas);

      listNoteData = response.data ?? [];
      setListNoteData(listNoteData);
      return listNoteData;
    }
    return null;
  }


  onTapListCustomerCare() {
    CustomNavigator.push(context!, ListCustomerCareScreen(bloc: this));
  }

  onTapListOrDerHistory() {
    CustomNavigator.push(context!, ListOrderHistoryScreen(bloc: this));
  }

  onTapListNote() {
    CustomNavigator.push(context!, ListNoteScreen(bloc: this, model: detail!,));
  }
}
