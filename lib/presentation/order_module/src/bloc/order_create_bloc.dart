import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/request/booking_store_request_model.dart';
import 'package:epoint_deal_plugin/model/request/member_discount_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_store_request_model.dart';
import 'package:epoint_deal_plugin/model/request/other_free_branch_request_model.dart';
import 'package:epoint_deal_plugin/model/request/transport_method_request_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_list_response_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response/create_order_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/member_discount_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/other_free_branch_response_model.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/transport_method_response_model.dart';
import 'package:epoint_deal_plugin/model/response/vat_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/category_module/src/ui/category_screen.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/activated_service_card_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/booking_surcharge_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/order_detail_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/order_payment_new_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/order_staff_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/ordered_product_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/ordered_service_card_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/ordered_service_screen.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:rxdart/rxdart.dart';

import '../ui/order_create_screen.dart';
import '../ui/order_discount_screen.dart';

class OrderCreateBloc extends BaseBloc {
  OrderCreateBloc(
      BuildContext context,
      OrderDetailResponseModel? model,
      List<ProductNewModel>? productModels,
      List<ServiceNewModel>? serviceModels,
      List<OrderServiceCardModel>? serviceCardModels,
      List<ServiceCardModel>? serviceCardActivatedModels,
      CustomerModel? customerModel,
      DeliveryAddress? deliveryAddressModel) {
    setContext(context);

    if (checkConfigKey(ConfigKey.vat)) {
      final vatModel = Globals.configModels
          ?.firstWhereOrNull((element) => element.key == ConfigKey.vat_value);
      if (vatModel != null) {
        vatDefault = double.tryParse(vatModel.value ?? "");
      }

      final configModel = Globals.configModels?.firstWhereOrNull(
          (element) => element.key == ConfigKey.vat_price_config);
      if (configModel != null) {
        vatIncluded = configModel.value == vatPriceConfigInclude;
      }
    }

    if (model == null) {
      setDate(DateTime.now());

      staffModel = BookingStaffModel(
          staffId: Globals.model!.staffId, fullName: Globals.model!.fullName);
    } else {
      isEdit = true;
      detailModel = model;

      if (model.processStatus == orderStatusNew) {
        statusModels = Globals.orderStatusModels
            .where((element) =>
                element.id == orderStatusNew ||
                element.id == orderStatusConfirmed)
            .map((e) => BookingStatusUpdateModel(
                status: e.id, statusName: e.text, colorPrimary: e.color))
            .toList();
      } else {
        statusModels = Globals.orderStatusModels
            .where((element) => element.id == model.processStatus)
            .map((e) => BookingStatusUpdateModel(
                status: e.id, statusName: e.text, colorPrimary: e.color))
            .toList();
      }
      statusModel = statusModels!.firstWhereOrNull(
              (element) => element.status == model.processStatus) ??
          statusModels!.first;

      if ((model.orderDate ?? "").isNotEmpty) {
        setDate(parseDate(model.orderDate) ?? DateTime.now());
      }

      controllerNote.text = model.orderDescription ?? "";

      isAtStore = model.receiveAtCounter == 1;

      if (!isAtStore) {
        if (model.customerContactCode != null) {
          if (model.customerId == customerGuestId) {
            this.deliveryAddressModel = deliveryAddressModel;
          } else {
            this.deliveryAddressModel = customerModel!.deliveryAddress
                ?.firstWhereOrNull((element) =>
                    element.customerContactCode == model.customerContactCode);
          }
        }
      }

      if ((model.discount ?? 0.0) > 0) {
        voucherModel = parseDiscount(model.discount, model.discountType,
            model.discountValue, model.discountCode);
        controllerDiscount.text = formatMoney(model.discount);
      }

      if (model.saleId != null) {
        staffModel =
            BookingStaffModel(staffId: model.saleId, fullName: model.saleName);
      }

      if (model.referId != null) {
        presenterModel =
            CustomerModel(customerId: model.referId, fullName: model.referName);
        controllerPresenter.text = presenterModel!.fullName ?? "";
      }

      if ((model.otherFee?.length ?? 0) > 0) {
        surchargeModels = model.otherFee!
            .map((e) => OtherFreeBranchModel.fromJson(e.toJson()))
            .toList();
      }

      if (model.vatId != null) {
        vatModel = CustomDropdownModel(
            id: model.vatId,
            text: model.vatDescription,
            data: double.tryParse(model.vat ?? ""));
      }
    }

    this.customerModel = customerModel ?? guestCustomerModel;

    Globals.cart!.products.addAll(productModels ?? []);
    Globals.cart!.services.addAll(serviceModels ?? []);
    Globals.cart!.serviceCards.addAll(serviceCardModels ?? []);
    Globals.cart!.serviceActivatedCards
        .addAll(serviceCardActivatedModels ?? []);

    total = Globals.cart!.getValue();

    controllerStaff.text = staffModel?.fullName ?? "";
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamCustomerModel.close();
    _streamProductModels.close();
    _streamServiceModels.close();
    _streamServiceCardModels.close();
    _streamServiceCardActivatedModels.close();
    _streamVoucherModel.close();
    _streamIsAtStore.close();
    _streamDeliveryAddressModel.close();
    _streamPresenterModel.close();
    _streamStaffModel.close();
    _streamMemberDiscountModel.close();
    _streamTransportCharge.close();
    _streamTransportMethodModels.close();
    _streamSurchargeModels.close();
    super.dispose();
  }

