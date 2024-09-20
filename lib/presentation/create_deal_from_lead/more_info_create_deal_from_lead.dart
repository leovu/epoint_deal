import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/update_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/member_discount_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/create_deal_bloc.dart';
import 'package:epoint_deal_plugin/presentation/modal/order_source_modal.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_size_transaction.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield_lead.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MoreInfoCreateDealFromLead extends StatefulWidget {
  String? tagsString;
  List<TagData>? tagsData;
  List<BranchData>? branchData;
  OrderSourceData? orderSourceSelected;
  UpdateDealModelRequest? detailDeal;
  late CreateDealBloc bloc;
  MoreInfoCreateDealFromLead(
      {Key? key,
      this.branchData,
      this.orderSourceSelected,
      this.tagsData,
      this.tagsString,
      this.detailDeal,
      required this.bloc});

  @override
  _MoreInfoCreateDealFromLeadState createState() => _MoreInfoCreateDealFromLeadState();
}

class _MoreInfoCreateDealFromLeadState extends State<MoreInfoCreateDealFromLead> {
  ScrollController _controller = ScrollController();
  bool showAdditionDeal = false;

  TextEditingController _expectRevenueText = TextEditingController();
  FocusNode _expectRevenueFocusNode = FocusNode();

  TextEditingController _probabilityText = TextEditingController();
  FocusNode _probabilityFocusNode = FocusNode();

  TextEditingController _detailDealText = TextEditingController();
  FocusNode _detailDealFocusNode = FocusNode();

  List<OrderSourceData>? orderSourceData;
  OrderSourceData? orderSourceSelected;

