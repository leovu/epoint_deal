
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/customer_type.dart';
import 'package:epoint_deal_plugin/model/object_pop_create_deal_model.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/get_journey_model_request.dart';
import 'package:epoint_deal_plugin/model/response/add_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_allocator_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_option_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_customer_lead_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/more_info_creat_deal.dart';
import 'package:epoint_deal_plugin/presentation/modal/journey_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_customer_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_potential_customer_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/pipeline_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/tag_modal.dart';
import 'package:epoint_deal_plugin/presentation/pick_one_staff_screen/ui/pick_one_staff_screen.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_date_picker.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_meni_bottom_sheet.dart';
import 'package:epoint_deal_plugin/widget/custom_size_transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateDealScreen extends StatefulWidget {
  const CreateDealScreen({Key key}) : super(key: key);

  @override
  _CreateDealScreenState createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;

  ScrollController _controller = ScrollController();
  TextEditingController _dealNameText = TextEditingController();
  FocusNode _dealNameFocusNode = FocusNode();

  TextEditingController _phoneNumberText = TextEditingController();
  FocusNode _phoneNumberFocusNode = FocusNode();

  TextEditingController _closingDueDateText = TextEditingController();

  bool showMoreInfoDeal = true;
  bool showAdditionDeal = false;

  AddDealModelRequest requestModel = AddDealModelRequest();

  CustomerOptionData customerOptonData = CustomerOptionData();

  List<PipelineData> pipeLineData = <PipelineData>[];
  PipelineData pipelineSelected = PipelineData();

  List<JourneyData> journeysData = <JourneyData>[];
  JourneyData journeySelected = JourneyData();

  List<AllocatorData> allocatorData = <AllocatorData>[];
  // AllocatorData allocatorSelected = AllocatorData(staffId: 0,fullName: "",selected: false);

  List<OrderSourceData> orderSources;
  OrderSourceData orderSourceSelected;

  List<TagData> tags;
  List<TagData> tagsSelected;

  List<BranchData> branchData;
  BranchData branchSelected;

  List<CustomerTypeModel> customerTypeData = [
    CustomerTypeModel(
        customerTypeName: AppLocalizations.text(LangKey.customerVi),
        customerTypeNameEn: AppLocalizations.text(LangKey.customer),
        customerTypeID: 1,
        selected: false),
    CustomerTypeModel(
        customerTypeName: AppLocalizations.text(LangKey.potentialCustomer),
        customerTypeNameEn: "lead",
        customerTypeID: 2,
        selected: true),
  ];

  List<WorkListStaffModel> _modelStaffSelected = [];

  DateTime selectedClosingDueDate;

  List<CustomerData> listCustomer = <CustomerData>[];
  DealItems customerSelected = DealItems(customerCode: "", customerName: "", phone: "");

  List<ListCustomLeadItems> items = <ListCustomLeadItems>[];
  ListCustomLeadItems leadItem = ListCustomLeadItems(customerLeadCode: "",phone: "", customerType: "");

  CustomerTypeModel customerTypeSelected = CustomerTypeModel(
      customerTypeName: AppLocalizations.text(LangKey.potentialCustomer),
      customerTypeNameEn: "lead",
      customerTypeID: 2,
      selected: true);

  ObjectPopCreateDealModel modelResponse = ObjectPopCreateDealModel();

  AddDealModelRequest detailDeal = AddDealModelRequest(
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
      product: <Product>[]);

  bool selectedCustomer = false;
  List<TagData> tagsData;

  String tagsString = "";

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.removeListener(() {});
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
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DealConnection.showLoading(context);
      var branchs = await DealConnection.getBranch(context);
      if (branchs != null) {
        branchData = branchs.data;
      }
      var pipelines = await DealConnection.getPipeline(context);
      if (pipelines != null) {
        pipeLineData = pipelines.data;
        pipelineSelected = pipeLineData[0];
        detailDeal.pipelineCode = pipelineSelected.pipelineCode;
      }
      var journeys = await DealConnection.getJourney(
          context,
          GetJourneyModelRequest(
              pipelineCode: [pipelineSelected.pipelineCode]));
      if (journeys != null) {
        journeysData = journeys.data;

        journeySelected = journeysData[0];
        detailDeal.journeyCode = journeySelected.journeyCode;
      }

      GlobalCart.shared.clearCart();
      Navigator.of(context).pop();
      setState(() {});
    });
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
              AppLocalizations.text(LangKey.creatDeal),
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
                AppLocalizations.text(LangKey.dealInfomation),
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
                        AppLocalizations.text(LangKey.collapse),
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
                  FocusScope.of(context).unfocus();
                  if (!selectedCustomer) {
                    return;
                  }
                  // detailPotential.customerType = "business";
                  customerTypeSelected = customerTypeData[1];
                  // customerSelected =
                  //     DealItems(customerCode: "", customerName: "");
                  // leadItem = ListCustomLeadItems(customerLeadCode: "");
                  _dealNameText.text = "";
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
                      AppLocalizations.text(LangKey.potentialCustomer),
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
                  FocusScope.of(context).unfocus();
                  if (selectedCustomer) {
                    return;
                  }
                  // detailPotential.customerType = "personal";
                  customerTypeSelected = customerTypeData[0];
                  _dealNameText.text = "";
                  // customerSelected = DealItems(customerCode: "", customerName: "");
                  // leadItem = ListCustomLeadItems(customerLeadCode: "");
                  selectedCustomer = true;
                  setState(() {});
                },
                child: Container(
                  height: 42.0,
                  width: AppSizes.maxWidth / 2 - 19,
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
                      AppLocalizations.text(LangKey.customerVi),
                      style: TextStyle(
                          color: selectedCustomer
                              ? Colors.white
                              : Color(0xFF8E8E8E),
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              )
            ],
          ),

          SizedBox(
            height: 15.0,
          ),

