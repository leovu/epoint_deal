import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/customer_type.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/booking_store_request_model.dart';
import 'package:epoint_deal_plugin/model/request/get_journey_model_request.dart';
import 'package:epoint_deal_plugin/model/request/get_list_staff_request_model.dart';
import 'package:epoint_deal_plugin/model/request/update_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/booking_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_allocator_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_option_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_customer_lead_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/other_free_branch_response_model.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/model/response/update_deal_model_response.dart';
import 'package:epoint_deal_plugin/presentation/edit_deal/edit_deal_bloc.dart';
import 'package:epoint_deal_plugin/presentation/edit_deal/more_info_edit_deal.dart';
import 'package:epoint_deal_plugin/presentation/modal/journey_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_customer_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_potential_customer_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/pipeline_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/tag_modal.dart';
import 'package:epoint_deal_plugin/presentation/multi_staff_screen_potentail/ui/multi_staff_screen.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_date_picker.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_meni_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_size_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDealScreen extends StatefulWidget {
  final DetailDealData? detail;
  final OrderDetailResponseModel? model;
  final List<ProductNewModel>? productNewModels;
  final List<ServiceNewModel>? serviceNewModels;
  final List<OrderServiceCardModel>? serviceCardModels;
  final List<ServiceCardModel>? serviceCardActivatedModels;
  final CustomerModel? customerModel;
  final DeliveryAddress? deliveryAddressModel;
  final BookingDetailResponseModel? bookingModel;
  EditDealScreen(
      {Key? key,
      this.detail,
      this.model,
      this.productNewModels,
      this.serviceNewModels,
      this.serviceCardModels,
      this.serviceCardActivatedModels,
      this.customerModel,
      this.deliveryAddressModel,
      this.bookingModel})
      : super(key: key);

  @override
  _EditDealScreenState createState() => _EditDealScreenState();
}

