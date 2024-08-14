import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/model/request/order_config_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_service_card_request_model.dart';
import 'package:epoint_deal_plugin/model/request/product_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_card_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_request_model.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_config_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/product_category_response_model.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_category_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response_model.dart';
import 'package:epoint_deal_plugin/presentation/category_module/src/ui/category_service_card_activated_screen.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/product_detail_new_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/service_detail_new_screen.dart';
import 'package:epoint_deal_plugin/utils/custom_debounce.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../ui/category_product_screen.dart';
import '../ui/category_service_card_screen.dart';
import '../ui/category_service_screen.dart';

class CategoryBloc extends BaseBloc {
  CategoryBloc(BuildContext context, bool isSelected) {
    setContext(context);

    this.isSelected = isSelected;
    _debounceProduct = CustomDebounce();
    _debounceService = CustomDebounce();
    _debounceServiceCard = CustomDebounce();
    _debounceServiceCardActivated = CustomDebounce();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamTabModels.close();
    _streamProductNewModel.close();
    _streamProductCategoryModels.close();
    _streamSearchProduct.close();
    _streamServiceNewModel.close();
    _streamSearchService.close();
    _streamServiceCategoryModels.close();
    _streamSearchServiceCard.close();
    _streamServiceCardModel.close();
    _streamSearchServiceCardActivated.close();
    _streamServiceCardActivatedModel.close();
    _debounceProduct.dispose();
    _debounceService.dispose();
    _debounceServiceCard.dispose();
    _debounceServiceCardActivated.dispose();
    super.dispose();
  }

  List<CustomModelTabBar>? tabs;
  TabController? tabController;
  CustomerModel? customerModel;
  late bool isBooking;

  final _streamTabModels = BehaviorSubject<List<CustomModelTabBar>?>();
  ValueStream<List<CustomModelTabBar>?> get outputTabModels =>
      _streamTabModels.stream;
  setTabModels(List<CustomModelTabBar>? event) => set(_streamTabModels, event);

  Future onRefresh({bool isRefresh = true}) {
    return orderConfig(
        OrderConfigRequestModel(
            brandCode: Global.brandCode),
        isRefresh);
  }

  orderConfig(OrderConfigRequestModel model, bool isRefresh) async {
    if (Globals.orderConfigModels != null) {
      if (tabs != null) {
        return;
      }
      setupTabs();
    } else {
      if (!isRefresh) {
        setTabModels(null);
      }
      ResponseModel response = await repository.orderConfig(context, model);
      if (response.success!) {
        final responseModel = OrderConfigResponseModel.fromJson(response.datas);

        Globals.orderConfigModels = responseModel.data ?? [];

        setupTabs();
      } else {
        if (!isRefresh) {
          setTabModels([]);
        }
      }
    }
  }

  setupTabs() {
    List<OrderConfigModel> models = Globals.orderConfigModels!
        .where((element) => element.type == objectTypeOrder)
        .toList();
    tabs = [];
    OrderConfigModel? productModel = models
        .firstWhereOrNull((element) => element.code == orderConfigCodeProduct);
    if (productModel != null && !isBooking) {
      tabs!.add(CustomModelTabBar(
          name: AppLocalizations.text(LangKey.product),
          child: CategoryProductScreen(this)));
    }
    OrderConfigModel? serviceModel = models
        .firstWhereOrNull((element) => element.code == orderConfigCodeService);
    if (serviceModel != null) {
      tabs!.add(CustomModelTabBar(
          name: AppLocalizations.text(LangKey.service),
          child: CategoryServiceScreen(this)));
    }
    OrderConfigModel? serviceCardModel = models.firstWhereOrNull(
        (element) => element.code == orderConfigCodeServiceCard);
    if (serviceCardModel != null) {
      tabs!.add(CustomModelTabBar(
          name: AppLocalizations.text(LangKey.service_card),
          child: CategoryServiceCardScreen(this)));
      if (customerModel?.customerId != null &&
          customerModel?.customerId != customerGuestId) {
        tabs!.add(CustomModelTabBar(
            name: AppLocalizations.text(LangKey.service_card_activated),
            child: CategoryServiceCardActivatedScreen(this)));
      }
    }
    setTabModels(tabs);
  }

  late bool isSelected;

  /// Tab Product
  List<ProductCategoryModel>? categoryProductModels;
  ProductCategoryModel? selectedCategoryProduct;

  ProductRequestModel? _requestProductNewModel;
  ProductNewResponseModel? _productNewModel;
  DateTime? _productFl;

