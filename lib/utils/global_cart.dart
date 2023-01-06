
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

  addProduct(ProductModel value, int qty) {
    List<int> tmp = [];
    bool isContains = false;
    products.forEach((e) {
      if (e.productId == value.productId) {
        if (qty == 0) {
          tmp.add(products.indexOf(e));
        } else {
          e.qty = qty;
          e.controller.text = '$qty';
          value.qty = qty;
          value.controller.text = '$qty';
        }
        isContains = true;
      }
    });
    tmp.forEach((e) {
      products.removeAt(e);
    });
    if (qty > 0 && !isContains) {
      value.qty = qty;
      value.controller.text = '$qty';
      products.add(value);
    }
    bloc.getValue();
  }

  addService(ServiceModel value, int qty) {
    List<int> tmp = [];
    bool isContains = false;
    services.forEach((e) {
      if (e.serviceId == value.serviceId) {
        if (qty == 0) {
          tmp.add(services.indexOf(e));
        } else {
          e.qty = qty;
          e.controller.text = '$qty';
          value.qty = qty;
          value.controller.text = '$qty';
        }
        isContains = true;
      }
    });
    tmp.forEach((e) {
      services.removeAt(e);
    });
    if (qty > 0 && !isContains) {
      value.qty = qty;
      value.controller.text = '$qty';
      services.add(value);
    }
    bloc.getValue();
  }

  int getQuantityProduct(int value) {
    int qty = 0;
    products.forEach((e) {
      if (e.productId == value) {
        qty = e.qty;
      }
    });
    return qty;
  }

  int getQuantityService(int value) {
    int qty = 0;
    services.forEach((e) {
      if (e.serviceId == value) {
        qty = e.qty;
      }
    });
    return qty;
  }

  double getValue() {
    double value = 0;
    products.forEach((e) {
      if (e.qty != null && e.newPrice != null) {
        value += e.qty * e.newPrice;
      }
    });
    services.forEach((e) {
      if (e.qty != null && e.newPrice != null) {
        value += e.qty * e.newPrice;
      }
    });
    return value;
  }

  int getCartQty() {
    int value = 0;
    products.forEach((e) {
      value += e.qty;
    });
    services.forEach((e) {
      value += e.qty;
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
      if (e.qty != null && e.newPrice != null) {
        value += e.qty * e.newPrice;
      }
    });
    GlobalCart.shared.services.forEach((e) {
      if (e.qty != null && e.newPrice != null) {
        value += e.qty * e.newPrice;
      }
    });
    setValue(value);
  }

  int getQty() {
    int qty = 0;
    GlobalCart.shared.products.forEach((e) {
      if (e.qty != null && e.newPrice != null) {
        qty += e.qty;
      }
    });
    GlobalCart.shared.services.forEach((e) {
      if (e.qty != null && e.newPrice != null) {
        qty += e.qty;
      }
    });
    return qty;
  }
}
