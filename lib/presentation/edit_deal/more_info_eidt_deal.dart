import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/presentation/modal/order_source_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/tags_modal.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoreInfoEditDeal extends StatefulWidget {
  String tagsString;
  List<TagData> tagsData;
  DetailDealData detail;
  List<BranchData> branchData;
  OrderSourceData orderSourceSelected;
  AddDealModelRequest detailDeal;
  MoreInfoEditDeal(
      {Key key,
      this.branchData,
      this.orderSourceSelected,
      this.detail,
      this.tagsData, this.tagsString,this.detailDeal});

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

  List<OrderSourceData> orderSourceData;
  // OrderSourceData orderSourceSelected;

  // List<TagData> tagsData;
  List<TagData> tagsSelected;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.detail?.probability != null) {
        _probabilityText.text = NumberFormat.currency(
              locale: 'vi_VN',
              decimalDigits: 0,
              symbol: '',
            ).format(num.parse(widget.detail?.probability ?? ""));
      }

      _detailDealText.text = widget.detail?.dealDescription ?? "";
      setState(() {});
    });
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
              (widget.detail.productBuy.length == 0)
                  ? InkWell(
                      onTap: () async {
                        if (Global.getListProduct != null)  {
                              List<Map<String,dynamic>> result = await Global.getListProduct();
                              if (result != null) {
                                if (result.length > 0) {
                                  widget.detail.productBuy.clear();
                                  for (int i = 0 ; i < result.length ; i ++) {
                                    widget.detail.productBuy.add(ProductBuy(
                                objectType: result[i]["object_type"] ?? "",
                                objectName: result[i]["object_name"] ?? "",
                                // objectCode: result[i]["objectCode"] ?? "",
                                objectId: result[i]["object_id"] ?? "",
                                quantity: result[i]["quantity"] ?? "",
                                price: result[i]["price"] ?? "",
                                amount: result[i]["amount"] ?? ""));
                                  };
                                }
                              }
                            }
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
              (widget.detail.productBuy.length > 0)
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
                          onTap: () async {
                            if (Global.getListProduct != null)  {
                              List<Map<String,dynamic>> result = await Global.getListProduct();
                              if (result != null) {
                                if (result.length > 0) {
                                  for (int i = 0 ; i < result.length ; i ++) {
                                    widget.detail.productBuy.add(ProductBuy(
                                objectType: result[i]["object_type"] ?? "",
                                objectName: result[i]["object_name"] ?? "",
                                // objectCode: result[i]["objectCode"] ?? "",
                                objectId: result[i]["object_id"] ?? "",
                                quantity: result[i]["quantity"] ?? "",
                                price: result[i]["price"] ?? "",
                                amount: result[i]["amount"] ?? ""));
                                  };
                                }
                              }
                            }
                            setState(() {});
                          },
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

          showAdditionDeal ? moreInfo() : Container()
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
                    Container(height: 15.0)
                  ],
                )
              : Container(),
          (widget.branchData != null)
              ? Container(
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
                )
              : Container(),
          Container(
            height: 15,
          ),
          _buildTextField("Tag", widget.tagsString, Assets.iconTag, false, true, false,
              ontap: () async {
            print("Tag");
            FocusScope.of(context).unfocus();
            var listTagsSelected = await showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return GestureDetector(
                    child: TagsModal(
                      tagsData: widget.tagsData,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    behavior: HitTestBehavior.opaque,
                  );
                });
            if (listTagsSelected != null) {
              widget.detail.tag = <int>[];
              widget.tagsString = "";
              tagsSelected = listTagsSelected;

              for (int i = 0; i < tagsSelected.length; i++) {
                if (tagsSelected[i].selected) {
                  widget.detail.tag.add(tagsSelected[i].tagId);

                  if (widget.tagsString == "") {
                    widget.tagsString = tagsSelected[i].name;
                  } else {
                    widget.tagsString += ", ${tagsSelected[i].name}";
                  }
                }
              }
              setState(() {});
            }
          }),
          _buildTextField(
              AppLocalizations.text(LangKey.orderSource),
              widget.orderSourceSelected?.orderSourceName ?? "",
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
                widget.orderSourceSelected = orderSource;
                setState(() {});
              }
            }
          }),
          _buildTextField(AppLocalizations.text(LangKey.probability), "",
              Assets.iconProbability, false, false, true,
              fillText: _probabilityText,
              focusNode: _probabilityFocusNode,
              inputType: TextInputType.number),
          _buildTextField(AppLocalizations.text(LangKey.dealDetail), "",
              Assets.iconDealDetail, false, false, true,
              fillText: _detailDealText,
              focusNode: _detailDealFocusNode,
              inputType: TextInputType.text),
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
      widget.detail.productBuy.length,
      (index) => product(widget.detail.productBuy[index], ()
          // xoa item
          {
        widget.detail.productBuy.removeAt(index);
        setState(() {});
      },
          // - so luong
          () {
        minusItem(widget.detail.productBuy[index]);
      },
          // + so luong
          () {
        plusItem(widget.detail.productBuy[index]);
      }),
    );
  }

  void minusItem(ProductBuy item) {
    if (item.quantity == 1) {
      return;
    } else {
      item.quantity -= 1;
    }

    setState(() {});
  }

  void plusItem(ProductBuy item) {
    item.quantity += 1;
    setState(() {});
  }

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
      TextInputType inputType, int maxLenght}) {
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
              if (fillText == _probabilityText) {
                widget.detailDeal.probability =
                    double.tryParse(fillText.text) ?? 0;
                     if (widget.detailDeal.probability > 100) {
                  _probabilityText.text = "100";
                  widget.detailDeal.probability = 100;
                  _probabilityText.selection = TextSelection.fromPosition(TextPosition(offset: _probabilityText.text.length));
                }
              } else {
                widget.detailDeal.dealDescription = fillText.text;
              }
            }
          },
        ),
      ),
    );
  }

  Widget product(ProductBuy item, Function ontapDelete, Function OntapMinus,
      Function ontapPlus) {
    return Container(
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
                "${NumberFormat("#,###", "vi-VN").format(item.amount)} VNĐ",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: OntapMinus,
                    child: Text("-",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Color.fromARGB(255, 121, 179, 182),
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                      padding: EdgeInsets.all(4.0),
                      margin: EdgeInsets.only(right: 10.0, left: 10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1.0,
                            color: Color(0xFF4FC4CA),
                            style: BorderStyle.solid),
                      ),
                      width: 80,
                      height: 30,
                      child: Center(
                        child: Text(
                          "${item?.quantity}" ?? "1",
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black,
                              fontWeight: FontWeight.normal),
                        ),
                      )),
                  InkWell(
                    onTap: ontapPlus,
                    child: Text("+",
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Color(0xFF4FC4CA),
                            fontWeight: FontWeight.bold)),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

extension MoneyFormat on int {
  String getMoneyFormat() {
    if (this == null) {
      return "0";
    } else {
      return NumberFormat("#,###", "vi-VN").format(this);
    }
  }
}