  late CustomDebounce _debounceProduct;
  final FocusNode focusSearchProduct = FocusNode();
  final TextEditingController controllerSearchProduct = TextEditingController();

  final _streamSearchProduct = BehaviorSubject<String>();
  ValueStream<String> get outputSearchProduct => _streamSearchProduct.stream;
  setSearchProduct(String event) => set(_streamSearchProduct, event);

  final _streamProductNewModel = BehaviorSubject<ProductNewResponseModel?>();
  ValueStream<ProductNewResponseModel?> get outputProductNewModel =>
      _streamProductNewModel.stream;
  setProductNewModel(ProductNewResponseModel? event) =>
      set(_streamProductNewModel, event);

  final _streamProductCategoryModels =
      BehaviorSubject<List<ProductCategoryModel>?>();
  ValueStream<List<ProductCategoryModel>?> get outputProductCategoryModels =>
      _streamProductCategoryModels.stream;
  setProductCategoryModels(List<ProductCategoryModel>? event) =>
      set(_streamProductCategoryModels, event);

  Future onRefreshProduct({bool isRefresh = true}) {
    final group = <Future>[];
    group.add(getProduct(
        requestModel: ProductRequestModel(
            productName: controllerSearchProduct.text,
            productCategoryId: selectedCategoryProduct?.productCategoryId),
        isRefresh: isRefresh));
    group.add(productCategory(isRefresh));
    return Future.wait(group);
  }

  clearSearchProduct() {
    hideKeyboard();
    controllerSearchProduct.clear();
    listenerProduct();
  }

  listenerProduct() {
    _debounceProduct.onChange(() {
      onRefreshProduct(isRefresh: false);
    });
    setSearchProduct(controllerSearchProduct.text);
  }

  onSelectedProduct(ProductNewModel model) {
    if (isSelected) {
      Globals.cart!.addProduct(model);
      setProductNewModel(_productNewModel);
    } else {
      CustomNavigator.push(context!, ProductDetailNewScreen(model));
    }
  }

  onSelectedCategoryProduct(ProductCategoryModel? model) {
    selectedCategoryProduct = model;
    setProductCategoryModels(categoryProductModels);
    getProduct(
        requestModel: ProductRequestModel(
            productCategoryId: selectedCategoryProduct?.productCategoryId,
            productName: controllerSearchProduct.text),
        isRefresh: false);
  }

  getProduct(
      {ProductRequestModel? requestModel,
      bool isRefresh = true,
      bool isLoadmore = false}) async {
    if (isLoadmore && !(_productNewModel?.pageInfo?.enableLoadmore ?? false)) {
      return;
    }
    DateTime now = DateTime.now();
    _productFl = now;
    if (!isRefresh) {
      setProductNewModel(null);
    }

    ProductRequestModel model;
    model = requestModel ??
        (_requestProductNewModel == null
            ? ProductRequestModel()
            : ProductRequestModel.fromJson(_requestProductNewModel!.toJson()));
    if (isLoadmore) {
      model.page = model.page! + 1;
    } else {
      model.page = 1;
    }
    ResponseModel response = await repository.getProduct(context, model);
    if (response.success!) {
      var modelResponse = ProductNewResponseModel.fromJson(response.data!);

      if (Globals.cart != null) {
        for (var e in modelResponse.items!) {
          final event = Globals.cart!.products.firstWhereOrNull(
              (element) => element.productCode == e!.productCode);
          if (event != null) {
            e!.newPrice = event.newPrice;
          }
        }
      }

      _requestProductNewModel = model;
      if (isLoadmore) {
        if (_productNewModel!.pageInfo?.currentPage !=
            modelResponse.pageInfo?.currentPage) {
          if (_productNewModel!.items == null) {
            _productNewModel!.items = [];
          }
          _productNewModel!.items!.addAll(modelResponse.items ?? []);
        }
        _productNewModel!.pageInfo = modelResponse.pageInfo;
      } else {
        _productNewModel = modelResponse;
      }

      if (_productFl == now) {
        setProductNewModel(_productNewModel);
      }
    } else {
      if (!isLoadmore && !isRefresh && _productFl == now) {
        _productNewModel = ProductNewResponseModel(items: []);
        setProductNewModel(_productNewModel);
      }
    }
  }

  productCategory(bool isRefresh) async {
    if (isRefresh) setProductCategoryModels(null);
    ResponseModel response = await repository.productCategory(context);
    if (response.success!) {
      final responseModel =
          ProductCategoryResponseModel.fromJson(response.datas);
      categoryProductModels = responseModel.data ?? [];
      setProductCategoryModels(categoryProductModels);
    } else {
      if (isRefresh) {
        categoryProductModels = [];
        setProductCategoryModels(categoryProductModels);
      }
    }
  }