class _EditDealScreenState extends State<EditDealScreen>
    with WidgetsBindingObserver {
  late EditDealBloc _bloc;
  var _isKeyboardVisible = false;

  ScrollController _controller = ScrollController();
  TextEditingController _dealNameText = TextEditingController();
  FocusNode _dealNameFocusNode = FocusNode();

  TextEditingController _phoneNumberText = TextEditingController();
  FocusNode _phoneNumberFocusNode = FocusNode();

  TextEditingController _closingDueDateText = TextEditingController();

  bool showMoreInfoDeal = true;
  bool showAdditionDeal = false;

  String tagsString = "";

  AddDealModelRequest requestModel = AddDealModelRequest();

  CustomerOptionData customerOptonData = CustomerOptionData();

  List<PipelineData>? pipeLineData = <PipelineData>[];
  PipelineData pipelineSelected = PipelineData();

  List<JourneyData>? journeysData = <JourneyData>[];
  JourneyData? journeySelected = JourneyData();

  List<AllocatorData> allocatorData = <AllocatorData>[];
  AllocatorData allocatorSelected = AllocatorData();

  List<OrderSourceData>? orderSources;
  OrderSourceData? orderSourceSelected;

  List<TagData>? tags;
  List<TagData> tagsSelected = <TagData>[];

  List<TagData>? tagsData;

  List<BranchData>? branchData;
  late BranchData branchSelected;

  bool selectedCustomer = false;

  List<WorkListStaffModel> _modelStaff = [];
  List<WorkListStaffModel>? _modelStaffSelected = [
    WorkListStaffModel(
        staffId: 0,
        staffName: "",
        staffAvatar: "",
        branchId: 0,
        departmentId: 0,
        isSelected: false)
  ];

  List<CustomerTypeModel> customerTypeData = [
    CustomerTypeModel(
        customerTypeName: AppLocalizations.text(LangKey.customerVi),
        customerTypeNameEn: AppLocalizations.text(LangKey.customer),
        customerTypeID: 1,
        selected: true),
    CustomerTypeModel(
        customerTypeName: AppLocalizations.text(LangKey.potentialCustomer),
        customerTypeNameEn: "lead",
        customerTypeID: 2,
        selected: false),
  ];

  DateTime? selectedClosingDueDate;

  List<CustomerData> listCustomer = <CustomerData>[];
  DealItems customerItem = DealItems(
      customerCode: "", customerName: "", typeCustomer: "", phone: "");

  List<ListCustomLeadItems> items = <ListCustomLeadItems>[];
  ListCustomLeadItems leadItem =
      ListCustomLeadItems(customerLeadCode: "", phone: "", customerType: "");

  CustomerTypeModel customerTypeSelected = CustomerTypeModel();

  List<Product> productUpdate = <Product>[];

  UpdateDealModelRequest detailDeal = UpdateDealModelRequest(
      dealCode: "",
      dealName: "",
      saleId: 0,
      typeCustomer: "",
      customerCode: "",
      phone: "",
      pipelineCode: "",
      journeyCode: "",
      closingDate: "",
      branchCode: "",
      tag: [],
      orderSourceId: 0,
      probability: 0,
      dealDescription: "",
      amount: 0,
      product: [],
      discount: 0);

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(() {});
    Globals.cart?.dispose();
    Globals.cart = null;
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() {
        _isKeyboardVisible = newValue;
      });
    }
    super.didChangeMetrics();
  }

  @override
  void initState() {
    super.initState();
    Globals.cart = GlobalCart();
    _bloc = EditDealBloc(
        context,
        widget.detail,
        widget.productNewModels,
        widget.serviceNewModels,
        widget.serviceCardModels,
        widget.serviceCardActivatedModels,
        widget.customerModel,
        widget.deliveryAddressModel);
    _bloc.detail = widget.detail;
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      _bloc.onRefresh();
      DealConnection.showLoading(context);
      var branchs = await DealConnection.getBranch(context);
      if (branchs != null) {
        branchData = branchs.data;
      }
      var pipelines = await DealConnection.getPipeline(context);
      if (pipelines != null) {
        pipeLineData = pipelines.data;
      }

      var tags = await DealConnection.getTag(context);
      if (tags != null) {
        tagsData = tags.data;
      }

      var response = await DealConnection.workListStaff(
          context, WorkListStaffRequestModel(manageProjectId: null));
      if (response != null) {
        _modelStaff = response.data ?? [];
      } else {
        _modelStaff = [];
      }

      bindingData();
    });
  }

  void bindingData() async {
    _bloc.onEditProducts();
    _dealNameText.text = widget.detail?.dealName ?? "";
    // detailDeal.dealName = widget.detail?.dealName ?? "";
    detailDeal.phone = widget.detail!.phone ?? "";
    detailDeal.dealDescription = widget.detail!.dealDescription ?? "";
    detailDeal.amount = widget.detail!.amount;
    detailDeal.probability = widget.detail!.probability ?? 0;
    detailDeal.dealCode = widget.detail!.dealCode ?? "";
    detailDeal.discount = widget.detail!.discount ?? 0;
    _bloc.expectRevenueText.text = widget.detail!.expectedRevenue.toString();

    // detailDeal.product = widget.detail.productBuy;

    if (widget.detail!.productBuy != null &&
        widget.detail!.productBuy!.length > 0) {
      detailDeal.product!.clear();
      widget.detail!.productBuy!.forEach((element) {
        detailDeal.product!.add(Product(
          objectCode: "",
          objectType: element.objectType,
          objectId: element.objectId,
          objectName: element.objectName,
          price: element.price,
          quantity: element.quantity!.toDouble(),
          amount: element.amount,
        ));
      });
    }
    Global.amount = (widget.detail!.amount ?? 0.0).toDouble();

    for (int i = 0; i < _modelStaff.length; i++) {
      if ((widget.detail?.saleId ?? 0) == _modelStaff[i].staffId) {
        _modelStaff[i].isSelected = true;
        // allocatorSelected = allocatorData[i];
        _modelStaffSelected = [
          WorkListStaffModel(
              staffId: _modelStaff[i].staffId,
              staffName: _modelStaff[i].staffName,
              staffAvatar: _modelStaff[i].staffAvatar,
              branchId: _modelStaff[i].branchId,
              departmentId: _modelStaff[i].departmentId,
              isSelected: _modelStaff[i].isSelected)
        ];
      } else {
        _modelStaff[i].isSelected = false;
      }
    }

    try {
      var item = _modelStaff.firstWhere(
          (element) => element.staffId == (widget.detail?.saleId ?? 0));
      if (item != null) {
        item.isSelected = true;
        detailDeal.saleId = _modelStaffSelected![0].staffId;
      }
    } catch (e) {}

    detailDeal.saleId = _modelStaffSelected![0].staffId;

    for (int i = 0; i < customerTypeData.length; i++) {
      if ((widget.detail?.typeCustomer ?? 0) ==
          customerTypeData[i].customerTypeNameEn) {
        customerTypeData[i].selected = true;

        customerTypeSelected = customerTypeData[i];
      } else {
        customerTypeData[i].selected = false;
      }
    }
    selectedCustomer =
        customerTypeSelected.customerTypeNameEn == "lead" ? false : true;
    detailDeal.typeCustomer =
        customerTypeSelected.customerTypeNameEn!.toLowerCase();

    if (customerTypeSelected.customerTypeNameEn == "customer") {
      selectedCustomer = true;
      customerItem = DealItems(
          customerCode: widget.detail?.customerCode,
          customerName: widget.detail?.customerName ?? "",
          phone: widget.detail?.phone ?? "");
      // leadItem = ListCustomLeadItems(customerLeadCode: "");
      _phoneNumberText.text = widget.detail?.phone ?? "";
      detailDeal.customerCode = customerItem.customerCode;
    } else {
      selectedCustomer = false;
      leadItem = ListCustomLeadItems(
          customerLeadCode: widget.detail?.customerCode,
          leadFullName: widget.detail?.customerName,
          customerType: widget.detail?.typeCustomer,
          phone: widget.detail?.phone);
      detailDeal.customerCode = leadItem.customerLeadCode;
    }

    for (int i = 0; i < pipeLineData!.length; i++) {
      if ((widget.detail?.pipelineCode ?? "").toLowerCase() ==
          pipeLineData![i].pipelineCode!.toLowerCase()) {
        pipeLineData![i].selected = true;
        pipelineSelected = pipeLineData![i];
      } else {
        pipeLineData![i].selected = false;
      }
    }

    detailDeal.pipelineCode = pipelineSelected.pipelineCode;

    var journeys = await DealConnection.getJourney(context,
        GetJourneyModelRequest(pipelineCode: [pipelineSelected.pipelineCode]));
    if (journeys != null) {
      journeysData = journeys.data;
    }

    for (int i = 0; i < journeysData!.length; i++) {
      if ((widget.detail!.journeyCode ?? "").toLowerCase() ==
          journeysData![i].journeyCode!.toLowerCase()) {
        journeysData![i].selected = true;
        journeySelected = journeysData![i];
      } else {
        journeysData![i].selected = false;
      }
    }
    detailDeal.journeyCode = journeySelected!.journeyCode;

    if (branchData != null && branchData!.length > 0) {
      // BranchData? result = branchData!.firstWhere(
      //     (element) => element.branchName == (widget.detail?.branchName ?? ""));
      // if (result != null) {
      //   result.selected = true;
      //   branchSelected = result;
      //   detailDeal.branchCode = branchSelected.branchCode;
      // }

      for (int i = 0; i < branchData!.length; i++) {
        if ((widget.detail!.branchName ?? "").toLowerCase() ==
            branchData![i].branchName!.toLowerCase()) {
          branchData![i].selected = true;
          branchSelected = branchData![i];
          detailDeal.branchCode = branchSelected.branchCode;
        } else {
          branchData![i].selected = false;
        }
      }
    }

    if (widget.detail!.tag!.length > 0 && tagsData != null) {
      List<int?> tagInt = [];
      for (var tag in tagsData!) {
        for (TagData tagSelected in widget.detail!.tag!) {
          if (tag.tagId == tagSelected.tagId) {
            tagInt.add(tag.tagId);
            tag.selected = true;
            tagsSelected?.add(tag);
          }
        }
      }
      for (int i = 0; i < tagsSelected.length; i++) {
        if (tagsString == "") {
          tagsString = tagsSelected[i].name ?? "";
        } else {
          tagsString += ", ${tagsSelected[i].name}";
        }
      }

      detailDeal.tag = tagInt;
    }

    orderSourceSelected = OrderSourceData(
        orderSourceName: widget.detail?.orderSourceName ?? "",
        orderSourceId: widget.detail!.orderSourceId ?? 0,
        selected: true);

    detailDeal.orderSourceId = orderSourceSelected!.orderSourceId;

    if (widget.detail!.closingDate != "") {
      selectedClosingDueDate =
          DateTime.parse(widget.detail!.closingDate! + ' 00:00:00.000');
      _closingDueDateText.text = DateFormat("dd/MM/yyyy")
          .format(DateTime.parse(widget.detail!.closingDate!));
    }

    Navigator.of(context).pop();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        keyboardDismissOnTap(context);
      },
      child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
            backgroundColor: AppColors.primaryColor,
            title: Text(
              AppLocalizations.text(LangKey.edit_deal)!,
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            // leadingWidth: 20.0,
          ),
          body: Container(
              decoration: const BoxDecoration(color: AppColors.white),
              child: _buildBody())),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
            child: CustomListView(
          padding:
              EdgeInsets.only(top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
          physics: const ClampingScrollPhysics(),
          controller: _controller,
          // separator: const Divider(),
          children: _listWidget(),
        )),
        Visibility(visible: !_isKeyboardVisible, child: _buildButton()),
        Container(
          height: 20.0,
        )
      ],
    );
  }

  List<Widget> _listWidget() {
    return [
      CustomSizeTransaction(
        open: true,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.text(LangKey.dealInfomation)!,
                style: TextStyle(
                    fontSize: AppTextSizes.size16,
                    color: const Color(0xFF0067AC),
                    fontWeight: FontWeight.normal),
              ),
              showMoreInfoDeal
                  ? InkWell(
                      onTap: () {
                        showMoreInfoDeal = !showMoreInfoDeal;
                        setState(() {});
                      },
                      child: Text(
                        AppLocalizations.text(LangKey.collapse)!,
                        style: TextStyle(
                            fontSize: AppTextSizes.size16,
                            color: const Color(0xFF0067AC),
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  : Container()
            ],
          ),
          Container(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  // detailPotential.customerType = "business";
                  customerTypeSelected = customerTypeData[1];
                  // customerSelected =
                  //     DealItems(customerCode: "", customerName: "");
                  // leadItem = ListCustomLeadItems(customerLeadCode: "");
                  // _dealNameText.text = "";
                  selectedCustomer = false;
                  setState(() {});
                },
                child: Container(
                  height: 42.0,
                  width: MediaQuery.of(context).size.width / 2 - 19,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: !selectedCustomer
                          ? AppColors.primaryColor
                          : Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      AppLocalizations.text(LangKey.potentialCustomer)!,
                      style: TextStyle(
                          color: !selectedCustomer
                              ? Colors.white
                              : Color(0xFF8E8E8E),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  // detailPotential.customerType = "personal";
                  customerTypeSelected = customerTypeData[0];
                  // customerItem =
                  //     DealItems(customerCode: "", customerName: "");
                  // leadItem = ListCustomLeadItems(customerLeadCode: "");
                  // _dealNameText.text = "";
                  selectedCustomer = true;
                  setState(() {});
                },
                child: Container(
                  height: 42.0,
                  width: AppSizes.maxWidth! / 2 - 19,
                  padding: EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      color: selectedCustomer
                          ? AppColors.primaryColor
                          : Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 2,
                          color: Colors.black.withOpacity(0.3),
                        )
                      ]),
                  child: Center(
                    child: Text(
                      AppLocalizations.text(LangKey.customerVi)!,
                      style: TextStyle(
                          color: selectedCustomer
                              ? Colors.white
                              : Color(0xFF8E8E8E),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
            ],
          ),

          Container(
            height: 15,
          ),

          // chọn khách hàng
          _buildTextField(
              AppLocalizations.text(LangKey.choose_customer),
              selectedCustomer
                  ? (customerItem?.customerName ?? "")
                  : (leadItem?.leadFullName ?? ""),
              Assets.iconPerson,
              true,
              true,
              false, ontap: () async {
            FocusScope.of(context).unfocus();

            if (customerTypeSelected.customerTypeNameEn ==
                AppLocalizations.text(LangKey.customer)) {
              CustomerData? customer =
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListCustomerModal(
                            listCustomer: listCustomer,
                            dealItem: customerItem,
                          )));

              if (customer != null) {
                customerItem.customerCode = customer.customerCode;
                customerItem.customerName = customer.fullName;
                customerItem.phone = customer.phone1;
                _phoneNumberText.text = customer.phone1!;
                detailDeal.customerCode = customer.customerCode;
                // _phoneNumberText.text = "";
                setState(() {});
              }
            } else if (customerTypeSelected.customerTypeNameEn == "lead") {
              ListCustomLeadItems? result =
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListCustomerPotentialModal(
                            items: items,
                            leadItem: leadItem,
                          )));

              if (result != null) {
                leadItem.customerLeadCode = result.customerLeadCode;
                leadItem.leadFullName = result.leadFullName;
                leadItem.customerType = result.customerType;
                leadItem.phone = result.phone;
                detailDeal.customerCode = result.customerLeadCode;

                setState(() {});
              }
            } else {
              DealConnection.showMyDialog(context,
                  AppLocalizations.text(LangKey.warningChooseCustomerType),
                  warning: true);
            }
          }),
          !selectedCustomer
              ? (leadItem.customerLeadCode != "")
                  ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.text(LangKey.customerStyle)! +
                                    ": ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                (leadItem.leadFullName != "")
                                    ? (leadItem.customerType!.toLowerCase() ==
                                            AppLocalizations.text(
                                                    LangKey.personal)!
                                                .toLowerCase())
                                        ? AppLocalizations.text(
                                            LangKey.personal)!
                                        : AppLocalizations.text(
                                            LangKey.business)!
                                    : "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.text(LangKey.phoneNumber)! +
                                    ": ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                leadItem.phone ?? "",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Container()
              : Container(),

          // phone
          selectedCustomer
              ? _buildTextField(
                  AppLocalizations.text(LangKey.inputPhonenumber),
                  "",
                  Assets.iconCall,
                  false,
                  false,
                  true,
                  fillText: _phoneNumberText,
                  focusNode: _phoneNumberFocusNode,
                  inputType: TextInputType.number,
                )
              : Container(),