  OrderDetailResponseModel? detailModel;
  bool isEdit = false;
  BookingDetailResponseModel? bookingModel;

  List<BookingStatusUpdateModel>? statusModels;
  BookingStatusUpdateModel? statusModel;
  CustomerModel? customerModel;
  CustomerModel guestCustomerModel = CustomerModel(
    customerId: customerGuestId,
  );
  CustomerModel? presenterModel;
  late DateTime date;
  bool isAtStore = true;
  DeliveryAddress? deliveryAddressModel;
  DiscountCartModel? voucherModel;
  double discount = 0.0;
  double total = 0.0;
  double amountBeforeTax = 0.0;
  double totalTax = 0.0;
  double amount = 0.0;
  double? transportCharge;
  TransportMethodModel? transportModel;
  MemberDiscountResponseModel? discountMemberModel;
  double discountMember = 0;
  bool discountMemberHasError = false;
  Object? discountMemberError;
  DateTime? _discountMemberFl;
  final defaultDiscountMemberModel =
      MemberDiscountResponseModel(discountMember: "0");
  BookingStaffModel? staffModel;
  bool surchargeInit = false;
  List<OtherFreeBranchModel> surchargeModels = [];
  double surcharge = 0.0;
  List<CustomDropdownModel>? vatModels;
  double? vatDefault;
  CustomDropdownModel? vatModel;
  bool vatIncluded = false;

  final FocusNode focusDate = FocusNode();
  final TextEditingController controllerDate = TextEditingController();

  final FocusNode focusNote = FocusNode();
  final TextEditingController controllerNote = TextEditingController();

  final FocusNode focusDiscount = FocusNode();
  final TextEditingController controllerDiscount = TextEditingController();

  final FocusNode focusStaff = FocusNode();
  final TextEditingController controllerStaff = TextEditingController();

  final FocusNode focusPresenter = FocusNode();
  final TextEditingController controllerPresenter = TextEditingController();

  final _streamCustomerModel = BehaviorSubject<CustomerModel?>();
  ValueStream<CustomerModel?> get outputCustomerModel =>
      _streamCustomerModel.stream;
  setCustomerModel(CustomerModel? event) => set(_streamCustomerModel, event);
  final _streamProductModels = BehaviorSubject<List<ProductNewModel>?>();
  ValueStream<List<ProductNewModel>?> get outputProductModels =>
      _streamProductModels.stream;
  setProductModels(List<ProductNewModel>? event) =>
      set(_streamProductModels, event);

  final _streamServiceModels = BehaviorSubject<List<ServiceNewModel>?>();
  ValueStream<List<ServiceNewModel>?> get outputServiceModels =>
      _streamServiceModels.stream;
  setServiceModels(List<ServiceNewModel>? event) =>
      set(_streamServiceModels, event);

  final _streamServiceCardModels =
      BehaviorSubject<List<OrderServiceCardModel>?>();
  ValueStream<List<OrderServiceCardModel>?> get outputServiceCardModels =>
      _streamServiceCardModels.stream;
  setServiceCardModels(List<OrderServiceCardModel>? event) =>
      set(_streamServiceCardModels, event);

  final _streamServiceCardActivatedModels =
      BehaviorSubject<List<ServiceCardModel>?>();
  ValueStream<List<ServiceCardModel>?> get outputServiceCardActivatedModels =>
      _streamServiceCardActivatedModels.stream;
  setServiceCardActivatedModels(List<ServiceCardModel>? event) =>
      set(_streamServiceCardActivatedModels, event);

  final _streamVoucherModel = BehaviorSubject<DiscountCartModel?>();
  ValueStream<DiscountCartModel?> get outputVoucherModel =>
      _streamVoucherModel.stream;
  setVoucherModel(DiscountCartModel? event) => set(_streamVoucherModel, event);