  // List<TagData> tagsData;
  List<TagData>? tagsSelected;
  String tagsString = "";
  List<Map<String, dynamic>> productSelected = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {

      setState(() {});
    });
  }

   @override
  void didUpdateWidget(covariant MoreInfoCreateDealFromLead oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.bloc != oldWidget.bloc) {
      setState(() {});
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        keyboardDismissOnTap(context);
      },
      child: Column(
        children: [

          // thông tin thêm
          (!showAdditionDeal)
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
          ),
          Gaps.vGap10,
          _buildOrder(),
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
                          AppLocalizations.text(LangKey.moreInformation)!,
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
                            AppLocalizations.text(LangKey.collapse)!,
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
                        AppLocalizations.text(LangKey.branch)!,
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
              "Nguồn cơ hội bán hàng",
             widget.orderSourceSelected?.orderSourceName ?? "",
              Assets.iconTag,
              false,
              true,
              false, ontap: () async {
            print("nguon don hang");

            FocusScope.of(context).unfocus();
            if (orderSourceData == null || orderSourceData!.length == 0) {
              DealConnection.showLoading(context);
              var orderSources = await DealConnection.getOrderSource(context);
              Navigator.of(context).pop();
              if (orderSources != null) {
                orderSourceData = orderSources.data;

                OrderSourceData? orderSource = await showModalBottomSheet(
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
                  widget.detailDeal!.orderSourceId =
                      widget.orderSourceSelected!.orderSourceId;
                  setState(() {});
                }
              }
            } else {
              OrderSourceData? orderSource = await showModalBottomSheet(
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
                // widget.detail?.orderSourceName = orderSource.orderSourceName;
                widget.detailDeal!.orderSourceId =
                    widget.orderSourceSelected!.orderSourceId;
                setState(() {});
              }
            }
          }),

          CustomTextfieldDropdownWidget(
          title: "Doanh thu kỳ vọng",
          content: "",
          textfield: true,
          mandatory: false,
          icon: Assets.iconItinerary,
          fillText: _expectRevenueText,
          focusNode: _expectRevenueFocusNode,
          inputType: TextInputType.numberWithOptions(signed: false, decimal: false),
          inputMoney: true,
        ),

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
                widget.detailDeal!.dealDescription = _detailDealText.text;
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> listBranch() {
    return List.generate(
        widget.branchData!.length,
        (index) => buildItemBranch(
                widget.branchData![index], widget.branchData![index].selected!,
                () {
              selectedItem(index);
            }));
  }

  Widget buildItemBranch(BranchData? item, bool selected, GestureTapCallback ontap) {
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
                    image: ((item?.avatar == null)
                        ? AssetImage(Assets.imgEpoint)
                        : NetworkImage(item?.avatar ?? "")) as ImageProvider<Object>,
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
    List<BranchData> models = widget.branchData!;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    widget.detailDeal!.branchCode = models[index].branchCode;
    setState(() {});
  }

     Widget _buildOrder() {
    return StreamBuilder(
        stream: Globals.cart!.outputValue,
        initialData: widget.bloc.total,
        builder: (_, snapshot) {
          widget.bloc.total = (snapshot.data as double?) ?? 0.0;
          return StreamBuilder(
              stream: widget.bloc.outputMemberDiscountModel,
              initialData: widget.bloc.defaultDiscountMemberModel,
              builder: (_, snapshot) {
                widget.bloc.discountMemberHasError = snapshot.hasError;
                widget.bloc.discountMemberError = snapshot.error;
                widget.bloc.discountMemberModel =
                    snapshot.data as MemberDiscountResponseModel?;
                widget.bloc.discountMember = double.tryParse(
                        widget.bloc.discountMemberModel?.discountMember ?? "0") ??
                    0.0;
                return StreamBuilder(
                    stream: widget.bloc.outputVATModel,
                    initialData: widget.bloc.vatModel,
                    builder: (_, snapshot) {
                      return StreamBuilder(
                          stream: widget.bloc.outputTransportCharge,
                          initialData: widget.bloc.transportCharge,
                          builder: (_, snapshot) {
                            return StreamBuilder(
                                stream: widget.bloc.outputSurchargeModels,
                                initialData: widget.bloc.surchargeModels,
                                builder: (_, snapshot) {
                                  widget.bloc.surcharge =
                                      widget.bloc.getSurcharge(widget.bloc.total);
                                  return StreamBuilder(
                                      stream: widget.bloc.outputVoucherModel,
                                      initialData: widget.bloc.voucherModel,
                                      builder: (_, snapshot) {
                                        widget.bloc.discount = 0.0;
                                        if (widget.bloc.voucherModel != null) {
                                          widget.bloc.discount = getDiscount(
                                              widget.bloc.voucherModel,
                                              total: widget.bloc.total);
                                        }
                                        widget.bloc.amount = widget.bloc.total -
                                            widget.bloc.discount -
                                            widget.bloc.discountMember +
                                            (widget.bloc.transportCharge ?? 0.0) +
                                            widget.bloc.surcharge;

                                        if (widget.bloc.amount < 0) {
                                          widget.bloc.amount = 0;
                                        }

                                        if (widget.bloc.vatModel != null) {
                                          double vat = widget.bloc.vatModel == null
                                              ? widget.bloc.vatDefault
                                              : widget.bloc.vatModel!.data;
                                          widget.bloc.totalTax =
                                              vat / 100 * widget.bloc.amount;
                                          if (widget.bloc.vatIncluded) {
                                            widget.bloc.amountBeforeTax =
                                                widget.bloc.amount - widget.bloc.totalTax;
                                          } else {
                                            widget.bloc.amountBeforeTax =
                                                widget.bloc.amount;
                                            widget.bloc.amount = widget.bloc.totalTax +
                                                widget.bloc.amountBeforeTax;
                                          }
                                        } else {
                                          widget.bloc.amountBeforeTax = widget.bloc.amount;
                                        }

                                        return _buildContent();
                                      });
                                });
                          });
                    });
              });
        });
  }

  Widget _buildContent() {
    return Column(
      children: [
        _buildItems(),
         Gaps.vGap10,
          _buildTotal(),
         Gaps.vGap10,
        _buildDiscount(),
         Gaps.vGap10,
        _buildTotalPreTax(),
         Gaps.vGap10,
        _buildVAT(),
         Gaps.vGap10,
        _buildSurcharge(),
        Gaps.vGap10,
        _buildFinalMoney(),
        Gaps.vGap20,
      ],
    );
  }

  Widget _buildItems() {
    return StreamBuilder(
        stream: widget.bloc.outputProductModels,
        initialData: Globals.cart!.products,
        builder: (_, snapshot) {
          List<ProductNewModel>? productModels =
              snapshot.data as List<ProductNewModel>?;
          return StreamBuilder(
              stream: widget.bloc.outputServiceModels,
              initialData: Globals.cart!.services,
              builder: (_, snapshot) {
                List<ServiceNewModel>? serviceModels =
                    snapshot.data as List<ServiceNewModel>?;

                return StreamBuilder(
                    stream: widget.bloc.outputServiceCardModels,
                    initialData: Globals.cart!.serviceCards,
                    builder: (_, snapshot) {
                      List<OrderServiceCardModel>? serviceCardModels =
                          snapshot.data as List<OrderServiceCardModel>?;

                      return StreamBuilder(
                          stream: widget.bloc.outputServiceCardActivatedModels,
                          initialData: Globals.cart!.serviceActivatedCards,
                          builder: (_, snapshot) {
                            List<ServiceCardModel>? serviceCardActivatedModels =
                                snapshot.data as List<ServiceCardModel>?;

                            return _buildTitle(
                                "${AppLocalizations.text(LangKey.product)} / ${AppLocalizations.text(LangKey.service)}",
                                ContainerItemsOrder(
                                  productModels: productModels,
                                  serviceModels: serviceModels,
                                  serviceCardModels: serviceCardModels,
                                  serviceCardActivatedModels:
                                      serviceCardActivatedModels,
                                  onProductTap: widget.bloc.onProductTap,
                                  onServiceTap: widget.bloc.onServiceTap,
                                  onServiceCardTap:
                                      widget.bloc.onServiceCardTap,
                                  onServiceCardActivatedTap:
                                      widget.bloc.onServiceCardActivatedTap,
                                  onProductDelete: widget.bloc.onProductRemove,
                                  onServiceDelete: widget.bloc.onServiceRemove,
                                  onServiceCardDelete:
                                      widget.bloc.onServiceCardRemove,
                                  onServiceCardActivatedDelete:
                                      widget.bloc.onServiceCardActivatedRemove,
                                ),
                                content: AppLocalizations.text(
                                    (productModels?.length ??
                                                serviceModels?.length ??
                                                serviceCardModels?.length ??
                                                serviceCardActivatedModels
                                                    ?.length ??
                                                0) ==
                                            0
                                        ? LangKey.add
                                        : LangKey.update),
                                onTap: widget.bloc.onAddItems);
                          });
                    });
              });
        });
  }


  Widget _buildTitle(String? title, Widget child,
      {bool isRequired = false,
      Widget? suffix,
      String? content,
      GestureTapCallback? onTap}) {
    return CustomColumnInformation(
      title: title,
      child: child,
      isRequired: isRequired,
      titleSuffix: suffix ??
          (content != null
              ? Text(
                  "+ $content",
                  style: AppTextStyles.style14PrimaryRegular,
                  textAlign: TextAlign.right,
                )
              : null),
      onTitleTap: onTap,
    );
  }

  Widget _buildTotal() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.total),
      content: formatMoney(widget.bloc.total),
      contentStyle: AppTextStyles.style14BlackBold,
    );
  }

  Widget _buildDiscount() {
    return CustomBookingDiscount(
        model: widget.bloc.voucherModel,
        focusNode: widget.bloc.focusDiscount,
        controller: widget.bloc.controllerDiscount,
        onChoose: widget.bloc.chooseVoucher,
        onRemove: widget.bloc.removeVoucher);
  }

  Widget _buildTotalPreTax() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.total_pre_tax_money),
      content: formatMoney(widget.bloc.amountBeforeTax),
      contentStyle: AppTextStyles.style14BlackBold,
    );
  }

  Widget _buildVAT() {
    return CustomRowInformation(
      icon: Assets.iconTagPercent,
      title: AppLocalizations.text(LangKey.vat),
      titleStyle: AppTextStyles.style14BlackNormal,
      child: StreamBuilder(
          stream: widget.bloc.outputVATModels,
          initialData: widget.bloc.vatModels,
          builder: (_, snapshot) {
            return CustomDropdown(
              value: widget.bloc.vatModel,
              menus: widget.bloc.vatModels,
              hint: "${formatMoney(widget.bloc.vatDefault)}%",
              onChanged: (event) => widget.bloc.onSelectVAT(event),
              onRemove: widget.bloc.onRemoveVAT,
            );
          }),
    );
  }

  Widget _buildSurcharge() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.other_revenues),
      icon: Assets.iconMoneyOwed,
      titleStyle: AppTextStyles.style14BlackNormal,
      child: InkWell(
          child: CustomDropdown(
            isText: true,
            hint: AppLocalizations.text(LangKey.apply_other_revenues),
            value: widget.bloc.surcharge == 0.0
                ? null
                : CustomDropdownModel(text: formatMoney(widget.bloc.surcharge)),
            isHint: widget.bloc.surcharge == 0.0,
            menus: [CustomDropdownModel()],
            showIcon: true,
            suffixIcon: Icons.navigate_next,
            onRemove: widget.bloc.onRemoveSurcharge,
          ),
          onTap: widget.bloc.otherFreeBranch),
    );
  }

  Widget _buildFinalMoney() {
   return CustomRowInformation(
      title: AppLocalizations.text(LangKey.final_money),
      content: formatMoney(widget.bloc.amount),
      contentStyle: AppTextStyles.style14BlackBold,
    );
  }


  Widget _buildTextField(String? title, String content, String icon,
      bool mandatory, bool dropdown, bool textfield,
      {GestureTapCallback? ontap,
      TextEditingController? fillText,
      FocusNode? focusNode,
      TextInputType? inputType,
      int? maxLenght}) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      child: InkWell(
        onTap: (ontap != null) ? ontap : null,
        child: TextField(
          // maxLength: (maxLenght != null) ? maxLenght : null,
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
                widget.detailDeal!.probability =
                    double.tryParse(fillText.text) ?? 0;
                if (widget.detailDeal!.probability! > 100) {
                  _probabilityText.text = "100";
                  widget.detailDeal!.probability = 100;
                  _probabilityText.selection = TextSelection.fromPosition(
                      TextPosition(offset: _probabilityText.text.length));
                }
              }
            }
          },
        ),
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