// chọn khách hàng
          _buildTextField(
              AppLocalizations.text(LangKey.choose_customer),
              selectedCustomer ? (customerSelected?.customerName ?? "") : (leadItem?.leadFullName ?? ""),
              Assets.iconPerson,
              true,
              true,
              false, ontap: () async {
            FocusScope.of(context).unfocus();

            if (customerTypeSelected.customerTypeNameEn ==
                AppLocalizations.text(LangKey.customer)) {
              CustomerData customer =
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListCustomerModal(
                            listCustomer: listCustomer,
                            dealItem: customerSelected,
                          )));

              if (customer != null) {
                customerSelected.customerCode = customer.customerCode;
                customerSelected.customerName = customer.fullName;
                customerSelected.phone = customer.phone1;
                _phoneNumberText.text = customer.phone1;


                // detailDeal.customerCode = customerSelected.customerCode;
                // detailDeal.phone = _phoneNumberText.text;
                // _dealNameText.text =
                //     "${AppLocalizations.text(LangKey.dealOf)} ${customer?.fullName ?? ""}";

                setState(() {});
              }
            } else if (customerTypeSelected.customerTypeNameEn == "lead") {
              ListCustomLeadItems result =
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ListCustomerPotentialModal(
                            items: items,
                            leadItem: leadItem,
                          )));

              if (result != null) {
                // _phoneNumberText.text = "";
                // customerSelected.customerCode = result.customerLeadCode;
                // customerSelected.customerName = result.leadFullName;
                // customerSelected.phone = result.phone;
                // customerSelected.typeCustomer = result.customerType;

                leadItem.customerLeadCode = result.customerLeadCode;
                leadItem.customerType = result.customerType;
                leadItem.phone = result.phone;
                leadItem.leadFullName = result.leadFullName;

                // detailDeal.phone = result.phone;
                // detailDeal.typeCustomer = result.customerType;
                // detailDeal.customerCode = customerSelected.customerCode;

                setState(() {});
              }
            } else {
              DealConnection.showMyDialog(context,
                  AppLocalizations.text(LangKey.warningChooseCustomerType),
                  warning: true);
            }
          }),

          (!selectedCustomer && leadItem != null)
              ? (leadItem.customerLeadCode != "")
                  ? Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              Text(
                                AppLocalizations.text(LangKey.customerStyle) + ": ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                             (leadItem.customerType != "") ? (leadItem.customerType.toLowerCase() == AppLocalizations.text(LangKey.personal).toLowerCase() ) ?
                                AppLocalizations.text(LangKey.personal) : AppLocalizations.text(LangKey.business) : "",
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
                                AppLocalizations.text(LangKey.phoneNumber) +": ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                leadItem.phone ?? "N/A",
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
              ? _buildTextField(AppLocalizations.text(LangKey.inputPhonenumber),
                  "", Assets.iconCall, false, false, true,
                  fillText: _phoneNumberText,
                  focusNode: _phoneNumberFocusNode,
                  inputType: TextInputType.number)
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
                          AppLocalizations.text(LangKey.showMore),
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
                // showMoreInfoDeal ?
                _buildTextField(
                    AppLocalizations.text(LangKey.choosePipeline),
                    pipelineSelected?.pipelineName ?? "",
                    Assets.iconChance,
                    true,
                    true,
                    false, ontap: () async {
                  FocusScope.of(context).unfocus();
                  PipelineData pipeline = await showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return PipelineModal(
                            pipeLineData: pipeLineData,
                            pipelineSelected: pipelineSelected);
                      });
                  if (pipeline != null) {
                    if (pipelineSelected?.pipelineName !=
                        pipeline.pipelineName) {
                      journeySelected = null;
                    }

                    pipelineSelected = pipeline;
                    detailDeal.pipelineCode = pipelineSelected.pipelineCode;
                    DealConnection.showLoading(context);
                    var journeys = await DealConnection.getJourney(
                        context,
                        GetJourneyModelRequest(
                            pipelineCode: [pipelineSelected.pipelineCode]));
                    Navigator.of(context).pop();
                    if (journeys != null) {
                      journeysData = journeys.data;
                    }
                    setState(() {});
                  }
                }),
                _buildTextField(
                    AppLocalizations.text(LangKey.chooseItinerary),
                    journeySelected?.journeyName ?? "",
                    Assets.iconItinerary,
                    true,
                    true,
                    false, ontap: () async {
                  print("Chọn hành trình");

                  FocusScope.of(context).unfocus();

                  JourneyData journey = await showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return JourneyModal(
                            journeys: journeysData,
                            journeySelected: journeySelected);
                      });
                  if (journey != null) {
                    journeySelected = journey;
                    detailDeal.journeyCode = journeySelected.journeyCode;
                    setState(() {
                      // await DealConnection.getDistrict(context, province.provinceid);
                    });
                  }
                })
                // : Container()
                ,

                // chọn người được phân bổ

                // showMoreInfoDeal ?
                _buildTextField(
                    AppLocalizations.text(LangKey.chooseAllottedPerson),
                    (_modelStaffSelected.length > 0 &&
                            _modelStaffSelected != null)
                        ? _modelStaffSelected[0]?.staffName ?? ""
                        : "",
                    Assets.iconName,
                    true,
                    true,
                    false, ontap: () async {
                  FocusScope.of(context).unfocus();
                  print("Chọn người được phân bổ");

                  _modelStaffSelected =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => PickOneStaffScreen(
                                models: _modelStaffSelected,
                              )));

                  if (_modelStaffSelected != null &&
                      _modelStaffSelected.length > 0) {
                    detailDeal.saleId = _modelStaffSelected[0].staffId;
                    print(_modelStaffSelected);
                    setState(() {});
                  }
                }),