  final _streamIsAtStore = BehaviorSubject<bool>();
  ValueStream<bool> get outputIsAtStore => _streamIsAtStore.stream;
  setIsAtStore(bool event) => set(_streamIsAtStore, event);

  final _streamDeliveryAddressModel = BehaviorSubject<DeliveryAddress?>();
  ValueStream<DeliveryAddress?> get outputDeliveryAddressModel =>
      _streamDeliveryAddressModel.stream;
  setDeliveryAddressModel(DeliveryAddress? event) =>
      set(_streamDeliveryAddressModel, event);

  final _streamPresenterModel = BehaviorSubject<CustomerModel?>();
  ValueStream<CustomerModel?> get outputPresenterModel =>
      _streamPresenterModel.stream;
  setPresenterModel(CustomerModel? event) => set(_streamPresenterModel, event);

  final _streamStaffModel = BehaviorSubject<BookingStaffModel?>();
  ValueStream<BookingStaffModel?> get outputStaffModel =>
      _streamStaffModel.stream;
  setStaffModel(BookingStaffModel? event) => set(_streamStaffModel, event);

  final _streamMemberDiscountModel =
      BehaviorSubject<MemberDiscountResponseModel?>();
  ValueStream<MemberDiscountResponseModel?> get outputMemberDiscountModel =>
      _streamMemberDiscountModel.stream;
  setMemberDiscountModel(MemberDiscountResponseModel? event) =>
      set(_streamMemberDiscountModel, event);
  setMemberDiscountModelError(String? event) =>
      setError(_streamMemberDiscountModel, event);

  final _streamTransportCharge = BehaviorSubject<double?>();
  ValueStream<double?> get outputTransportCharge =>
      _streamTransportCharge.stream;
  setTransportCharge(double? event) {
    transportCharge = event;
    set(_streamTransportCharge, event);
  }

  setTransportChargeError(String event) =>
      setError(_streamTransportCharge, event);

  final _streamTransportMethodModels =
      BehaviorSubject<List<TransportMethodModel>?>();
  ValueStream<List<TransportMethodModel>?> get outputTransportMethodModels =>
      _streamTransportMethodModels.stream;
  setTransportMethodModels(List<TransportMethodModel>? event) =>
      set(_streamTransportMethodModels, event);
  setTransportMethodModelsError(String event) =>
      setError(_streamTransportMethodModels, event);

  final _streamSurchargeModels = BehaviorSubject<List<OtherFreeBranchModel>>();
  ValueStream<List<OtherFreeBranchModel>> get outputSurchargeModels =>
      _streamSurchargeModels.stream;
  setSurchargeModels(List<OtherFreeBranchModel> event) =>
      set(_streamSurchargeModels, event);

  final _streamVATModels = BehaviorSubject<List<CustomDropdownModel>?>();
  ValueStream<List<CustomDropdownModel>?> get outputVATModels =>
      _streamVATModels.stream;
  setVATModels(List<CustomDropdownModel>? event) =>
      set(_streamVATModels, event);

  final _streamVATModel = BehaviorSubject<CustomDropdownModel?>();
  ValueStream<CustomDropdownModel?> get outputVATModel =>
      _streamVATModel.stream;
  setVATModel(CustomDropdownModel? event) => set(_streamVATModel, event);

  Future onRefresh({bool isRefresh = true, bool isInit = false}) {
    final group = <Future>[];
    group.add(getMemberDiscount(isRefresh: isRefresh));
    if (deliveryAddressModel != null) {
      group.add(getTransportMethod(
          TransportMethodRequestModel(
              customerId: customerModel!.customerId,
              customerContactCode: deliveryAddressModel!.customerContactCode),
          isRefresh: isRefresh,
          isInit: isInit));
    }
    if (checkConfigKey(ConfigKey.vat)) {
      group.add(orderVAT());
    }
    return Future.wait(group);
  }

  pop() {
    CustomNavigator.showCustomAlertDialog(
        context!,
        AppLocalizations.text(LangKey.notification),
        AppLocalizations.text(isEdit
            ? LangKey.confirm_cancel_order_editing
            : LangKey.confirm_cancel_order_creation),
        enableCancel: true,
        textSubmitted: AppLocalizations.text(LangKey.confirm), onSubmitted: () {
      CustomNavigator.pop(context!);
      CustomNavigator.pop(context!);
    });
  }

  chooseCustomer() async {
    // var result = await CustomNavigator.push(
    //     context!,
    //     CustomerNewScreen(
    //       isCartChoose: true,
    //     ));
    // if (result != null) {
    //   customerModel = result;
    //   setCustomerModel(customerModel);
    //   clearDeliveryAddress();
    //   resetDeliveryAddress();
    //   getMemberDiscount();
    //   if (voucherModel?.model != null) {
    //     removeVoucher();
    //     CustomNavigator.showCustomAlertDialog(
    //         context!,
    //         AppLocalizations.text(LangKey.notification),
    //         AppLocalizations.text(LangKey.check_discount_code));
    //   }
    // }
  }

