import 'package:auto_size_text/auto_size_text.dart';
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/update_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/product_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_response_model.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/more_info_creat_deal.dart';
import 'package:epoint_deal_plugin/presentation/discount_screen/discount_screen.dart';
import 'package:epoint_deal_plugin/presentation/modal/order_source_modal.dart';
import 'package:epoint_deal_plugin/presentation/order_category/ui/order_category_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_category/ui/product_detail_screen.dart';
import 'package:epoint_deal_plugin/presentation/order_category/ui/service_detail_screen.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_size_transaction.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield_lead.dart';
import 'package:epoint_deal_plugin/widget/maximum_number_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class MoreInfoEditDeal extends StatefulWidget {
  String tagsString;
  List<TagData> tagsData;
  DetailDealData detail;
  List<BranchData> branchData;
  OrderSourceData orderSourceSelected;
  UpdateDealModelRequest detailDeal;
  MoreInfoEditDeal(
      {Key key,
      this.branchData,
      this.orderSourceSelected,
      this.detail,
      this.tagsData,
      this.tagsString,
      this.detailDeal});

  @override
  _MoreInfoEditDealState createState() => _MoreInfoEditDealState();
}

class _MoreInfoEditDealState extends State<MoreInfoEditDeal> {
  ScrollController _controller = ScrollController();
  bool showAdditionDeal = false;

  TextEditingController _probabilityText = TextEditingController();
  FocusNode _probabilityFocusNode = FocusNode();

  TextEditingController _detailDealText = TextEditingController();
  FocusNode _detailDealFocusNode = FocusNode();

    final TextEditingController _controllerDiscount = TextEditingController();
  final FocusNode _focusDiscount = FocusNode();

  List<OrderSourceData> orderSourceData;
  OrderSourceData orderSourceSelected;

  // List<TagData> tagsData;
  List<TagData> tagsSelected;
  String tagsString = "";
  List<Map<String, dynamic>> productSelected = [];
  double _discount;
  double transportCharge;
  int _discountTypeDirect = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _probabilityText.text = "${widget.detail?.probability ?? 0}";

      _detailDealText.text = widget.detail?.dealDescription ?? "";

      if (widget.detail.productBuy.length > 0) {
        for (int i = 0; i < widget.detail.productBuy.length; i++) {
          widget.detailDeal.product.add(Product(
              objectType: widget.detail.productBuy[i].objectType ?? "",
              objectName: widget.detail.productBuy[i].objectName ?? "",
              objectCode: "",
              objectId: widget.detail.productBuy[i].objectId ?? 0,
              quantity: widget.detail.productBuy[i].quantity ?? 0,
              price: widget.detail.productBuy[i].price ?? 0,
              amount: (widget.detail.productBuy[i].quantity ?? 0) *
                  (widget.detail.productBuy[i].price ?? 0)));
          productSelected.add(widget.detail.productBuy[i].toJson());
        }
      } else {
        productSelected = [];
      }


      if (productSelected.length > 0) {
      productSelected.forEach((v) {
        if (v['object_type'] == 'product') {
          ProductModel item = ProductModel.fromJsonOrderDetail(v);
          GlobalCart.shared.addProduct(item, item.price.toDouble(), item.qty.toDouble(), item.note);
        } else {
          ServiceModel item = ServiceModel.fromJsonOrderDetail(v);
          GlobalCart.shared.addService(item, item.price.toDouble(), item.qty, item.note);
        }
      });
    }

    _discount = (widget.detail.discount ?? 0.0).toDouble();
    Global.discount = _discount;
    _controllerDiscount.text = _discount.toString();

