
import 'package:epoint_deal_plugin/model/response/product_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_response_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class GlobalCart {
  static final GlobalCart _singleton = GlobalCart._internal();
  factory GlobalCart() => _singleton;
  GlobalCart._internal();
  static GlobalCart get shared => _singleton;

  GlobalCartBloc bloc;

  List<ProductModel> products = <ProductModel>[];
  List<ServiceModel> services = <ServiceModel>[];

  init() {
    bloc = GlobalCartBloc();
    products.clear();
    services.clear();
  }

  dispose() {
    bloc.dispose();
    products.clear();
    services.clear();
  }

  clearCart() {
    products.clear();
    services.clear();
    bloc.getValue();
  }

  addProduct(ProductModel value, double price, double qty, String note) {
    final model = ProductModel.fromJson(value.toJson());
    model.price = price;
    model.qty = qty;
    model.note = note;
    products.add(model);
    bloc.getValue();
  }

  updateProductQuantity(ProductModel value, double qty){
    value.qty = qty;
    bloc.getValue();
  }

  removeProduct(ProductModel value){
    products.remove(value);
    bloc.getValue();
  }

  addService(ServiceModel value, double price, double qty, String note) {
    final model = ServiceModel.fromJson(value.toJson());
    model.price = price;
    model.qty = qty;
    model.note = note;
    services.add(model);
    bloc.getValue();
  }

  updateServiceQuantity(ServiceModel value, double qty){
    value.qty = qty;
    bloc.getValue();
  }

  removeService(ServiceModel value){
    services.remove(value);
    bloc.getValue();
  }

  addBooking(ServiceModel value){
    value.qty = 1;
    services.add(value);
    bloc.getValue();
  }

  removeBooking(ServiceModel value){
    try{
      services.removeWhere((element) => element.serviceId == value.serviceId);
    }
    catch(_){}
    bloc.getValue();
  }

  double getValue() {
    double value = 0;
    products.forEach((e) {
      if (e.qty != null && e.price != null) {
        value += e.qty * e.price;
      }
    });
    services.forEach((e) {
      if (e.qty != null && e.price != null) {
        value += e.qty * e.price;
      }
    });
    return value;
  }
}

class GlobalCartBloc extends BaseBloc {
  final _streamValue = BehaviorSubject<double>();
  ValueStream<double> get outputValue => _streamValue.stream;
  setValue(double event) => set(_streamValue, event);
  @override
  void dispose() {
    // TODO: implement dispose
    _streamValue.close();
    super.dispose();
  }

  getValue() {
    double value = 0;
    GlobalCart.shared.products.forEach((e) {
      if (e.qty != null && e.price != null) {
        value += e.qty * e.price;
      }
    });
    GlobalCart.shared.services.forEach((e) {
      if (e.qty != null && e.price != null) {
        value += e.qty * e.price;
      }
    });
    setValue(value);
  }

  double getQty() {
    double qty = 0;
    GlobalCart.shared.products.forEach((e) {
      if (e.qty != null) {
        qty += e.qty;
      }
    });
    GlobalCart.shared.services.forEach((e) {
      if (e.qty != null) {
        qty += e.qty;
      }
    });
    return qty;
  }
}