  removeCustomer() {
    customerModel = guestCustomerModel;
    setCustomerModel(customerModel);
    Globals.cart!.removeAllServiceCardActivated();
    removeVoucher();
  }

  showDateTime(TextEditingController controller) async {
    DatePicker.showDateTimePicker(context!,
        minTime: minDateTime,
        maxTime: DateTime.now().add(Duration(days: 365)),
        currentTime: date,
        locale: Globals.localeType,
        onConfirm: setDate);
  }

  setDate(DateTime event) {
    date = event;
    controllerDate.text = formatDate(date, format: AppFormat.formatDateTime);
  }

  onAddItems() async {
    await CustomNavigator.push(
        context!,
        CategoryScreen(
          isSelected: true,
          customerModel: customerModel,
        ));
    setCustomerModel(customerModel);
    removeVoucher();
  }

  onProductTap(ProductNewModel model) async {
    bool? event = await CustomNavigator.push(
        context!,
        OrderedProductScreen(
          model: model,
          customerModel: customerModel,
        ));
    if ((event ?? false)) {
      setProductModels(Globals.cart!.products);
      removeVoucher();
      Globals.cart!.getValue();
    }
  }

  onServiceTap(ServiceNewModel model) async {
    bool? event = await CustomNavigator.push(
        context!,
        OrderedServiceScreen(
          model: model,
          customerModel: customerModel,
        ));
    if ((event ?? false)) {
      setServiceModels(Globals.cart!.services);
      removeVoucher();
      Globals.cart!.getValue();
    }
  }

  onServiceCardTap(OrderServiceCardModel model) async {
    bool? event = await CustomNavigator.push(
        context!,
        OrderedServiceCardScreen(
          model: model,
          customerModel: customerModel,
        ));
    if ((event ?? false)) {
      setServiceCardModels(Globals.cart!.serviceCards);
      removeVoucher();
      Globals.cart!.getValue();
    }
  }

  onServiceCardActivatedTap(ServiceCardModel model) async {
    bool? event = await CustomNavigator.push(
        context!,
        ActivatedServiceCardScreen(
          model: model,
        ));
    if ((event ?? false)) {
      setServiceCardActivatedModels(Globals.cart!.serviceActivatedCards);
      Globals.cart!.getValue();
    }
  }

  onProductRemove(ProductNewModel model) {
    Globals.cart!.removeProduct(model);
    setProductModels(Globals.cart!.products);
  }

  onServiceRemove(ServiceNewModel model) {
    Globals.cart!.removeService(model);
    setServiceModels(Globals.cart!.services);
  }

  onServiceCardRemove(OrderServiceCardModel model) {
    Globals.cart!.removeServiceCard(model);
    setServiceCardModels(Globals.cart!.serviceCards);
  }