      setState(() {});
    });
  }

  _addMoreProduct() async {
    GlobalCart.shared.clearCart();
    if (widget.detailDeal.product.length > 0) {
      widget.detailDeal.product.forEach((v) {
        if (v.objectType == 'product') {
          ProductModel item = ProductModel.fromJsonOrderDetail(v.toJson());
          GlobalCart.shared.addProduct(item, item.price.toDouble(), item.qty, item.note);
        } else {
          ServiceModel item = ServiceModel.fromJsonOrderDetail(v.toJson());
          GlobalCart.shared.addService(item, item.price.toDouble(), item.qty, item.note);
        }
      });
    }

    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => OrderCategoryScreen()));
    // GlobalCart.shared.clearCart();
    print(result);

    if (result != null) {
      widget.detailDeal.product.clear();
      if (result.length > 0) {
        productSelected.clear();
        for (int i = 0; i < result.length; i++) {
          widget.detailDeal.product.add(Product(
              objectType: result[i]["object_type"] ?? "",
              objectName: result[i]["object_name"] ?? "",
              objectCode: result[i]["objectCode"] ?? "",
              objectId: result[i]["object_id"] ?? 0,
              quantity: result[i]["quantity"] ?? 0,
              price: result[i]["price"] ?? 0,
              amount: (result[i]["quantity"] ?? 0) * (result[i]["price"] ?? 0)));

          productSelected.add(widget.detailDeal.product[i].toJson());
        }
        ;
      }
    }
     _setDiscount();
    setState(() {});
  }

  _addProduct() async {
    final result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => OrderCategoryScreen()));
    GlobalCart.shared.clearCart();

    if (result != null) {
      if (result.length > 0) {
        productSelected.clear();
        for (int i = 0; i < result.length; i++) {
          widget.detailDeal.product.add(Product(
              objectType: result[i]["object_type"] ?? "",
              objectName: result[i]["object_name"] ?? "",
              objectCode: result[i]["objectCode"] ?? "",
              objectId: result[i]["object_id"] ?? 0,
              quantity: result[i]["quantity"] ?? 0,
              price: result[i]["price"] ?? 0,
              amount: (result[i]["quantity"] ?? 0) * (result[i]["price"] ?? 0)));
          productSelected.add(widget.detailDeal.product[i].toJson());
        };
      }
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        keyboardDismissOnTap(context);
      },
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // + thêm sản phẩm
              (widget.detailDeal.product.length == 0)
                  ? InkWell(
                      onTap: _addProduct,
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        padding: EdgeInsets.all(8.0),
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                width: 1.0,
                                color: Colors.blue,
                                style: BorderStyle.solid)),
                        child: Center(
                          child: Text(
                            "+ ${AppLocalizations.text(LangKey.addProduct)}",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: const Color(0xFF0067AC),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Container(
                width: 15.0,
              ),

// + thông tin thêm
              (!showAdditionDeal && widget.detail.productBuy.length == 0)
                  ? InkWell(
                      onTap: () {
                        showAdditionDeal = !showAdditionDeal;
                        setState(() {});
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        padding: EdgeInsets.all(8.0),
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(
                                width: 1.0,
                                color: Colors.blue,
                                style: BorderStyle.solid)),
                        child: Center(
                          child: Text(
                            "+ ${AppLocalizations.text(LangKey.moreInformation)}",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: const Color(0xFF0067AC),
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                      ),
                    )
                  : Container()
            ],
          ),
          Column(
            children: [
              (widget.detailDeal.product.length > 0)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.text(LangKey.yourOrder),
                          style: TextStyle(
                              fontSize: 16.0,
                              color: const Color(0xFF0067AC),
                              fontWeight: FontWeight.normal),
                        ),
                        InkWell(
                          onTap: _addMoreProduct,
                          child: Text(
                            AppLocalizations.text(LangKey.chooseMoreItem),
                            style: TextStyle(
                                fontSize: 16.0,
                                color: const Color(0xFF0067AC),
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    )
                  : Container(),
              Container(
                height: 15.0,
              ),
              Container(
                child: CustomListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  controller: _controller,
                  physics: NeverScrollableScrollPhysics(),
                  separator: Divider(),
                  children: listProduct(),
                ),
              ),
            ],
          ),

          Column(
            children: _discountList(),
          ),

          // thông tin thêm
          (!showAdditionDeal && widget.detail.productBuy.length > 0)
              ? InkWell(
                  onTap: () {
                    showAdditionDeal = !showAdditionDeal;
                    setState(() {});
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                    padding: EdgeInsets.all(8.0),
                    height: 45,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0),
                        border: Border.all(
                            width: 1.0,
                            color: Colors.blue,
                            style: BorderStyle.solid)),
                    child: Center(
                      child: Text(
                        "+ ${AppLocalizations.text(LangKey.moreInformation)}",
                        style: TextStyle(
                            fontSize: 16.0,
                            color: const Color(0xFF0067AC),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                )
              : Container(),

          // showAdditionDeal ? moreInfo() : Container()
          CustomSizeTransaction(
            open: showAdditionDeal,
            child: moreInfo(),
          )
        ],
      ),
    );
  }

  Widget moreInfo() {
    return Container(
      margin: EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          // Container(height: 15.0),
          showAdditionDeal
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppLocalizations.text(LangKey.moreInformation),
                          style: TextStyle(
                              fontSize: 16.0,
                              color: const Color(0xFF0067AC),
                              fontWeight: FontWeight.normal),
                        ),
                        InkWell(
                          onTap: () {
                            showAdditionDeal = !showAdditionDeal;
                            setState(() {});
                          },
                          child: Text(
                            AppLocalizations.text(LangKey.collapse),
                            style: TextStyle(
                                fontSize: 16.0,
                                color: const Color(0xFF0067AC),
                                fontWeight: FontWeight.normal),
                          ),
                        )
                      ],
                    ),
                    // Container(height: 15.0)
                  ],
                )
              : Container(),
          (widget.branchData != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        AppLocalizations.text(LangKey.branch),
                        style: TextStyle(
                            fontSize: 15.0,
                            color: const Color(0xFF858080),
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //  color: Colors.black,
                      ),
                      height: 170,
                      child: SingleChildScrollView(
                        physics: ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: listBranch(),
                        ),
                      ),
                    ),
                  ],
                )
              : Container(),
          Container(
            height: 15,
          ),

          _buildTextField(
              AppLocalizations.text(LangKey.deal_source),
              widget.detail?.orderSourceName ?? "",
              Assets.iconTag,
              false,
              true,
              false, ontap: () async {
            print("nguon don hang");

            FocusScope.of(context).unfocus();
            if (orderSourceData == null || orderSourceData.length == 0) {
              DealConnection.showLoading(context);
              var orderSources = await DealConnection.getOrderSource(context);
              Navigator.of(context).pop();
              if (orderSources != null) {
                orderSourceData = orderSources.data;

                OrderSourceData orderSource = await showModalBottomSheet(
                    context: context,
                    useRootNavigator: true,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) {
                      return GestureDetector(
                        child: OrderSourcesModal(
                          orderSourceData: orderSourceData,
                          orderSourceSelected: widget.orderSourceSelected,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        behavior: HitTestBehavior.opaque,
                      );
                    });
                if (orderSource != null) {
                  widget.detail?.orderSourceName = orderSource.orderSourceName;
                  widget.orderSourceSelected = orderSource;
                  widget.detailDeal.orderSourceId =
                      widget.orderSourceSelected.orderSourceId;
                  setState(() {});
                }
              }
            } else {
              OrderSourceData orderSource = await showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return GestureDetector(
                      child: OrderSourcesModal(
                        orderSourceData: orderSourceData,
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      behavior: HitTestBehavior.opaque,
                    );
                  });
              if (orderSource != null) {
                // widget.orderSourceSelected = orderSource;
                widget.detail?.orderSourceName = orderSource.orderSourceName;
                widget.detailDeal.orderSourceId =
                    widget.orderSourceSelected.orderSourceId;
                setState(() {});
              }
            }
          }),
          _buildTextField("Nhập xác suất thành công (%)", "",
              Assets.iconProbability, false, false, true,
              fillText: _probabilityText,
              focusNode: _probabilityFocusNode,
              inputType: TextInputType.numberWithOptions(
                  signed: false, decimal: false)),
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: CustomTextField(
              maxLines: 4,
              backgroundColor: Colors.transparent,
              borderColor: AppColors.borderColor,
              hintText: "Nhập mô tả chi tiết cơ hội bán hàng",
              controller: _detailDealText,
              focusNode: _detailDealFocusNode,
              onChanged: (event) {
                widget.detailDeal.dealDescription = _detailDealText.text;
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listBranch() {
    return List.generate(
        widget.branchData.length,
        (index) => buildItemBranch(
                widget.branchData[index], widget.branchData[index].selected,
                () {
              selectedItem(index);
            }));
  }

  List<Widget> listProduct() {
    return List.generate(
      widget.detailDeal.product.length,
      (index) => product(widget.detailDeal.product[index], index, ()
          // xoa item
          {
        if (widget.detailDeal.product[index].objectType == "product") {
          var event = GlobalCart.shared.products.firstWhereOrNull((p0) =>
              p0.productId == widget.detailDeal.product[index].objectId);
          if (event != null) {
            GlobalCart.shared.removeProduct(event);
          }
        } else {
          var event = GlobalCart.shared.services.firstWhereOrNull((p0) =>
              p0.serviceId == widget.detailDeal.product[index].objectId);
          if (event != null) {
            GlobalCart.shared.removeService(event);
          }
        }
        widget.detailDeal.product.removeAt(index);
        productSelected.removeAt(index);
        _setDiscount();
        setState(() {});
      },
          // - so luong
          () {
        // minusItem(widget.detailDeal.product[index], productSelected[index]);
      },
          // + so luong
          () {
        // plusItem(widget.detailDeal.product[index], productSelected[index]);
      }),
    );
  }

  // void minusItem(Product item, Map<String, dynamic> json) {
  //   if (item.quantity == 1) {
  //     json['quantity'] = 1;
  //     return;
  //   } else {
  //     json['quantity'] -= 1;
  //     item.quantity -= 1;
  //     item.amount = item.quantity * item.price;
  //   }

  //   setState(() {});
  // }

  // void plusItem(Product item, Map<String, dynamic> json) {
  //   json['quantity'] += 1;
  //   item.quantity += 1;
  //   setState(() {});
  // }

  Widget buildItemBranch(BranchData item, bool selected, Function ontap) {
    return InkWell(
      onTap: ontap,
      child: Container(
        width: 200,
        height: 150,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              margin: EdgeInsets.only(right: 20.0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.black,
                  border: selected
                      ? Border.all(
                          width: 4.0,
                          color: Color(0xFF0067AC),
                          style: BorderStyle.solid)
                      : Border.all(
                          width: 3.0,
                          color: Color.fromARGB(255, 227, 235, 241),
                          style: BorderStyle.solid),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3), BlendMode.dstATop),
                    image: (item?.avatar == null)
                        ? AssetImage(Assets.imgEpoint)
                        : NetworkImage(item?.avatar),
                  )),
              child: Center(
                child: Text(
                  item?.address ?? "",
                  style: TextStyle(color: Colors.white, fontSize: 15.0),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            selected
                ? Positioned(
                    left: 160,
                    bottom: 125,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Color(0xFF0067AC)),
                      child: Icon(Icons.check, color: Colors.white),
                    ))
                : Container()
          ],
        ),
      ),
    );
  }

  selectedItem(int index) async {
    List<BranchData> models = widget.branchData;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    widget.detailDeal.branchCode = models[index].branchCode;
    setState(() {});
  }

  Widget _buildTextField(String title, String content, String icon,
      bool mandatory, bool dropdown, bool textfield,
      {Function ontap,
      TextEditingController fillText,
      FocusNode focusNode,
      TextInputType inputType,
      int maxLenght}) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: (ontap != null) ? ontap : null,
        child: TextField(
          enabled: textfield,
          readOnly: !textfield,
          controller: fillText,
          focusNode: focusNode,
          maxLength: (maxLenght != null) ? maxLenght : null,
          keyboardType: (inputType != null) ? inputType : TextInputType.text,
          decoration: InputDecoration(
            counterText: '',
            counter: Container(),
            isCollapsed: true,
            contentPadding: EdgeInsets.all(12.0),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1, color: Color.fromARGB(255, 21, 230, 129)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Color(0xFFB8BFC9)),
            ),
            label: (content == "")
                ? RichText(
                    text: TextSpan(
                        text: title,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: const Color(0xFF858080),
                            fontWeight: FontWeight.normal),
                        children: [
                        if (mandatory)
                          TextSpan(
                              text: "*", style: TextStyle(color: Colors.red))
                      ]))
                : Text(
                    content,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  ),
            prefixIcon: Padding(
              padding: EdgeInsets.all(8.0),
              child: Image.asset(
                icon,
              ),
            ),
            prefixIconConstraints:
                BoxConstraints(maxHeight: 32.0, maxWidth: 32.0),
            suffixIcon: dropdown
                ? Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Image.asset(
                      Assets.iconDropDown,
                    ),
                  )
                : Container(),
            suffixIconConstraints:
                BoxConstraints(maxHeight: 32.0, maxWidth: 32.0),
            isDense: true,
          ),
          onChanged: (event) {
            print(event.toLowerCase());
            if (fillText != null) {
              print(fillText.text);
              if (fillText != null) {
                print(fillText.text);
                if (fillText == _probabilityText) {
                  widget.detailDeal.probability =
                      double.tryParse(fillText.text) ?? 0;
                  widget.detailDeal?.probability =
                      num.tryParse(fillText.text ?? "0");
                  if ((widget.detailDeal.probability ?? 0) > 100) {
                    _probabilityText.text = "100";
                    widget.detailDeal?.probability = 100;
                    _probabilityText.selection = TextSelection.fromPosition(
                        TextPosition(offset: _probabilityText.text.length));
                  }
                }
              }
            }
          },
        ),
      ),
    );
  }

   List<Widget> _discountList() {
    List<Widget> _arr = [];
    _arr.add(Padding(
        padding: const EdgeInsets.only(
            top: 8.0, bottom: 5.0, left: 2.0, right: 10.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Icon(
                Icons.card_giftcard,
                color: AppColors.primaryColor,
                size: 20.0,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: AutoSizeText(
                  AppLocalizations.text(LangKey.apply_promotion),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryColor),
                ),
              ),
            ),
          ],
        )));
    _arr.add(Container(
      height: 1.0,
      color: AppColors.subColor.withAlpha(20),
    ));
    _arr.add(
      Container(
        margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
        child: Row(
          children: [
            AutoSizeText(
              '${AppLocalizations.text(LangKey.total_quantity)}:  ',
              style: TextStyle(
                color: AppColors.subColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
                child: StreamBuilder(
              initialData: null,
              stream: GlobalCart.shared.bloc.outputValue,
              builder: (_, snapshot) {
                return AutoSizeText(
                  '${(GlobalCart.shared.bloc.getQty().toPrecision(2))}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.subColor, fontWeight: FontWeight.w600),
                );
              },
            ))
          ],
        ),
      ),
    );

    _arr.add(
      Container(
        margin: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
        child: Row(
          children: [
            AutoSizeText(
              '${AppLocalizations.text(LangKey.total_money)}:  ',
              style: TextStyle(
                color: AppColors.subColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
                child: StreamBuilder(
              initialData: 0.0,
              stream: GlobalCart.shared.bloc.outputValue,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  double value = snapshot.data;
                  return AutoSizeText(
                    value.getMoneyFormat(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.subColor, fontWeight: FontWeight.w600),
                  );
                } else {
                  return AutoSizeText(
                    0.0.getMoneyFormat(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: AppColors.subColor, fontWeight: FontWeight.w600),
                  );
                }
              },
            ))
          ],
        ),
      ),
    );

    _arr.add(
      Container(
        margin: EdgeInsets.symmetric(
            vertical: 0.0, horizontal: 10.0),
        // margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
        child: Row(
          children: [
            Text(
              '${AppLocalizations.text(LangKey.discount)}:  ',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.w600),
            ),
            Expanded(
                child: AutoSizeText(
              (_discount ?? 0.0).getMoneyFormat(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: AppColors.subColor, fontWeight: FontWeight.w600),
            )),
            InkWell(
              onTap: _discount == null
                  ? () => _showMenu()
                  : () {
                      setState(() {
                        _discount = null;
                        Global.discount = 0;
                      });
                    },
              child: Container(
                height: 30.0,
                width: 30.0,
                child: Center(
                  child: _discount == null
                      ? Icon(
                    Icons.add,
                    color: AppColors.primaryColor,
                    size: 20.0,
                  )
                      : Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 20.0,
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );

    _arr.add(Container(
                margin: EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                child: Row(
                  children: [
                    AutoSizeText(
                      '${AppLocalizations.text(LangKey.temporary_price)}:   ',
                      style: TextStyle(
                          color: AppColors.subColor,
                          fontWeight: FontWeight.w600),
                    ),
                    Expanded(
                        child: StreamBuilder(
                      initialData: 0.0,
                      stream: GlobalCart.shared.bloc.outputValue,
                      builder: (_, snapshot) {
                        if (snapshot.hasData) {
                          double valueMoney = snapshot.data;
                          double total = valueMoney +
                              (transportCharge ?? 0) -
                              (_discount ?? 0);
                          Global.amount = total;
                          if (total < 0) {
                            total = 0;
                          }
                          return AutoSizeText(
                            total.getMoneyFormat(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.subColor,
                                fontWeight: FontWeight.w600),
                          );
                        } else {
                          return AutoSizeText(
                            0.0.getMoneyFormat(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: AppColors.subColor,
                                fontWeight: FontWeight.w600),
                          );
                        }
                      },
                    ))
                  ],
                ),
              ),);

    return _arr;
  }

  _showMenu() async {
    DiscountCartModel model = await CustomNavigator.showCustomBottomDialog(context, DiscountScreen());
    if(model != null){
    //   if(model.model != null){
    //     setState(() {
    //       _discount = model.model.discount;
    //       voucher = model.model;
    //     });
    //   }
    //   else
       if(model.amount != null){
        _setDiscountDirectPrice(model.amount);
      }
      else {
        _setDiscountPercentPrice(model.percent);
      }
    }
  }

  void _setDiscountDirectPrice(dynamic value) {
    setState(() {
      if (value == null) {
        _discount = null;
      } else if (value == 0) {
        _discount = null;
      } else {
        double val = double.tryParse(value.toString());
        if (val == 0 || val == null) {
          _discount = null;
        } else {
          _discount = val;
        }
      }
    });
    Global.discount = _discount;
  }

  void _setDiscountPercentPrice(dynamic value) {
    setState(() {
      if (value == null) {
        _discount = null;
      } else if (value == 0) {
        _discount = null;
      } else {
        double val = double.tryParse(value.toString());
        if (val == 0 || val == null) {
          _discount = null;
        } else {
          _discount = double.tryParse(
              ((GlobalCart.shared.getValue().round() * val) / 100)
                  .round()
                  .toString());
        }
      }
    });

    Global.discount = _discount;
  }

  void _setDiscount() {
      double total = GlobalCart.shared.getValue();
      print(total);

    if (_discountTypeDirect == 0) {
        // double totalDiscount = double.tryParse(_controllerDiscount.text) ?? 0.0;

        // if (totalDiscount >= total) {
        //   _discount = total;
        //   _controllerDiscount.text = total.toString();
        // }
      
       _setDiscountDirectPrice(_controllerDiscount.text);
       } else { 
         _setDiscountPercentPrice(_controllerDiscount.text);
         }
    }

  Widget product(Product item, int index, Function ontapDelete, Function OntapMinus,
      Function ontapPlus) {
    return InkWell(
      onTap: () async {
        var event = item.objectType == "product"
            ? await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ProductDetailScreen(
                    ProductModel(
                        newPrice: item.price.toDouble(),
                        productId: item.objectId,
                        qty: item.quantity,
                        note: item.note),
                    false,
                    isUpdate: true)))
            : await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ServiceDetailScreen(
                    ServiceModel(newPrice: item.price.toDouble(), serviceId: item.objectId, qty: item.quantity, note: item.note),
                    false,
                    isUpdate: true)));

        if ((event != null)) {

          item.price = event["new_price"] ?? "";
          item.quantity = event["quantity"] ?? 0;
          item.note = event["note"] ?? "";
          item.amount = (item.quantity ?? 0) * item.price ?? 0;

          if (item.objectType == "product") {
            var event = GlobalCart.shared.products.firstWhereOrNull((p0) =>
                p0.productId == widget.detailDeal.product[index].objectId);
            if (event != null) {
              event.price = item.price;
              event.qty = item.quantity;
              event.note = item.note;
            }
          } else {
            var event = GlobalCart.shared.services.firstWhereOrNull((p0) =>
                p0.serviceId == widget.detailDeal.product[index].objectId);
            if (event != null) {
              event.price = item.price;
              event.qty = item.quantity;
              event.note = item.note;
            }
          }
          // GlobalCart.shared.bloc.getValue();
          _setDiscount();

          productSelected[index] = item.toJson();

          setState(() {});
        }
      },
      child: Container(
        padding: EdgeInsets.all(AppSizes.minPadding),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 1,
                color: Colors.black.withOpacity(0.3),
              )
            ]),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                      // width: MediaQuery.of(context).size.width - 80,
                      child: RichText(
                          text: TextSpan(
                              text: item?.objectName ?? "",
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal),
                              children: [
                        TextSpan(
                            text: "", style: TextStyle(color: Color(0xFF8E8E8E)))
                      ]))),
                ),
                InkWell(
                    onTap: ontapDelete,
                    child: Icon(
                      Icons.clear,
                      color: Color(
                        0xFFC4C4C4,
                      ),
                      size: 20.0,
                    ))
              ],
            ),
            Container(
              height: 15.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${(item.amount ?? 0).getMoneyFormat()} VND",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal),
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     InkWell(
                //       onTap: OntapMinus,
                //       child: Text("-",
                //           style: TextStyle(
                //               fontSize: 25.0,
                //               color: Color.fromARGB(255, 121, 179, 182),
                //               fontWeight: FontWeight.bold)),
                //     ),
                //     Container(
                //         padding: EdgeInsets.all(4.0),
                //         margin: EdgeInsets.only(right: 10.0, left: 10.0),
                //         decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(10),
                //           border: Border.all(
                //               width: 1.0,
                //               color: Color(0xFF4FC4CA),
                //               style: BorderStyle.solid),
                //         ),
                //         width: 80,
                //         height: 30,
                //         child: Center(
                //           child: Text(
                //             "${item?.quantity}" ?? "1",
                //             style: TextStyle(
                //                 fontSize: 16.0,
                //                 color: Colors.black,
                //                 fontWeight: FontWeight.normal),
                //           ),
                //         )),
                //     InkWell(
                //       onTap: ontapPlus,
                //       child: Text("+",
                //           style: TextStyle(
                //               fontSize: 25.0,
                //               color: Color(0xFF4FC4CA),
                //               fontWeight: FontWeight.bold)),
                //     )
                //   ],
                // )
                Text(
                    "x${item.quantity}",
                    style: TextStyle(
                        fontSize: 16.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                  )
              ],
            )
          ],
        ),
      ),
    );
  }
}

extension MoneyFormat on int {
  String getMoneyFormat() {
    if (this == null) {
      return "0 VND";
    } else {
      return AppFormat.moneyFormat.format(this);
    }
  }
}

extension MoneyFormatNum on num {
  String getMoneyFormat() {
    if (this == null) {
      return "0 VND";
    } else {
      return AppFormat.moneyFormat.format(this);
    }
  }
}