// nhập tên deal
          _buildTextField(AppLocalizations.text(LangKey.inputDealName), "",
              Assets.iconDealName, true, false, true,
              fillText: _dealNameText,
              focusNode: _dealNameFocusNode,
              inputType: TextInputType.text),

          !showMoreInfoDeal
              ? InkWell(
                  onTap: () {
                    showMoreInfoDeal = !showMoreInfoDeal;
                    setState(() {});
                  },
                  child: Center(
                    child: Column(
                      children: [
                        Divider(),
                        Text(
                          AppLocalizations.text(LangKey.showMore)!,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: const Color(0xFF0067AC),
                              fontWeight: FontWeight.normal),
                        ),
                        Container(
                          height: 6.0,
                        ),
                        Image.asset(
                          Assets.iconDropDown,
                          width: 16.0,
                        )
                      ],
                    ),
                  ),
                )
              : Container(),
          CustomSizeTransaction(
            open: showMoreInfoDeal,
            child: Column(
              children: [
                // chọn pipeline
                showMoreInfoDeal
                    ? _buildTextField(
                        AppLocalizations.text(LangKey.choosePipeline),
                        pipelineSelected?.pipelineName ?? "",
                        Assets.iconChance,
                        true,
                        true,
                        false, ontap: () async {
                        FocusScope.of(context).unfocus();

                        if (pipeLineData == null || pipeLineData!.length == 0) {
                          DealConnection.showLoading(context);
                          var pipelines =
                              await DealConnection.getPipeline(context);
                          Navigator.of(context).pop();
                          if (pipelines != null) {
                            pipeLineData = pipelines.data;

                            PipelineData? pipeline = await showModalBottomSheet(
                                context: context,
                                useRootNavigator: true,
                                isScrollControlled: true,
                                backgroundColor: Colors.transparent,
                                builder: (context) {
                                  return PipelineModal(
                                    pipeLineData: pipeLineData,
                                  );
                                });
                            if (pipeline != null) {
                              if (pipelineSelected?.pipelineName !=
                                  pipeline.pipelineName) {
                                journeySelected = null;
                              }

                              pipelineSelected = pipeline;
                              detailDeal.pipelineCode =
                                  pipelineSelected.pipelineCode;
                              detailDeal.journeyCode = "";
                              DealConnection.showLoading(context);
                              var journeys = await DealConnection.getJourney(
                                  context,
                                  GetJourneyModelRequest(pipelineCode: [
                                    pipelineSelected.pipelineCode
                                  ]));
                              Navigator.of(context).pop();
                              if (journeys != null) {
                                journeysData = journeys.data;
                              }
                              setState(() {});
                            }
                          }
                        } else {
                          PipelineData? pipeline = await showModalBottomSheet(
                              context: context,
                              useRootNavigator: true,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return PipelineModal(
                                  pipeLineData: pipeLineData,
                                );
                              });
                          if (pipeline != null) {
                            if (pipelineSelected?.pipelineName !=
                                pipeline.pipelineName) {
                              journeySelected = null;
                            }

                            pipelineSelected = pipeline;
                            detailDeal.pipelineCode =
                                pipelineSelected.pipelineCode;
                            detailDeal.journeyCode = "";
                            DealConnection.showLoading(context);
                            var journeys = await DealConnection.getJourney(
                                context,
                                GetJourneyModelRequest(pipelineCode: [
                                  pipelineSelected.pipelineCode
                                ]));
                            Navigator.of(context).pop();
                            if (journeys != null) {
                              journeysData = journeys.data;
                            }
                            setState(() {});
                          }
                        }
                      })
                    : Container(),
                // chọn hành trình
                _buildTextField(
                    AppLocalizations.text(LangKey.chooseItinerary),
                    journeySelected?.journeyName ?? "",
                    Assets.iconItinerary,
                    true,
                    true,
                    false, ontap: () async {
                  print("Chọn hành trình");

                  FocusScope.of(context).unfocus();

                  JourneyData? journey = await showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return JourneyModal(
                          journeys: journeysData,
                        );
                      });
                  if (journey != null) {
                    journeySelected = journey;
                    detailDeal.journeyCode = journeySelected!.journeyCode;
                    setState(() {
                      // await LeadConnection.getDistrict(context, province.provinceid);
                    });
                  }
                }),

                // chọn người được phân bổ
                _buildTextField(
                    AppLocalizations.text(LangKey.chooseAllottedPerson),
                    (_modelStaffSelected != null)
                        ? _modelStaffSelected![0]?.staffName ?? ""
                        : "",
                    Assets.iconName,
                    true,
                    true,
                    false, ontap: () async {
                  FocusScope.of(context).unfocus();
                  print("Chọn người được phân bổ");

                  _modelStaffSelected =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultipleStaffScreenDeal(
                                models: _modelStaffSelected,
                              )));

                  if (_modelStaffSelected != null &&
                      _modelStaffSelected!.length > 0) {
                    print(_modelStaffSelected);

                    detailDeal.saleId = _modelStaffSelected![0].staffId;

                    setState(() {});
                  }
                }),
                // chọn ngày kết thúc thực tế
                Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    // width: (MediaQuery.of(context).size.width - 60) / 2 - 8,
                    child: _buildDatePicker(
                        AppLocalizations.text(LangKey.expectedEndingDate),
                        _closingDueDateText, () {
                      _showClosingDueDate();
                    })),

                _buildTextField(
                    AppLocalizations.text(LangKey.chooseCards) ?? "Chọn nhãn",
                    tagsString,
                    Assets.iconTag,
                    false,
                    true,
                    false, ontap: () async {
                  print("Tag");
                  FocusScope.of(context).unfocus();
                  if (tagsData == null || tagsData!.length == 0) {
                    DealConnection.showLoading(context);
                    var tags = await DealConnection.getTag(context);
                    Navigator.of(context).pop();
                    if (tags != null) {
                      List<int?> tagsSeletecd = [];
                      tagsData = tags.data;

                      var listTagsSelected = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  TagsModal(tagsData: tagsData)));

                      if (listTagsSelected != null) {
                        // widget.detailDeal.tag = [];
                        tagsString = "";
                        tagsData = listTagsSelected;

                        for (int i = 0; i < tagsData!.length; i++) {
                          if (tagsData![i].selected!) {
                            tagsSeletecd.add(tagsData![i].tagId);
                            if (tagsString == "") {
                              tagsString = tagsData![i].name ?? "";
                            } else {
                              tagsString += ", ${tagsData![i].name}";
                            }
                          }
                        }
                        detailDeal.tag = tagsSeletecd;
                        setState(() {});
                      }
                    }
                  } else {
                    var listTagsSelected = await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                TagsModal(tagsData: tagsData)));
                    if (listTagsSelected != null) {
                      List<int?> tagsSeletecd = [];
                      tagsString = "";
                      tagsData = listTagsSelected;

                      for (int i = 0; i < tagsData!.length; i++) {
                        if (tagsData![i].selected!) {
                          tagsSeletecd.add(tagsData![i].tagId);
                          if (tagsString == "") {
                            tagsString = tagsData![i].name ?? "";
                          } else {
                            tagsString += ", ${tagsData![i].name}";
                          }
                        }
                      }
                      detailDeal.tag = tagsSeletecd;
                      setState(() {});
                    }
                  }
                }),
              ],
            ),
          ),
          (branchData != null)
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: RichText(
                          text: TextSpan(
                              text: "Chi nhánh",
                              style: TextStyle(
                                  fontSize: AppTextSizes.size15,
                                  color: const Color(0xFF858080),
                                  fontWeight: FontWeight.normal),
                              children: [
                            TextSpan(
                                text: "*", style: TextStyle(color: Colors.red))
                          ])),
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

          MoreInfoEditDeal(
            detail: widget.detail,
            branchData: branchData,
            detailDeal: detailDeal,
            orderSourceSelected: orderSourceSelected,
            // tagsData: tagsData,
            tagsString: tagsString,
            bloc: _bloc,
          )
        ]),
      )
    ];
  }

  List<Widget> listBranch() {
    return List.generate(
        branchData!.length,
        (index) => buildItemBranch(
                branchData![index], branchData![index].selected!, () {
              selectedItem(index);
            }));
  }

  Widget buildItemBranch(
      BranchData? item, bool selected, GestureTapCallback ontap) {
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
                            : NetworkImage(item?.avatar ?? ""))
                        as ImageProvider<Object>,
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
    List<BranchData> models = branchData!;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;
    detailDeal!.branchCode = models[index].branchCode;
    setState(() {});
  }

  _showClosingDueDate() {
    DateTime selectedDate = selectedClosingDueDate ?? DateTime.now();

    showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        isDismissible: false,
        builder: (context) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.7,
            child: CustomMenuBottomSheet(
              title: AppLocalizations.text(LangKey.expectedEndingDate),
              widget: CustomDatePicker(
                minimumTime: selectedDate,
                initTime: selectedDate,
                maximumTime: DateTime(2025, 12, 31),
                dateOrder: DatePickerDateOrder.dmy,
                onChange: (DateTime date) {
                  selectedDate = date;
                },
              ),
              onTapConfirm: () {
                selectedClosingDueDate = selectedDate;
                _closingDueDateText.text = DateFormat("dd/MM/yyyy")
                    .format(selectedClosingDueDate!)
                    .toString();
                // widget.filterScreenModel.fromDate_created_at = selectedDate;

                Navigator.of(context).pop();
              },
              haveBnConfirm: true,
            ),
          );
        });
  }

  Widget _buildTextField(String? title, String? content, String icon,
      bool mandatory, bool dropdown, bool textfield,
      {GestureTapCallback? ontap,
      TextEditingController? fillText,
      FocusNode? focusNode,
      TextInputType? inputType}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: (ontap != null) ? ontap : null,
        child: TextField(
          enabled: textfield,
          readOnly: !textfield,
          controller: fillText,
          focusNode: focusNode,
          keyboardType: (inputType != null) ? inputType : TextInputType.text,
          decoration: InputDecoration(
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
                            fontSize: AppTextSizes.size15,
                            color: const Color(0xFF858080),
                            fontWeight: FontWeight.normal),
                        children: [
                        if (mandatory)
                          TextSpan(
                              text: "*", style: TextStyle(color: Colors.red))
                      ]))
                : Text(
                    content!,
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
                : null,
            suffixIconConstraints:
                BoxConstraints(maxHeight: 32.0, maxWidth: 32.0),
            isDense: true,
          ),
          onChanged: (event) {
            print(event.toLowerCase());
            if (fillText != null) {
              print(fillText.text);
            }
          },
        ),
      ),
    );
  }

  Widget _buildDatePicker(String? hintText, TextEditingController fillText,
      GestureTapCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: TextField(
        style: TextStyle(
          color: Colors.black,
        ),
        enabled: false,
        controller: fillText,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.all(12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          // hintText: hintText,
          label: RichText(
              text: TextSpan(
                  text: hintText,
                  style: TextStyle(
                      fontSize: AppTextSizes.size15,
                      color: const Color(0xFF858080),
                      fontWeight: FontWeight.normal),
                  children: [
                TextSpan(text: "*", style: TextStyle(color: Colors.red))
              ])),

          hintStyle: TextStyle(
              fontSize: 14.0,
              color: Color(0xFF8E8E8E),
              fontWeight: FontWeight.normal),
          isDense: true,
          suffixIcon: Padding(
            padding: EdgeInsets.all(8.0),
            child: Image.asset(
              Assets.iconDropDown,
            ),
          ),
          suffixIconConstraints:
              BoxConstraints(maxHeight: 32.0, maxWidth: 32.0),
        ),
        // },
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
      height: 40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () async {
          if (selectedCustomer) {
            await updateDealCustomer();
          } else {
            await updateDealLead();
          }
        },
        child: Center(
          child: Text(
            // AppLocalizations.text(LangKey.convertCustomers),
            AppLocalizations.text(LangKey.editDealTolowcase)!,
            style: TextStyle(
                fontSize: 14.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Future<void> updateDealCustomer() async {
    if (_phoneNumberText.text.isNotEmpty) {
      if ((!Validators().isValidPhone(_phoneNumberText.text.trim())) ||
          (!Validators().isNumber(_phoneNumberText.text.trim()))) {
        print("so dien thoai sai oy");
        DealConnection.showMyDialog(
            context, AppLocalizations.text(LangKey.phoneNumberNotCorrectFormat),
            warning: true);
        return;
      }
    }

    if (_dealNameText.text == "" ||
        detailDeal.pipelineCode == "" ||
        detailDeal.journeyCode == "" ||
        customerItem.customerCode == "" ||
        detailDeal.saleId == 0 ||
        selectedClosingDueDate == null ||
        detailDeal.branchCode == "") {
      DealConnection.showMyDialog(
          context, AppLocalizations.text(LangKey.warningChooseAllRequiredInfo),
          warning: true);
    } else {
      DealConnection.showLoading(context);

      if (_bloc.voucherModel != null) {
        if (_bloc.voucherModel!.amount != null) {
          _bloc.discountType = discountTypeCash;
          _bloc.discountValue = _bloc.voucherModel!.amount;
        } else if (_bloc.voucherModel!.percent != null) {
          _bloc.discountType = discountTypePercent;
          _bloc.discountValue = _bloc.voucherModel!.percent!.toDouble();
        } else {
          _bloc.discountType = discountTypeCode;
          _bloc.discountValue = _bloc.voucherModel!.model!.discount;
        }
      }
      UpdateDealModelResponse? result = await DealConnection.updateDeal(
          context,
          UpdateDealModelRequest(
            dealCode: detailDeal.dealCode,
            dealId: _bloc.detail?.dealId,
            dealName: _dealNameText.text,
            saleId: detailDeal.saleId,
            typeCustomer: "customer",
            customerCode: customerItem.customerCode,
            phone: _phoneNumberText.text,
            pipelineCode: detailDeal.pipelineCode,
            journeyCode: detailDeal.journeyCode,
            closingDate:
                "${DateFormat("yyyy-MM-dd").format(selectedClosingDueDate!)}",
            // closingDate: "",
            branchCode: detailDeal.branchCode,
            tag: detailDeal.tag,
            orderSourceId: detailDeal.orderSourceId,
            probability: detailDeal.probability,
            dealDescription: detailDeal.dealDescription,
            expectedRevenue: parseMoney(_bloc.expectRevenueText.text),
            amount: _bloc.amount,
            product: _bloc.getListProductsRequest(),
            otherFee: _bloc.surchargeModels
                .where((element) =>
                    element.isSelected && element.controller.text.isNotEmpty)
                .toList()
                .map((e) {
              double value = e.isMoney
                  ? parseMoney(e.controller.text)
                  : (int.tryParse(e.controller.text) ?? 0).toDouble();
              double totalValue = e.isMoney ? value : value / 100 * _bloc.total;
              return OrderFeeModel(
                  otherFeeId: e.otherFeeId,
                  otherFeeCode: e.otherFeeCode,
                  otherFeeName: e.otherFeeName,
                  otherFeeValue: value,
                  feeType: e.isMoney
                      ? otherFreeBranchTypeMoney
                      : otherFreeBranchTypePercent,
                  feeMoney: totalValue);
            }).toList(),
            total: _bloc.total,
            totalOtherFee: _bloc.surcharge,
            vatValue: _bloc.vatModel?.id,
            vatDeal: _bloc.vatModel == null
                ? _bloc.vatDefault
                : _bloc.vatModel?.data,
            amountBeforeVat: _bloc.amountBeforeTax,
            discount: _bloc.discount,
            discountMember: _bloc.discountMember,
            discountType: _bloc.discountType,
            discountValue: _bloc.discountValue,
          ));
      Navigator.of(context).pop();
      if (result != null) {
        if (result.errorCode == 0) {
          await DealConnection.showMyDialog(context, result.errorDescription);
          Navigator.of(context).pop(true);
        } else {
          DealConnection.showMyDialog(context, result.errorDescription);
        }
      }
    }
  }

  Future<void> updateDealLead() async {
    if (_dealNameText.text == "" ||
        detailDeal.pipelineCode == "" ||
        detailDeal.journeyCode == "" ||
        leadItem.customerLeadCode == "" ||
        detailDeal.saleId == 0 ||
        selectedClosingDueDate == null ||
        detailDeal.branchCode == "") {
      DealConnection.showMyDialog(
          context, AppLocalizations.text(LangKey.warningChooseAllRequiredInfo),
          warning: true);
    } else {
      DealConnection.showLoading(context);
      if (_bloc.voucherModel != null) {
        if (_bloc.voucherModel!.amount != null) {
          _bloc.discountType = discountTypeCash;
          _bloc.discountValue = _bloc.voucherModel!.amount;
        } else if (_bloc.voucherModel!.percent != null) {
          _bloc.discountType = discountTypePercent;
          _bloc.discountValue = _bloc.voucherModel!.percent!.toDouble();
        } else {
          _bloc.discountType = discountTypeCode;
          _bloc.discountValue = _bloc.voucherModel!.model!.discount;
        }
      }
      UpdateDealModelResponse? result = await DealConnection.updateDeal(
          context,
          UpdateDealModelRequest(
              dealCode: detailDeal.dealCode,
              dealId: _bloc.detail?.dealId,
              dealName: _dealNameText.text,
              saleId: detailDeal.saleId,
              typeCustomer: "lead",
              customerCode: leadItem.customerLeadCode,
              phone: leadItem.phone,
              pipelineCode: detailDeal.pipelineCode,
              journeyCode: detailDeal.journeyCode,
              closingDate:
                  "${DateFormat("yyyy-MM-dd").format(selectedClosingDueDate!)}",
              branchCode: detailDeal.branchCode,
              tag: detailDeal.tag,
              orderSourceId: detailDeal.orderSourceId,
              probability: detailDeal.probability,
              dealDescription: detailDeal.dealDescription,
              expectedRevenue: parseMoney(_bloc.expectRevenueText.text),
              amount: _bloc.amount,
              product: _bloc.getListProductsRequest(),
              otherFee: _bloc.surchargeModels
                  .where((element) =>
                      element.isSelected && element.controller.text.isNotEmpty)
                  .toList()
                  .map((e) {
                double value = e.isMoney
                    ? parseMoney(e.controller.text)
                    : (int.tryParse(e.controller.text) ?? 0).toDouble();
                double totalValue =
                    e.isMoney ? value : value / 100 * _bloc.total;
                return OrderFeeModel(
                    otherFeeId: e.otherFeeId,
                    otherFeeCode: e.otherFeeCode,
                    otherFeeName: e.otherFeeName,
                    otherFeeValue: value,
                    feeType: e.isMoney
                        ? otherFreeBranchTypeMoney
                        : otherFreeBranchTypePercent,
                    feeMoney: totalValue);
              }).toList(),
              total: _bloc.total,
              totalOtherFee: _bloc.surcharge,
              vatValue: _bloc.vatModel?.id,
              vatDeal: _bloc.vatModel == null
                  ? _bloc.vatDefault
                  : _bloc.vatModel?.data,
              amountBeforeVat: _bloc.amountBeforeTax,
              discount: _bloc.discount,
              discountMember: _bloc.discountMember,
              discountType: _bloc.discountType,
              discountValue: _bloc.discountValue));
      Navigator.of(context).pop();
      if (result != null) {
        if (result.errorCode == 0) {
          print(result.errorDescription);
          await DealConnection.showMyDialog(context, result.errorDescription);
          Navigator.of(context).pop(true);
        } else {
          DealConnection.showMyDialog(context, result.errorDescription);
        }
      }
    }
  }
}
