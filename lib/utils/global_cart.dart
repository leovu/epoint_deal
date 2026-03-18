import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:rxdart/rxdart.dart';

class GlobalCart {

  final products = <ProductNewModel>[];
  final services = <ServiceNewModel>[];
  final serviceCards = <OrderServiceCardModel>[];
  final serviceActivatedCards = <ServiceCardModel>[];
  late _GlobalCartBloc _bloc;

  GlobalCart() {
    _bloc = _GlobalCartBloc();
  }

  dispose() {
    _bloc.dispose();
    products.clear();
    services.clear();
    serviceCards.clear();
    serviceActivatedCards.clear();
  }

  ValueStream<double?> get outputValue => _bloc.outputValue;

  addProduct(ProductNewModel value) {
    ProductNewModel? model = products
        .firstWhereOrNull((element) => element.productId == value.productId);
    if (model == null) {
      products.add(value);
    } else {
      products.remove(model);
    }
    getValue();
  }

  addService(ServiceNewModel value) {
    ServiceNewModel? model = services
        .firstWhereOrNull((element) => element.serviceId == value.serviceId);
    if (model == null) {
      services.add(value);
    } else {
      services.remove(model);
    }
    getValue();
  }

  addServiceCard(OrderServiceCardModel value) {
    OrderServiceCardModel? model = serviceCards.firstWhereOrNull((element) =>
        element.serviceCardId == value.serviceCardId);
    if (model == null) {
      serviceCards.add(value);
    } else {
      serviceCards.remove(model);
    }
    getValue();
  }

  addServiceCardActivated(ServiceCardModel value) {
    ServiceCardModel? model = serviceActivatedCards.firstWhereOrNull(
        (element) =>
            element.customerServiceCardId == value.customerServiceCardId);
    if (model == null) {
      serviceActivatedCards.add(value);
    } else {
      serviceActivatedCards.remove(model);
    }
    getValue();
  }

  removeProduct(ProductNewModel value) {
    try {
      products.removeWhere((element) => element.productId == value.productId);
    } catch (_) {}
    getValue();
  }

  removeService(ServiceNewModel value) {
    try {
      services.removeWhere((element) => element.serviceId == value.serviceId);
    } catch (_) {}
    getValue();
  }

  removeServiceCard(OrderServiceCardModel value) {
    try {
      serviceCards.removeWhere((element) =>
          element.serviceCardId == value.serviceCardId);
    } catch (_) {}
    getValue();
  }

  removeServiceCardActivated(ServiceCardModel value) {
    try {
      serviceActivatedCards.removeWhere((element) =>
          element.customerServiceCardId == value.customerServiceCardId);
    } catch (_) {}
    getValue();
  }

  removeAllServiceCardActivated() {
    serviceActivatedCards.clear();
  }

  double getValue({bool isStream = true}) {
    double valueProduct = 0;
    for (var e in products) {
      valueProduct += getBookingAmount((e.changePrice ?? e.newPrice ?? 0.0),
          (e.discount ?? 0.0), (e.surcharge ?? 0.0), quantity: e.quantity ?? defaultCartQuantity);
    }

    double valueService = 0;
    for (var e in services) {
      valueService += getBookingAmount((e.changePrice ?? e.newPrice ?? 0.0),
          (e.discount ?? 0.0), (e.surcharge ?? 0.0), quantity: e.quantity ?? defaultCartQuantity);
    }

    double valueServiceCard = 0;
    for (var e in serviceCards) {
      valueServiceCard += getBookingAmount((e.changePrice ?? e.price ?? 0.0),
          (e.discount ?? 0.0), (e.surcharge ?? 0.0), quantity: e.quantity ?? defaultCartQuantity);
    }

    double value = valueProduct +
        valueService +
        valueServiceCard;
    if (isStream) {
      _bloc.setValue(value);
    }
    return value;
  }

  double getQuantity(){
    double valueProduct = 0;
    for (var e in products) {
      valueProduct += (e.quantity ?? defaultCartQuantity);
    }

    double valueService = 0;
    for (var e in services) {
      valueService += (e.quantity ?? defaultCartQuantity);
    }

    double valueServiceCard = 0;
    for (var e in serviceCards) {
      valueServiceCard += (e.quantity ?? defaultCartQuantity);
    }

    double valueServiceCardActivated = 0;
    for (var e in serviceActivatedCards) {
      valueServiceCardActivated += (e.quantity ?? defaultCartQuantity);
    }

    double value = valueProduct +
        valueService +
        valueServiceCard +
        valueServiceCardActivated;

    return value;
  }

  bool isEmpty(){
    return products.isEmpty && services.isEmpty && serviceCards.isEmpty && serviceActivatedCards.isEmpty;
  }
}

class _GlobalCartBloc extends BaseBloc {
  final _streamValue = BehaviorSubject<double?>();
  ValueStream<double?> get outputValue => _streamValue.stream;
  setValue(double event) => set(_streamValue, event);

  @override
  void dispose() {
    // TODO: implement dispose
    _streamValue.close();
    super.dispose();
  }
}