  /// Tab Service
  List<ServiceCategoryModel>? categoryServiceModels;
  ServiceCategoryModel? selectedCategoryService;

  ServiceRequestModel? _requestServiceNewModel;
  ServiceNewResponseModel? _serviceNewModel;
  DateTime? _serviceFl;

  late CustomDebounce _debounceService;
  final FocusNode focusSearchService = FocusNode();
  final TextEditingController controllerSearchService = TextEditingController();

  final _streamSearchService = BehaviorSubject<String>();
  ValueStream<String> get outputSearchService => _streamSearchService.stream;
  setSearchService(String event) => set(_streamSearchService, event);

  final _streamServiceNewModel = BehaviorSubject<ServiceNewResponseModel?>();
  ValueStream<ServiceNewResponseModel?> get outputServiceNewModel =>
      _streamServiceNewModel.stream;
  setServiceNewModel(ServiceNewResponseModel? event) =>
      set(_streamServiceNewModel, event);

  final _streamServiceCategoryModels =
      BehaviorSubject<List<ServiceCategoryModel>?>();
  ValueStream<List<ServiceCategoryModel>?> get outputServiceCategoryModels =>
      _streamServiceCategoryModels.stream;
  setServiceCategoryModels(List<ServiceCategoryModel>? event) =>
      set(_streamServiceCategoryModels, event);

  Future onRefreshService({bool isRefresh = true}) {
    final group = <Future>[];
    group.add(getService(
        requestModel: ServiceRequestModel(
            serviceCategoryId: selectedCategoryService?.serviceCategoryId,
            serviceName: controllerSearchService.text),
        isRefresh: isRefresh));
    group.add(serviceCategory(isRefresh));
    return Future.wait(group);
  }

  clearSearchService() {
    hideKeyboard();
    controllerSearchService.clear();
    listenerService();
  }

  listenerService() {
    _debounceService.onChange(() {
      onSelectedCategoryService(null);
    });
    setSearchService(controllerSearchService.text);
  }

  onSelectedService(ServiceNewModel model) {
    if (isSelected) {
      Globals.cart!.addService(model);
      setServiceNewModel(_serviceNewModel);
    } else {
      CustomNavigator.push(context!, ServiceDetailNewScreen(model));
    }
  }

  onSelectedCategoryService(ServiceCategoryModel? model) {
    selectedCategoryService = model;
    setServiceCategoryModels(categoryServiceModels);
    getService(
        requestModel: ServiceRequestModel(
            serviceCategoryId: selectedCategoryService?.serviceCategoryId,
            serviceName: controllerSearchService.text),
        isRefresh: false);
  }

  getService(
      {ServiceRequestModel? requestModel,
      bool isRefresh = true,
      bool isLoadmore = false}) async {
    if (isLoadmore && !(_serviceNewModel?.pageInfo?.enableLoadmore ?? false)) {
      return;
    }
    DateTime now = DateTime.now();
    _serviceFl = now;
    if (!isRefresh) {
      setServiceNewModel(null);
    }

    ServiceRequestModel model;
    model = requestModel ??
        (_requestServiceNewModel == null
            ? ServiceRequestModel()
            : ServiceRequestModel.fromJson(_requestServiceNewModel!.toJson()));
    if (isLoadmore) {
      model.page = model.page! + 1;
    } else {
      model.page = 1;
    }
    ResponseModel response = await repository.getService(context, model);
    if (response.success!) {
      var modelResponse = ServiceNewResponseModel.fromJson(response.data!);

      if (Globals.cart != null) {
        for (var e in modelResponse.items!) {
          final event = Globals.cart!.services.firstWhereOrNull(
              (element) => element.serviceCode == e!.serviceCode);
          if (event != null) {
            e!.newPrice = event.newPrice;
          }
        }
      }

      _requestServiceNewModel = model;
      if (isLoadmore) {
        if (_serviceNewModel!.pageInfo?.currentPage !=
            modelResponse.pageInfo?.currentPage) {
          if (_serviceNewModel!.items == null) {
            _serviceNewModel!.items = [];
          }
          _serviceNewModel!.items!.addAll(modelResponse.items ?? []);
        }
        _serviceNewModel!.pageInfo = modelResponse.pageInfo;
      } else {
        _serviceNewModel = modelResponse;
      }

      if (_serviceFl == now) {
        setServiceNewModel(_serviceNewModel);
      }
    } else {
      if (!isLoadmore && !isRefresh && _serviceFl == now) {
        _serviceNewModel = ServiceNewResponseModel(items: []);
        setServiceNewModel(_serviceNewModel);
      }
    }
  }

