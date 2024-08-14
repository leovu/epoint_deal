
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/request/voucher_request_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response/branch_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/room_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/order_discount_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/order_multi_staff_screen.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class OrderedServiceBloc extends BaseBloc {
  OrderedServiceBloc(BuildContext context) {
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controllerPrice.dispose();
    controllerDiscount.dispose();
    _streamVoucherModel.close();
    controllerSurcharge.dispose();
    _streamStaffModels.close();
    controllerStaff.dispose();
    controllerNote.dispose();
    _streamRoomModels.close();
    _streamRoomModel.close();
    super.dispose();
  }

  late ServiceNewModel model;
  CustomerModel? customerModel;
  BranchModel branchModel = BranchModel(branchId: Global.branchId);
  DiscountCartModel? voucherModel;
  List<BookingStaffModel>? staffModels;
  late bool isBooking;
  int? initRoom;
  CustomDropdownModel? roomModel;

  final FocusNode focusQuantity = FocusNode();
  final TextEditingController controllerQuantity = TextEditingController();
  final FocusNode focusPrice = FocusNode();
  final TextEditingController controllerPrice = TextEditingController();
  final FocusNode focusDiscount = FocusNode();
  final TextEditingController controllerDiscount = TextEditingController();
  final FocusNode focusSurcharge = FocusNode();
  final TextEditingController controllerSurcharge = TextEditingController();
  final FocusNode focusStaff = FocusNode();
  final TextEditingController controllerStaff = TextEditingController();
  final FocusNode focusNote = FocusNode();
  final TextEditingController controllerNote = TextEditingController();

  final _streamVoucherModel = BehaviorSubject<DiscountCartModel?>();
  ValueStream<DiscountCartModel?> get outputVoucherModel =>
      _streamVoucherModel.stream;
  setVoucherModel(DiscountCartModel? event) => set(_streamVoucherModel, event);

  final _streamStaffModels = BehaviorSubject<List<BookingStaffModel>?>();
  ValueStream<List<BookingStaffModel>?> get outputStaffModels =>
      _streamStaffModels.stream;
  setStaffModels(List<BookingStaffModel>? event) =>
      set(_streamStaffModels, event);

  final _streamRoomModels = BehaviorSubject<List<CustomDropdownModel>?>();
  ValueStream<List<CustomDropdownModel>?> get outputRoomModels =>
      _streamRoomModels.stream;
  setRoomModels(List<CustomDropdownModel> event) =>
      set(_streamRoomModels, event);
  setRoomError(String? event) => setError(_streamRoomModels, event);

  final _streamRoomModel = BehaviorSubject<CustomDropdownModel?>();
  ValueStream<CustomDropdownModel?> get outputRoomModel =>
      _streamRoomModel.stream;
  setRoomModel(CustomDropdownModel? event) => set(_streamRoomModel, event);

  removeVoucher() {
    voucherModel = null;
    controllerDiscount.text = "";
    setVoucherModel(null);
  }

  chooseVoucher() async {
    DiscountCartModel? event = await CustomNavigator.push(
        context!,
        OrderDiscountScreen(
          customerModel: customerModel,
          model: ArrObject(
              objectId: model.serviceId, objectType: subjectTypeService),
          amount:
              parseMoney(controllerPrice.text, defaultValue: model.newPrice),
        ));
    if (event != null) {
      voucherModel = event;
      controllerDiscount.text = formatMoney(getDiscount(voucherModel,
          total:
              parseMoney(controllerPrice.text, defaultValue: model.newPrice) *
                  parseMoney(controllerQuantity.text,
                      defaultValue: defaultCartQuantity)));
      setVoucherModel(event);
    }
  }

  pushStaff() async {
    List<BookingStaffModel>? result = await CustomNavigator.push(
        context!,
        OrderMultiStaffScreen(
          branchId: branchModel.branchId,
          models: staffModels,
        ));
    if (result != null) {
      staffModels = result;
      setStaffModels(staffModels);
    }
  }

  deleteStaff(BookingStaffModel model) {
    staffModels!.remove(model);
    setStaffModels(staffModels);
  }

  getRoom(bool isRefresh) async {
    if (roomModel != null) {
      return;
    }
    ResponseModel response = await repository.getRoom(context);
    if (response.success!) {
      final responseModel = RoomResponseModel.fromJson(response.datas);

      List<CustomDropdownModel> models = [];
      if ((responseModel.data?.length ?? 0) != 0) {
        for (var e in responseModel.data!) {
          models.add(CustomDropdownModel(id: e.roomId, text: e.name));
        }
      }

      setRoomModels(models);
      if (initRoom != null) {
        try {
          roomModel = models.firstWhere((element) => element.id == initRoom);
          setRoomModel(roomModel);
        } catch (_) {}
      }
    } else {
      if (!isRefresh) {
        setRoomError(AppLocalizations.text(LangKey.has_error_try_again));
      }
    }
  }

  selectRoom(CustomDropdownModel? model) {
    roomModel = model;
    setRoomModel(roomModel);
  }
}