// chọn ngày kết thúc thực tế
                showMoreInfoDeal ?
                Container(
                    margin: const EdgeInsets.only(bottom: 10.0),
                    child: _buildDatePicker(
                        AppLocalizations.text(LangKey.expectedEndingDate),
                        _closingDueDateText, () {
                          FocusScope.of(context).unfocus();
                      _showClosingDueDate();
                    }))
                : Container(),
                

                _buildTextField(
                    AppLocalizations.text(LangKey.chooseCards),
                    tagsString,
                    Assets.iconTag,
                    false,
                    true,
                    false, ontap: () async {
                  print("Tag");
                  FocusScope.of(context).unfocus();
                  if (tagsData == null || tagsData.length == 0) {
                    DealConnection.showLoading(context);
                    var tags = await DealConnection.getTag(context);
                    Navigator.of(context).pop();
                    if (tags != null) {
                      tagsData = tags.data;

                      var listTagsSelected = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  TagsModal(tagsData: tagsData)));

                      if (listTagsSelected != null) {
                        List<int> tagsSeletecd = [];
                        tagsString = "";
                        tagsData = listTagsSelected;

                        for (int i = 0; i < tagsData.length; i++) {
                          if (tagsData[i].selected) {
                            tagsSeletecd.add(tagsData[i].tagId);
                            if (tagsString == "") {
                              tagsString = tagsData[i].name;
                            } else {
                              tagsString += ", ${tagsData[i].name}";
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
                      List<int> tagsSeletecd = [];
                      tagsString = "";
                      tagsData = listTagsSelected;

                      for (int i = 0; i < tagsData.length; i++) {
                        if (tagsData[i].selected) {
                          tagsSeletecd.add(tagsData[i].tagId);
                          if (tagsString == "") {
                            tagsString = tagsData[i].name;
                          } else {
                            tagsString += ", ${tagsData[i].name}";
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

          MoreInfoCreatDeal( 
            branchData: branchData,
            detailDeal: detailDeal,
          )
        ]),
      )
    ];
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
                minimumTime: DateTime(DateTime.now().year, DateTime.now().month,
                    DateTime.now().day, 0, 0, 0),
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
                    .format(selectedClosingDueDate)
                    .toString();
                // widget.filterScreenModel.fromDate_created_at = selectedDate;

                Navigator.of(context).pop();
              },
              haveBnConfirm: true,
            ),
          );
        });
  }

  Widget _buildTextField(String title, String content, String icon,
      bool mandatory, bool dropdown, bool textfield,
      {Function ontap,
      TextEditingController fillText,
      FocusNode focusNode,
      TextInputType inputType}) {
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

  Widget _buildDatePicker(
      String hintText, TextEditingController fillText, Function ontap) {
    return InkWell(
      onTap: ontap,
      child: TextField(
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
            await addDealCustomer();
          } else {
            await addDealLead();
          }
          print("Okie call api add");
          // }
        },
        child: Center(
          child: Text(
            // AppLocalizations.text(LangKey.convertCustomers),
            AppLocalizations.text(LangKey.creatDeal),
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

  Future<void> addDealCustomer() async {
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
        customerSelected.customerCode == "" ||
        detailDeal.saleId == 0 ||
        selectedClosingDueDate == null) {
      DealConnection.showMyDialog(
          context, AppLocalizations.text(LangKey.warningChooseAllRequiredInfo),
          warning: true);
    } else {
      DealConnection.showLoading(context);

      // double amount = 0;
      // if (detailDeal.product.length > 0) {
      //   for (int i = 0; i < detailDeal.product.length; i++) {
      //     amount +=
      //         detailDeal.product[i].amount * detailDeal.product[i].quantity;
      //   }
      // }

      AddDealModelResponse result = await DealConnection.addDeal(
          context,
          AddDealModelRequest(
              dealName: _dealNameText.text,
              saleId: detailDeal.saleId,
              typeCustomer: "customer",
              customerCode: customerSelected.customerCode,
              phone: _phoneNumberText.text,
              pipelineCode: detailDeal.pipelineCode,
              journeyCode: detailDeal.journeyCode,
              closingDate:
                  "${DateFormat("yyyy-MM-dd").format(selectedClosingDueDate)}",
              // closingDate: "",
              branchCode: detailDeal.branchCode,
              tag: detailDeal.tag,
              orderSourceId: detailDeal.orderSourceId,
              probability: detailDeal.probability,
              dealDescription: detailDeal.dealDescription,
              amount: Global.amount,
              product: detailDeal.product,
              discount: Global.discount));
      Navigator.of(context).pop();
      if (result != null) {
        if (result.errorCode == 0) {
          GlobalCart.shared.clearCart;
          Global.amount = 0.0;
          print(result.errorDescription);
          await DealConnection.showMyDialog(context, result.errorDescription);
          if (result.data != null) {
            modelResponse = ObjectPopCreateDealModel(
                deal_id: result.data.dealId, status: true);
          }
          Navigator.of(context).pop(modelResponse.toJson());
        } else {
          DealConnection.showMyDialog(context, result.errorDescription);
        }
      }
    }
  }

    Future<void> addDealLead() async {

    if (_dealNameText.text == "" ||
        detailDeal.pipelineCode == "" ||
        detailDeal.journeyCode == "" ||
        leadItem.customerLeadCode == "" ||
        detailDeal.saleId == 0 ||
        selectedClosingDueDate == null) {
      DealConnection.showMyDialog(
          context, AppLocalizations.text(LangKey.warningChooseAllRequiredInfo),
          warning: true);
    } else {
      DealConnection.showLoading(context);

      // double amount = 0;
      // if (detailDeal.product.length > 0) {
      //   for (int i = 0; i < detailDeal.product.length; i++) {
      //     amount +=
      //         detailDeal.product[i].amount * detailDeal.product[i].quantity;
      //   }
      // }

      AddDealModelResponse result = await DealConnection.addDeal(
          context,
          AddDealModelRequest(
              dealName: _dealNameText.text,
              saleId: detailDeal.saleId,
              typeCustomer: "lead",
              customerCode: leadItem.customerLeadCode,
              phone: leadItem.phone ?? "",
              pipelineCode: detailDeal.pipelineCode,
              journeyCode: detailDeal.journeyCode,
              closingDate:
                  "${DateFormat("yyyy-MM-dd").format(selectedClosingDueDate)}",
              // closingDate: "",
              branchCode: detailDeal.branchCode,
              tag: detailDeal.tag,
              orderSourceId: detailDeal.orderSourceId,
              probability: detailDeal.probability,
              dealDescription: detailDeal.dealDescription,
              amount: Global.amount,
              product: detailDeal.product,
              discount: Global.discount));
      Navigator.of(context).pop();
      if (result != null) {
        if (result.errorCode == 0) {
          print(result.errorDescription);

          GlobalCart.shared.clearCart;
          Global.amount = 0.0;
          await DealConnection.showMyDialog(context, result.errorDescription);
          if (result.data != null) {
            modelResponse = ObjectPopCreateDealModel(
                deal_id: result.data.dealId, status: true);
          }
          Navigator.of(context).pop(modelResponse.toJson());
        } else {
          DealConnection.showMyDialog(context, result.errorDescription);
        }
      }
    }
  }
}
