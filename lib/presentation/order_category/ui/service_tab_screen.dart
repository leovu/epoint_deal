import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/request/service_request_model.dart';
import 'package:epoint_deal_plugin/model/response/service_response_model.dart';
import 'package:epoint_deal_plugin/presentation/list_deal/list_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_category/bloc/order_item_bloc.dart';
import 'package:epoint_deal_plugin/presentation/order_category/ui/order_category_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_category/ui/service_detail_screen.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/widget/custom_avatar_with_url.dart';
import 'package:epoint_deal_plugin/widget/custom_checkbox.dart';
import 'package:epoint_deal_plugin/widget/custom_container_loadmore.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class ServiceTabScreen extends StatefulWidget {
  final OrderCategoryScreenController search;
  final TextEditingController controller;
  final bool isViewOnly;
  final bool isBooking;
  final bool isSelected;
  ServiceTabScreen(this.search, this.controller, {
    this.isViewOnly = false,
    this.isBooking = false,
    this.isSelected = false
  });
  @override
  _ServiceTabScreenState createState() => _ServiceTabScreenState(search);
}

class _ServiceTabScreenState extends State<ServiceTabScreen>
    implements OrderItemBase {
  OrderItemBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = OrderItemBloc(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getService();
    });
  }

  _ServiceTabScreenState(OrderCategoryScreenController _controller) {
    _controller.search = search;
  }
  void search(String value) {
    ServiceRequestModel _request = _requestModel;
    _request.serviceName = value;
    _request.page = 1;
    getService(request: _request, isSearch: true);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: null,
        stream: _bloc.outputService,
        builder: (_, snapshot) {
          if (snapshot.hasData) {
            ServiceResponseModel _data = snapshot.data;
            return CustomScaffold(
              actions: _listKeyboardAction(_data.items),
              body: NotificationListener(
                onNotification: _onScrollNotification,
                child: ListView(
                  children: _getProducts(_data.items),
                ),
              ),
            );
          } else {
            return Container();
          }
        });
  }

  bool _onScrollNotification(ScrollNotification scrollNotification) {
    if(scrollNotification.metrics.pixels >= (scrollNotification.metrics.maxScrollExtent / 2)){
      getService();
    }
    return false;
  }

  List<KeyboardActionsItem> _listKeyboardAction(List<ServiceModel> item) {
    if (item == null) return null;
    List<KeyboardActionsItem> models = [];
    for(var e in item){
      if(e != null){
        models.add(buildKeyboardAction(e.node));
      }
    }
    return models;
  }

  KeyboardActionsItem buildKeyboardAction(FocusNode node,
      {String text = "Done", Function onTap}) {
    return KeyboardActionsItem(focusNode: node, toolbarButtons: [
      (node) => InkWell(
            onTap: onTap ?? () => node.unfocus(),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                text,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
    ]);
  }

  List<Widget> _getProducts(List<ServiceModel> value) {
    List<Widget> _arr = [];
    if (value == null) return _arr;
    value.forEach((element) {
      if(element == null){
        _arr.add(CustomContainerLoadmore());
      }
      else{
        _arr.add(_productView(element));
        _arr.add(Container(
          height: 2.0,
          color: HexColor('EEEEEE'),
        ));
      }
    });
    return _arr;
  }

  Widget _productView(ServiceModel value) {
    return InkWell(
      onTap: () async {
        if(widget.isSelected){
         Navigator.of(context).pop(value);
        }
        else{
          await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => ServiceDetailScreen(value, widget.isViewOnly)));
          setState(() {});
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomNetworkImage(
                url: value.serviceAvatar,
                width: AppSizes.maxWidth * 0.1,
                height: AppSizes.maxWidth * 0.1,
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                const EdgeInsets.only(top: 2.0, bottom: 2.0, right: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      value.serviceName,
                      textScaleFactor: 1.05,
                      maxLines: 3,
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: 120,
                            child: AutoSizeText(
                              value.newPrice.getMoneyFormat(),
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey),
                              textScaleFactor: 1.085,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        if(!widget.isViewOnly && !widget.isSelected)
                          widget.isBooking
                              ? _buildCheckBox(value)
                              : Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    int qty = (int.tryParse(
                                        value.controller.text) -
                                        1) <=
                                        0
                                        ? 0
                                        : int.tryParse(value.controller.text) -
                                        1;
                                    value.controller.text = '$qty';
                                    GlobalCart.shared.addService(value, qty);
                                  },
                                  child: Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    child: Center(
                                      child: Text('-',
                                          style: TextStyle(
                                              color: AppColors.primaryColor,
                                              fontSize: 20.0,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey)),
                                width: 60.0,
                                height: 25.0,
                                child: _inputField(value),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: InkWell(
                                  onTap: () {
                                    int qty = (int.tryParse(
                                        value.controller.text) +
                                        1) >
                                        999
                                        ? 999
                                        : int.tryParse(value.controller.text) +
                                        1;
                                    value.controller.text = '$qty';
                                    GlobalCart.shared.addService(value, qty);
                                  },
                                  child: Container(
                                    height: 20.0,
                                    width: 20.0,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(10.0)),
                                    child: Icon(
                                      Icons.add,
                                      size: 20.0,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckBox(ServiceModel model){
    return CustomCheckbox(
        model.qty > 0,
        (event){
          if(event){
            GlobalCart.shared.addService(model, 1);
            model.qty = 1;
          }
          else{
            GlobalCart.shared.addService(model, 0);
            model.qty = 0;
          }

          setState(() {});
        }
    );
  }

  Widget _inputField(ServiceModel value) {
    return Center(
      child: AutoSizeTextField(
        keyboardType: TextInputType.number,
        focusNode: value.node,
        controller: value.controller,
        maxLength: 3,
        onChanged: (text) {
          try {
            if (text[0] == '0' && text.length > 1) {
              String val = text.substring(1, text.length);
              value.controller.text = '$val';
              GlobalCart.shared.addService(value, int.tryParse(val));
              value.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.controller.text.length));
            } else {
              if (text == '' || text == null) {
                GlobalCart.shared.addService(value, 0);
              } else {
                GlobalCart.shared.addService(value, int.tryParse(text));
                value.controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: value.controller.text.length));
              }
            }
          } catch (e) {
            if (text == '' || text == null) {
              value.controller.text = '0';
              GlobalCart.shared.addService(value, 0);
              value.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.controller.text.length));
            }
          }
        },
        buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  @override
  getProduct() {
    // TODO: implement getProduct
  }

  ServiceRequestModel _requestModel;
  @override
  getService({ServiceRequestModel request, bool isSearch = false}) {
    // TODO: implement getService
    if (_requestModel == null && request == null) {
      _requestModel = ServiceRequestModel();
      _requestModel.serviceName = widget.controller.text ?? '';
      _requestModel.brandCode =
          Global.branch_code;
      _requestModel.page = 1;
      _bloc.getService(_requestModel);
    } else {
      if (request != null) {
        _requestModel = request;
        _bloc.getService(_requestModel, isSearch: isSearch);
      } else {
        _bloc.getService(_requestModel, isLoadMore: true);
      }
    }
  }
}
