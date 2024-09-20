import 'dart:io';

import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/assign_revoke_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/get_history_req_model.dart';
import 'package:epoint_deal_plugin/model/request/upload_file_req_model.dart';
import 'package:epoint_deal_plugin/model/response/care_deal_response_model.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_status_work_response_model.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_file_response_model.dart';
import 'package:epoint_deal_plugin/model/response/list_note_res_model.dart';
import 'package:epoint_deal_plugin/model/response/order_history_model_response.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/list_customer_care_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/list_file_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/list_order_history_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/note_module/ui/add_file_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/note_module/ui/create_note_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/note_module/ui/list_note_screen.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/presentation/list_product_detail/list_products_detail_deal_screen.dart';
import 'package:epoint_deal_plugin/utils/custom_document_picker.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  ValueStream<DetailDealData?> get outputModel => _streamModel.stream;
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

  setListNoteData(List<NoteData>? event) => set(_streamListNote, event);

  final _streamLisProductBuy = BehaviorSubject<List<ProductBuy>?>();
  ValueStream<List<ProductBuy>?> get outputListProductBuy =>
      _streamLisProductBuy.stream;

  setListProductBuy(List<ProductBuy>? event) =>
      set(_streamLisProductBuy, event);

  final _streamOrderHistory = BehaviorSubject<List<OrderHistoryData>?>();
  ValueStream<List<OrderHistoryData>?> get outputOrderHistory =>
      _streamOrderHistory.stream;
  setOrderHistory(List<OrderHistoryData>? event) =>
      set(_streamOrderHistory, event);

  final _streamCareDeal = BehaviorSubject<List<CareDealData>?>();
  ValueStream<List<CareDealData>?> get outputCareDeal => _streamCareDeal.stream;
  setCareDeal(List<CareDealData>? event) => set(_streamCareDeal, event);

  final _streamDealsFile = BehaviorSubject<List<DealFilesModel>?>();
  ValueStream<List<DealFilesModel>?> get outputDealsFile =>
      _streamDealsFile.stream;
  setDealsFile(List<DealFilesModel>? event) => set(_streamDealsFile, event);

  final _streamExpandOrderHistory = BehaviorSubject<bool>();
  ValueStream<bool> get outputExpandOrderHistory =>
      _streamExpandOrderHistory.stream;
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

  final _streamExpandListProduct = BehaviorSubject<bool>();
  ValueStream<bool> get outputExpandListProduct =>
      _streamExpandListProduct.stream;
  setExpandListProduct(bool event) => set(_streamExpandListProduct, event);

  List<NoteData> listNoteData = [];
  List<CareDealData> listCareDeal = [];
  List<OrderHistoryData> listOrderHistory = [];
  List<DealFilesModel> listDealFiles = [];
  DetailDealData? detail;

  List<Widget>? children;

  bool expandOrderHistory = false;
  bool expandCareDeal = false;
  bool expandListNote = false;
  bool expandListFile = false;
  bool expandListProduct = false;

  resetExpand() {
    expandOrderHistory = false;
    expandCareDeal = false;
    expandListNote = false;
    expandListFile = false;
    expandListProduct = false;
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
    setExpandListProduct(expandListProduct);
  }

  Future<List<OrderHistoryData>?> getOrderHistory(BuildContext context) async {
    ResponseModel responseData = await repository.getOrderHistory(
        context, GetHistoryReqModel(deal_code: detail?.dealCode));
    if (responseData.success ?? false) {
      if (responseData.data == null) {
        return null;
      }
      OrderHistoryResponseData response =
          OrderHistoryResponseData.fromJson(responseData.data!);

      listOrderHistory = response.orders ?? [];
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
      setCareDeal(listCareDeal);
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

  Future<List<DealFilesModel>?> getListFile(BuildContext context) async {
    ResponseModel responseData = await repository.getListFile(
        context, GetCareDealModel(deal_id: detail?.dealId));
    if (responseData.success ?? false) {
      var response = ListDealFilesResponseModel.fromList(responseData.datas);

      listDealFiles = response.data ?? [];
      setDealsFile(listDealFiles);
      return listDealFiles;
    }
    return null;
  }

  onAddNote(Function? onReload) async {
    bool? event = await CustomNavigator.showCustomBottomDialog(
        context!,
        CreateNoteScreen(
          model: detail!,
        ));
    if (event == null || event) {
      onReload?.call();
    }
  }

  onTapListCustomerCare() {
    CustomNavigator.push(context!, ListCustomerCareScreen(bloc: this));
  }

  onTapListOrDerHistory() {
    CustomNavigator.push(context!, ListOrderHistoryScreen(bloc: this));
  }

  onTapListNote() {
    CustomNavigator.push(context!, ListNoteScreen(bloc: this, model: detail!));
  }

  onTapListFile() {
    CustomNavigator.push(context!, ListFileScreen(bloc: this));
  }

  onTapListProduct() {
    CustomNavigator.push(
        context!, ListProductsDetailDealScreen(bloc: this, detail: detail));
  }

  onOpenFile(String? name, String? path) {
    Navigator.of(context!).push(
        MaterialPageRoute(builder: (context) => CustomFileView(path, name)));
  }

  onAddFile() {
    Navigator.of(context!).push(MaterialPageRoute(
        builder: (context) => AddFileScreen(
              bloc: this,
            )));
  }

  Future<File?> uploadFile() async {
    File? file = await CustomDocumentPicker.openDocument(context!, params: [
      "txt",
      "pdf",
      "doc",
      "docx",
      "xls",
      "xlsx",
      "xlsm",
      "pptx",
      "ppt",
      "jpeg",
      "jpg",
      "png"
    ]);
    if (file != null) {
      return file;
    }
    return null;
  }

  onSaveFile(File file, String content) {
    uploadFileAWS(file, content: content);
  }

  Future<bool> uploadFileAWS(File model, {String content = ""}) async {
    CustomNavigator.showProgressDialog(context);
    String? result = await DealConnection.uploadFileAWS(context, model);
    CustomNavigator.hideProgressDialog();
    if (result != null) {
      bool value = await addFile(UploadFileReqModel(
          dealId: detail?.dealId,
          path: result,
          content: content,
          fileName: model.path.split("/").last));
      return value;
    } else {
      DealConnection.handleError(
          context!, AppLocalizations.text(LangKey.server_error));
      return false;
    }
  }

  Future<bool> addFile(UploadFileReqModel model) async {
    try {
      ResponseModel responseData = await repository.addFile(context, model);
      return responseData.success ?? false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> assignRevokeDeal(AssignRevokeDealModelRequest model) async {
    try {
      final value = await DealConnection.assignRevokeDeal(context!, model);
      return value != null;
    } catch (e) {
      // Handle any errors if necessary
      return false;
    }
  }
}