  serviceCategory(bool isRefresh) async {
    if (isRefresh) setServiceCategoryModels(null);
    ResponseModel response = await repository.serviceCategory(context);
    if (response.success!) {
      final responseModel =
          ServiceCategoryResponseModel.fromJson(response.datas);
      categoryServiceModels = responseModel.data ?? [];
      setServiceCategoryModels(categoryServiceModels);
    } else {
      if (isRefresh) {
        categoryServiceModels = [];
        setServiceCategoryModels(categoryServiceModels);
      }
    }
  }

  /// Tab ServiceCard
  OrderServiceCardRequestModel? _requestServiceCardModel;
  OrderServiceCardResponseModel? _serviceCardModel;
  DateTime? _serviceCardFl;

  late CustomDebounce _debounceServiceCard;
  final FocusNode focusSearchServiceCard = FocusNode();
  final TextEditingController controllerSearchServiceCard =
      TextEditingController();

  final _streamSearchServiceCard = BehaviorSubject<String>();
  ValueStream<String> get outputSearchServiceCard =>
      _streamSearchServiceCard.stream;
  setSearchServiceCard(String event) => set(_streamSearchServiceCard, event);

  final _streamServiceCardModel =
      BehaviorSubject<OrderServiceCardResponseModel?>();
  ValueStream<OrderServiceCardResponseModel?> get outputServiceCardModel =>
      _streamServiceCardModel.stream;
  setServiceCardModel(OrderServiceCardResponseModel? event) =>
      set(_streamServiceCardModel, event);

  Future onRefreshServiceCard({bool isRefresh = true}) {
    return orderServiceCard(
        requestModel: OrderServiceCardRequestModel(
            search: controllerSearchServiceCard.text),
        isRefresh: isRefresh);
  }

  clearSearchServiceCard() {
    hideKeyboard();
    controllerSearchServiceCard.clear();
    listenerServiceCard();
  }

  listenerServiceCard() {
    _debounceServiceCard.onChange(() {
      onRefreshServiceCard(isRefresh: false);
    });
    setSearchServiceCard(controllerSearchServiceCard.text);
  }

  onSelectedServiceCard(OrderServiceCardModel model) {
    if (isSelected) {
      Globals.cart!.addServiceCard(model);
      setServiceCardModel(_serviceCardModel);
    } else {}
  }

  orderServiceCard(
      {OrderServiceCardRequestModel? requestModel,
      bool isRefresh = true,
      bool isLoadmore = false}) async {
    if (isLoadmore && !(_serviceCardModel?.pageInfo?.enableLoadmore ?? false)) {
      return;
    }
    DateTime now = DateTime.now();
    _serviceCardFl = now;
    if (!isRefresh) {
      setServiceCardModel(null);
    }

    OrderServiceCardRequestModel model;
    model = requestModel ??
        (_requestServiceCardModel == null
            ? OrderServiceCardRequestModel()
            : OrderServiceCardRequestModel.fromJson(
                _requestServiceCardModel!.toJson()));
    if (isLoadmore) {
      model.page = model.page! + 1;
    } else {
      model.page = 1;
    }
    ResponseModel response = await repository.orderServiceCard(context, model);
    if (response.success!) {
      var modelResponse =
          OrderServiceCardResponseModel.fromJson(response.data!);

      if (Globals.cart != null) {
        for (var e in modelResponse.items!) {
          final event = Globals.cart!.serviceCards
              .firstWhereOrNull((element) => element.code == e.code);
          if (event != null) {
            e.price = event.price;
          }
        }
      }

      _requestServiceCardModel = model;
      if (isLoadmore) {
        if (_serviceCardModel!.pageInfo?.currentPage !=
            modelResponse.pageInfo?.currentPage) {
          if (_serviceCardModel!.items == null) {
            _serviceCardModel!.items = [];
          }
          _serviceCardModel!.items!.addAll(modelResponse.items ?? []);
        }
        _serviceCardModel!.pageInfo = modelResponse.pageInfo;
      } else {
        _serviceCardModel = modelResponse;
      }

      if (_serviceCardFl == now) {
        setServiceCardModel(_serviceCardModel);
      }
    } else {
      if (!isLoadmore && !isRefresh && _serviceCardFl == now) {
        _serviceCardModel = OrderServiceCardResponseModel(items: []);
        setServiceCardModel(_serviceCardModel);
      }
    }
  }