  onServiceCardActivatedRemove(ServiceCardModel model) {
    Globals.cart!.removeServiceCardActivated(model);
    setServiceCardActivatedModels(Globals.cart!.serviceActivatedCards);
  }

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
          fromOrder: true,
        ));
    if (event != null) {
      voucherModel = event;
      controllerDiscount.text =
          formatMoney(getDiscount(voucherModel, total: total));
      setVoucherModel(event);
    }
  }

  onType(bool value) {
    isAtStore = value;
    setIsAtStore(isAtStore);
    checkTransportCharge();
    // if (!isAtStore && deliveryAddressModel == null) {
    //   chooseDeliveryAddress();
    // }
  }

  checkTransportCharge() {
    if (!isAtStore && deliveryAddressModel != null) {
      getTransportMethod(TransportMethodRequestModel(
          customerId: customerModel!.customerId,
          customerContactCode: deliveryAddressModel!.customerContactCode));
    } else {
      setTransportMethodModels([]);
      setTransportCharge(0);
    }
  }

  selectTransportMethod(
      List<TransportMethodModel>? models, TransportMethodModel model) {
    transportModel = model;
    setTransportMethodModels(models);
    setTransportCharge(model.transportCharge ?? 0);
  }

  chooseDeliveryAddress() async {
    // DeliveryAddress? event;
    // if (customerModel!.customerId != customerGuestId &&
    //     (customerModel!.deliveryAddress?.length ?? 0) > 0) {
    //   event = await CustomNavigator.push(
    //       context!,
    //       CustomerShippingAddressNewScreen(
    //         model: CustomerDetailResponseModel(
    //             customerId: customerModel!.customerId,
    //             deliveryAddress: customerModel!.deliveryAddress),
    //         customerModel: customerModel,
    //       ));
    // } else {
    //   event = await CustomNavigator.push(
    //       context!,
    //       CreateCustomerShippingAddressNewScreen(
    //         customerModel!.customerId,
    //         isCart: true,
    //         model: deliveryAddressModel,
    //       ));
    // }

    // if (event != null) {
    //   setDeliveryAddress(event);
    // }
  }

  setDeliveryAddress(DeliveryAddress? event) {
    deliveryAddressModel = event;
    setDeliveryAddressModel(deliveryAddressModel);
    checkTransportCharge();
  }

  resetDeliveryAddress() {
    if (customerModel?.customerId != customerGuestId &&
        (customerModel?.deliveryAddress?.length ?? 0) != 0) {
      DeliveryAddress? model = customerModel!.deliveryAddress
          ?.firstWhereOrNull((element) => element.addressDefault == 1);
      setDeliveryAddress(model);
    }
  }

  clearDeliveryAddress() {
    setDeliveryAddress(null);
  }

  onChoosePresenter() async {
    // var result = await CustomNavigator.push(
    //     context!,
    //     CustomerNewScreen(
    //       isCartChoose: true,
    //     ));
    // if (result != null) {
    //   presenterModel = result;
    //   controllerPresenter.text = result.fullName ?? "";
    //   setPresenterModel(presenterModel);
    // }
  }

  onDeletePresenter() {
    presenterModel = null;
    controllerPresenter.text = "";
    setPresenterModel(presenterModel);
  }

  onChooseStaff() async {
    var result = await CustomNavigator.push(
        context!, OrderStaffScreen(Globals.model?.branchId));
    if (result != null) {
      staffModel = result;
      controllerStaff.text = result.fullName!;
      setStaffModel(staffModel);
    }
  }

  onDeleteStaff() {
    staffModel = null;
    controllerStaff.text = "";
    setStaffModel(staffModel);
  }

  onSelectVAT(CustomDropdownModel? model) {
    vatModel = model;
    setVATModel(vatModel);
  }

  onRemoveVAT() {
    vatModel = null;
    setVATModel(vatModel);
  }

  onRemoveSurcharge() {
    for (var e in surchargeModels) {
      e.isSelected = false;
    }
    setSurchargeModels(surchargeModels);
  }

  double getSurcharge(double amount) {
    final models =
        surchargeModels.where((element) => element.isSelected).toList();
    double surcharge = 0.0;
    for (var e in models) {
      surcharge += e.isMoney
          ? parseMoney(e.controller.text)
          : (int.tryParse(e.controller.text) ?? 0.0) / 100 * amount;
    }
    return surcharge;
  }

  getMemberDiscount({bool isRefresh = false}) async {
    if (customerModel!.customerId == customerGuestId) {
      setMemberDiscountModel(defaultDiscountMemberModel);
      return;
    }
    final now = DateTime.now();
    _discountMemberFl = now;
    if (!isRefresh) {
      setMemberDiscountModel(null);
    }
    ResponseModel response = await repository.getMemberDiscount(
        context,
        MemberDiscountRequestModel(
            brandCode: Global.brandCode,
            amount: total,
            customerId: customerModel!.customerId));
    if (response.success!) {
      final responseModel =
          MemberDiscountResponseModel.fromJson(response.data!);

      if (_discountMemberFl == now) {
        setMemberDiscountModel(responseModel);
      }
    } else {
      if (!isRefresh && _discountMemberFl == now) {
        setMemberDiscountModelError(response.errorDescription ?? "");
      }
    }
  }

  getTransportMethod(TransportMethodRequestModel model,
      {bool isRefresh = false, bool isInit = false}) async {
    if (!isRefresh) {
      transportModel = null;
      setTransportCharge(null);
      setTransportMethodModels(null);
    }
    ResponseModel response =
        await repository.getTransportMethod(context, model);
    if (response.success!) {
      final responseModel =
          TransportMethodResponseModel.fromJson(response.datas);

      if (isInit) {
        transportModel = responseModel.data!.firstWhereOrNull((element) =>
                element.typeShipping == detailModel!.typeShipping) ??
            responseModel.data?.first;

        setTransportCharge(transportModel?.transportCharge ?? 0);
      } else {
        if (!isRefresh || transportModel == null) {
          transportModel = responseModel.data!
                  .firstWhereOrNull((element) => element.isDefault == 1) ??
              responseModel.data?.first;

          setTransportCharge(transportModel?.transportCharge ?? 0);
        }
      }

      setTransportMethodModels(responseModel.data ?? []);
    } else {
      if (!isRefresh) {
        setTransportChargeError(response.errorDescription ?? "");
        setTransportMethodModelsError(response.errorDescription ?? "");
      }
    }
  }

  Future<OrderStoreRequestModel?> _getOrderRequestModel() async {
    if (Globals.cart!.isEmpty()) {
      CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          AppLocalizations.text(LangKey.you_have_not_added_products_services));
      return null;
    }

    if (!isAtStore) {
      if (deliveryAddressModel == null) {
        CustomNavigator.showCustomAlertDialog(
            context!,
            AppLocalizations.text(LangKey.notification),
            '${AppLocalizations.text(LangKey.please_choose_a_shipping_address)}!');
        return null;
      }

      if (transportModel == null) {
        CustomNavigator.showCustomAlertDialog(
            context!,
            AppLocalizations.text(LangKey.notification),
            '${AppLocalizations.text(LangKey.please_choose_a_shipping_method)}!');
        return null;
      }
    }

    List<OrderStoreModel> models = [];

    for (var e in Globals.cart!.products) {
      double quantity = e.quantity ?? defaultCartQuantity;
      double price = e.changePrice ?? e.newPrice ?? 0.0;
      double amount = quantity * price;

      String? discountType;
      double? discountValue;

      if (e.voucherModel != null) {
        if (e.voucherModel!.amount != null) {
          discountType = discountTypeCash;
          discountValue = e.voucherModel!.amount;
        } else if (e.voucherModel!.percent != null) {
          discountType = discountTypePercent;
          discountValue = e.voucherModel!.percent!.toDouble();
        } else {
          discountType = discountTypeCode;
          discountValue = e.voucherModel!.model!.discount;
        }
      }

      models.add(OrderStoreModel(
          objectType: subjectTypeProduct,
          objectId: e.productId,
          objectName: e.productName,
          objectCode: e.productCode,
          quantity: quantity,
          price: price,
          discountType: discountType,
          discountValue: discountValue,
          discount: e.discount,
          discountCode: e.voucherModel?.model?.voucherCode,
          amount: amount,
          surcharge: e.surcharge,
          staffId: e.staffModels?.map((e) => e.staffId ?? 0).toList(),
          note: e.note));
    }

    for (var e in Globals.cart!.services) {
      double quantity = e.quantity ?? defaultCartQuantity;
      double price = e.changePrice ?? e.newPrice ?? 0.0;
      double amount = quantity * price;

      String? discountType;
      double? discountValue;

      if (e.voucherModel != null) {
        if (e.voucherModel!.amount != null) {
          discountType = discountTypeCash;
          discountValue = e.voucherModel!.amount;
        } else if (e.voucherModel!.percent != null) {
          discountType = discountTypePercent;
          discountValue = e.voucherModel!.percent!.toDouble();
        } else {
          discountType = discountTypeCode;
          discountValue = e.voucherModel!.model!.discount;
        }
      }

      models.add(OrderStoreModel(
          objectType: subjectTypeService,
          objectId: e.serviceId,
          objectName: e.serviceName,
          objectCode: e.serviceCode,
          quantity: quantity,
          price: price,
          discountType: discountType,
          discountValue: discountValue,
          discount: e.discount,
          discountCode: e.voucherModel?.model?.voucherCode,
          amount: amount,
          surcharge: e.surcharge,
          staffId: e.staffModels?.map((e) => e.staffId ?? 0).toList(),
          note: e.note));
    }

    for (var e in Globals.cart!.serviceCards) {
      double quantity = e.quantity ?? defaultCartQuantity;
      double price = e.changePrice ?? e.price ?? 0.0;
      double amount = quantity * price;

      String? discountType;
      double? discountValue;

      if (e.voucherModel != null) {
        if (e.voucherModel!.amount != null) {
          discountType = discountTypeCash;
          discountValue = e.voucherModel!.amount;
        } else if (e.voucherModel!.percent != null) {
          discountType = discountTypePercent;
          discountValue = e.voucherModel!.percent!.toDouble();
        } else {
          discountType = discountTypeCode;
          discountValue = e.voucherModel!.model!.discount;
        }
      }

      models.add(OrderStoreModel(
          objectType: subjectTypeServiceCard,
          objectId: e.serviceCardId,
          objectName: e.name,
          objectCode: e.code,
          quantity: quantity,
          price: price,
          discountType: discountType,
          discountValue: discountValue,
          discount: e.discount,
          discountCode: e.voucherModel?.model?.voucherCode,
          amount: amount,
          surcharge: e.surcharge,
          staffId: e.staffModels?.map((e) => e.staffId ?? 0).toList(),
          note: e.note));
    }

    for (var e in Globals.cart!.serviceActivatedCards) {
      double quantity = e.quantity ?? defaultCartQuantity;
      double price = 0.0;
      double amount = quantity * price;

      String? discountType;
      double? discountValue;

      if (e.voucherModel != null) {
        if (e.voucherModel!.amount != null) {
          discountType = discountTypeCash;
          discountValue = e.voucherModel!.amount;
        } else if (e.voucherModel!.percent != null) {
          discountType = discountTypePercent;
          discountValue = e.voucherModel!.percent!.toDouble();
        } else {
          discountType = discountTypeCode;
          discountValue = e.voucherModel!.model!.discount;
        }
      }

      models.add(OrderStoreModel(
          objectType: subjectTypeMemberCard,
          objectId: e.customerServiceCardId,
          objectName: e.name,
          objectCode: e.cardCode,
          quantity: quantity,
          price: price,
          discountType: discountType,
          discountValue: discountValue,
          discount: e.discount,
          discountCode: e.voucherModel?.model?.voucherCode,
          amount: amount,
          surcharge: e.surcharge,
          staffId: e.staffModels?.map((e) => e.staffId ?? 0).toList(),
          note: e.note));
    }

    String? discountType;
    double? discountValue;

    if (voucherModel != null) {
      if (voucherModel!.amount != null) {
        discountType = discountTypeCash;
        discountValue = voucherModel!.amount;
      } else if (voucherModel!.percent != null) {
        discountType = discountTypePercent;
        discountValue = voucherModel!.percent!.toDouble();
      } else {
        discountType = discountTypeCode;
        discountValue = voucherModel!.model!.discount;
      }
    }

    return OrderStoreRequestModel(
        brandCode: Global.brandCode,
        customerId:
            customerModel == null ? customerGuestId : customerModel!.customerId,
        total: total,
        discountMember: discountMember,
        discount: discount,
        discountType: discountType,
        discountValue: discountValue,
        amount: amount,
        discountCode: voucherModel?.model?.voucherCode,
        customerContactCode: deliveryAddressModel?.customerContactCode,
        shippingAddress: deliveryAddressModel?.fullAddress,
        contactName: deliveryAddressModel?.contactName,
        contactPhone: deliveryAddressModel?.contactPhone,
        fullAddress: deliveryAddressModel?.fullAddress,
        typeTime: "in",
        orderDate: formatDate(date, format: AppFormat.formatDateResponse),
        tranportCharge: transportCharge,
        deliveryCostId: transportModel?.deliveryCostId,
        typeShipping: transportModel?.typeShipping,
        saleId: staffModel?.staffId,
        provinceId: deliveryAddressModel?.provinceId,
        districtId: deliveryAddressModel?.districtId,
        wardId: deliveryAddressModel?.wardId,
        orderDescription: controllerNote.text,
        referId: presenterModel?.customerId,
        receiveAtCounter: isAtStore ? 1 : 0,
        orderObjectId: bookingModel?.customerAppointmentId,
        orderObjectCode: bookingModel?.customerAppointmentCode,
        otherFee: surchargeModels
            .where((element) =>
                element.isSelected && element.controller.text.isNotEmpty)
            .toList()
            .map((e) {
          double value = e.isMoney
              ? parseMoney(e.controller.text)
              : (int.tryParse(e.controller.text) ?? 0).toDouble();
          double vat = 0;
          double valueVat = 0;
          double totalValue = e.isMoney ? value : value / 100 * total;
          return BookingOtherFeeModel(
              otherFeeId: e.otherFeeId,
              value: value.toString(),
              vat: vat.toString(),
              valueVat: valueVat.toString(),
              totalValue: totalValue.toString(),
              valueType: e.isMoney
                  ? otherFreeBranchTypeMoney
                  : otherFreeBranchTypePercent);
        }).toList(),
        totalOtherFee: surcharge,
        detail: models,
        vatId: vatModel?.id,
        vat: vatModel == null ? vatDefault : vatModel?.data,
        amountBeforeVat: amountBeforeTax.toString(),
        totalTax: totalTax.toString());
  }

  onPayment() async {
    final model = await _getOrderRequestModel();
    if (model != null) {
      if (isEdit) {
        model.orderId = detailModel?.orderId;
        orderUpdate(model, true);
      } else {
        orderStore(model, true);
      }
    }
  }

  onOrder() async {
    final model = await _getOrderRequestModel();
    if (model != null) {
      if (isEdit) {
        model.orderId = detailModel?.orderId;
        orderUpdate(model, false);
      } else {
        orderStore(model, false);
      }
    }
  }

  orderStore(OrderStoreRequestModel model, bool isPayment) async {
    CustomNavigator.showProgressDialog(context);
    ResponseModel response = await repository.orderStore(context, model);
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      final responseModel = CreateOrderResponseModel.fromJson(response.data!);
      if (isPayment) {
        await CustomNavigator.push(
            context!,
            OrderPaymentNewScreen(
              orderModel: responseModel.orderInfo,
            ));
      }
      await CustomNavigator.showCustomAlertDialog(
          context!,
          AppLocalizations.text(LangKey.notification),
          response.errorDescription,
          showSubmitted: false,
          child: CustomListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              CustomButton(
                  text: AppLocalizations.text(LangKey.view_order_details),
                  backgroundColor: AppColors.green300,
                  onTap: () async {
                    await CustomNavigator.push(
                        context!,
                        OrderDetailScreen(
                          id: responseModel.orderInfo?.orderId,
                        ));
                    CustomNavigator.pop(context!);
                  }),
              CustomButton(
                  text: AppLocalizations.text(LangKey.create_new_order),
                  onTap: () async {
                    await CustomNavigator.push(context!, OrderCreateScreen());
                    CustomNavigator.pop(context!);
                  }),
              CustomButton(
                  text: AppLocalizations.text(LangKey.returnString),
                  backgroundColor: AppColors.subColor,
                  onTap: () {
                    CustomNavigator.pop(context!);
                  }),
              if (responseModel.orderCreateTicket == 1) ...[
                Text(
                  AppLocalizations.text(
                      LangKey.do_you_want_to_create_a_ticket)!,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.style14BlackNormal,
                ),
                // CustomButton(
                //     text: AppLocalizations.text(LangKey.create_ticket),
                //     backgroundColor: AppColors.orange300,
                //     onTap: () async {
                //       await CustomNavigator.push(
                //           context!,
                //           TicketCreateScreen(
                //             model: model,
                //           ));
                //       CustomNavigator.pop(context!);
                //     }),
              ]
            ],
          ));
      CustomNavigator.pop(context!, object: true);
    }
  }

  orderUpdate(OrderStoreRequestModel model, bool isPayment) async {
    CustomNavigator.showProgressDialog(context);
    ResponseModel response = await repository.orderUpdate(context, model);
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      if (isPayment) {
        final responseModel = CreateOrderResponseModel.fromJson(response.data!);
        await CustomNavigator.push(
            context!,
            OrderPaymentNewScreen(
              orderModel: responseModel.orderInfo,
            ));
      } else {
        await CustomNavigator.showCustomAlertDialog(
            context!,
            AppLocalizations.text(LangKey.notification),
            response.errorDescription);
      }
      CustomNavigator.pop(context!, object: true);
    }
  }

  orderVAT() async {
    if ((vatModels?.isNotEmpty ?? false)) {
      return;
    }
    ResponseModel response = await repository.orderVAT(context);
    if (response.success!) {
      var responseModel = VATResponseModel.fromJson(response.datas);

      vatModels = responseModel.data
              ?.map((e) => CustomDropdownModel(
                  id: e.vatId, text: e.description, data: e.vat))
              .toList() ??
          [];
    } else {
      vatModels = [];
    }

    setVATModels(vatModels);
  }

  otherFreeBranch() async {
    if (surchargeModels.isNotEmpty && surchargeInit) {
      _pushSurcharge();
      return;
    }
    CustomNavigator.showProgressDialog(context);
    ResponseModel response = await repository.otherFreeBranch(context,
        OtherFreeBranchRequestModel(branchId: Globals.model?.branchId));
    CustomNavigator.hideProgressDialog();
    if (response.success!) {
      final responseModel =
          OtherFreeBranchResponseModel.fromJson(response.datas);

      for (var e in responseModel.data ?? <OtherFreeBranchModel>[]) {
        final event = surchargeModels
            .firstWhereOrNull((element) => element.otherFeeId == e.otherFeeId);
        if (event == null) {
          surchargeModels.add(e);
        }
      }

      if (surchargeModels.isEmpty) {
        CustomNavigator.showCustomAlertDialog(
            context!,
            AppLocalizations.text(LangKey.notification),
            AppLocalizations.text(LangKey.data_empty));
      } else {
        _pushSurcharge();
        surchargeInit = true;
      }
    } else {
      if (surchargeModels.isNotEmpty) {
        _pushSurcharge();
      }
    }
  }

  _pushSurcharge() async {
    await CustomNavigator.push(
        context!,
        BookingSurchargeScreen(
          models: surchargeModels,
        ));
    setSurchargeModels(surchargeModels);
  }
}
