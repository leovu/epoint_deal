import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/request/service_request_model.dart';
import 'package:epoint_deal_plugin/model/response/service_response_model.dart';
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
                  padding: EdgeInsets.symmetric(horizontal: 5.0),
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
        // _arr.add(Container(
        //   height: 2.0,
        //   color: HexColor('EEEEEE'),
        // ));
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
        decoration: BoxDecoration(
          color: Colors.white,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        )
                      ]),
        margin: EdgeInsets.symmetric(vertical: 4.0),
        padding: EdgeInsets.symmetric(vertical: 8.0),
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

  // Widget _buildCheckBox(ServiceModel model){
  //   return CustomCheckbox(
  //       model.qty > 0,
  //       (event){
  //         if(event){
  //           GlobalCart.shared.addService(model, 1);
  //           model.qty = 1;
  //         }
  //         else{
  //           GlobalCart.shared.addService(model, 0);
  //           model.qty = 0;
  //         }

  //         setState(() {});
  //       }
  //   );
  // }


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