  /// Tab ServiceCardActivated
  ServiceCardRequestModel? _requestServiceCardActivatedModel;
  ServiceCardResponseModel? _serviceCardActivatedModel;
  DateTime? _serviceCardActivatedFl;

  late CustomDebounce _debounceServiceCardActivated;
  final FocusNode focusSearchServiceCardActivated = FocusNode();
  final TextEditingController controllerSearchServiceCardActivated =
      TextEditingController();

  final _streamSearchServiceCardActivated = BehaviorSubject<String>();
  ValueStream<String> get outputSearchServiceCardActivated =>
      _streamSearchServiceCardActivated.stream;
  setSearchServiceCardActivated(String event) =>
      set(_streamSearchServiceCardActivated, event);

  final _streamServiceCardActivatedModel =
      BehaviorSubject<ServiceCardResponseModel?>();
  ValueStream<ServiceCardResponseModel?> get outputServiceCardActivatedModel =>
      _streamServiceCardActivatedModel.stream;
  setServiceCardActivatedModel(ServiceCardResponseModel? event) =>
      set(_streamServiceCardActivatedModel, event);

  Future onRefreshServiceCardActivated({bool isRefresh = true}) {
    return orderServiceCardUsing(
        requestModel: ServiceCardRequestModel(
            search: controllerSearchServiceCardActivated.text,
            customerId: customerModel?.customerId),
        isRefresh: isRefresh);
  }

  clearSearchServiceCardActivated() {
    hideKeyboard();
    controllerSearchServiceCardActivated.clear();
    listenerServiceCardActivated();
  }

  listenerServiceCardActivated() {
    _debounceServiceCardActivated.onChange(() {
      onRefreshServiceCardActivated(isRefresh: false);
    });
    setSearchServiceCardActivated(controllerSearchServiceCardActivated.text);
  }

  onSelectedServiceCardActivated(ServiceCardModel model) {
    if (isSelected) {
      Globals.cart!.addServiceCardActivated(model);
      setServiceCardActivatedModel(_serviceCardActivatedModel);
    } else {}
  }

  orderServiceCardUsing(
      {ServiceCardRequestModel? requestModel,
      bool isRefresh = true,
      bool isLoadmore = false}) async {
    if (isLoadmore &&
        !(_serviceCardActivatedModel?.pageInfo?.enableLoadmore ?? false)) {
      return;
    }
    DateTime now = DateTime.now();
    _serviceCardActivatedFl = now;
    if (!isRefresh) {
      setServiceCardActivatedModel(null);
    }

    ServiceCardRequestModel model;
    model = requestModel ??
        (_requestServiceCardActivatedModel == null
            ? ServiceCardRequestModel()
            : ServiceCardRequestModel.fromJson(
                _requestServiceCardActivatedModel!.toJson()));
    if (isLoadmore) {
      model.page = model.page! + 1;
    } else {
      model.page = 1;
    }
    ResponseModel response =
        await repository.orderServiceCardUsing(context, model);
    if (response.success!) {
      var modelResponse = ServiceCardResponseModel.fromJson(response.data!);

      if (Globals.cart != null) {
        for (var e in modelResponse.items!) {
          final event = Globals.cart!.serviceActivatedCards
              .firstWhereOrNull((element) => element.cardCode == e!.cardCode);
          if (event != null) {
            e!.price = event.price;
          }
        }
      }

      _requestServiceCardActivatedModel = model;
      if (isLoadmore) {
        if (_serviceCardActivatedModel!.pageInfo?.currentPage !=
            modelResponse.pageInfo?.currentPage) {
          if (_serviceCardActivatedModel!.items == null) {
            _serviceCardActivatedModel!.items = [];
          }
          _serviceCardActivatedModel!.items!.addAll(modelResponse.items ?? []);
        }
        _serviceCardActivatedModel!.pageInfo = modelResponse.pageInfo;
      } else {
        _serviceCardActivatedModel = modelResponse;
      }

      if (_serviceCardActivatedFl == now) {
        setServiceCardActivatedModel(_serviceCardActivatedModel);
      }
    } else {
      if (!isLoadmore && !isRefresh && _serviceCardActivatedFl == now) {
        _serviceCardActivatedModel = ServiceCardResponseModel(items: []);
        setServiceCardActivatedModel(_serviceCardActivatedModel);
      }
    }
  }
}
