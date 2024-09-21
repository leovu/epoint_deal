import 'dart:math';

import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/customer_type.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/get_journey_model_request.dart';
import 'package:epoint_deal_plugin/model/request/get_list_staff_request_model.dart';
import 'package:epoint_deal_plugin/model/request/update_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/add_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_lead_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_allocator_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_option_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_customer_lead_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/other_free_branch_response_model.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/create_deal_bloc.dart';
import 'package:epoint_deal_plugin/presentation/create_deal_from_lead/more_info_create_deal_from_lead.dart';
import 'package:epoint_deal_plugin/presentation/modal/journey_modal.dart';
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

class CreateDealFromLeadScreen extends StatefulWidget {
  final Map<String, dynamic>? jsonDetailLead;
  CreateDealFromLeadScreen({Key? key, this.jsonDetailLead}) : super(key: key);

  @override
  _CreateDealFromLeadScreenState createState() =>
      _CreateDealFromLeadScreenState();
}

class _CreateDealFromLeadScreenState extends State<CreateDealFromLeadScreen>
    with WidgetsBindingObserver {
  late CreateDealBloc _bloc;
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
  BranchData? branchSelected;

  bool selectedCustomer = false;

  List<WorkListStaffModel> _modelStaff = [];
  List<WorkListStaffModel> _modelStaffSelected = [
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

  DetailPotentialData? detailLead;

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
      product: []);

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
    Globals.cart = GlobalCart();
    _bloc = CreateDealBloc(context);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DealConnection.showLoading(context);
      _bloc.onRefresh(isRefresh: false, isInit: true);
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
    detailLead = DetailPotentialData.fromJson(widget.jsonDetailLead!);
    detailDeal.phone = detailLead!.phone ?? "";
   _dealNameText.text = "Deal của ${detailLead?.fullName ?? ""}";
    for (int i = 0; i < _modelStaff.length; i++) {
      if ((detailLead?.saleId ?? 0) == _modelStaff[i].staffId) {
        _modelStaff[i].isSelected = true;
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
          (element) => element.staffId == (detailLead?.saleId ?? 0));
        item.isSelected = true;
        detailDeal.saleId = _modelStaffSelected[0].staffId;
    } catch (e) {}

    detailDeal.saleId = _modelStaffSelected[0].staffId;
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
              AppLocalizations.text(LangKey.creatDeal)!,
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
            ),
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
              Container(
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
              Container(
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
                        color:
                            selectedCustomer ? Colors.white : Color(0xFF8E8E8E),
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
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
              detailLead?.fullName ?? "N/A",
              Assets.iconPerson,
              false,
              false,
              false),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 15.0),
                child: Row(
                  children: [
                    Text(
                      AppLocalizations.text(LangKey.customerStyle)! + ": ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      (detailLead?.customerType != null && detailLead?.customerType != "")
                          ? (detailLead!.customerType!.toLowerCase() == "personal")
                              ? AppLocalizations.text(LangKey.personal)!
                              : AppLocalizations.text(LangKey.business)!
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
                      AppLocalizations.text(LangKey.phoneNumber)! + ": ",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(
                      detailDeal.phone ?? "N/A",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ],
          ),

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
                        ? _modelStaffSelected[0]?.staffName ?? ""
                        : "",
                    Assets.iconName,
                    true,
                    true,
                    false, ontap: () async {
                  FocusScope.of(context).unfocus();
                  print("Chọn người được phân bổ");

                  List<WorkListStaffModel>? result =
                      await Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultipleStaffScreenDeal(
                                models: _modelStaffSelected,
                              )));

                  if (result != null && result.length > 0) {
                    print(_modelStaffSelected);
                    _modelStaffSelected = result;
                    detailDeal.saleId = _modelStaffSelected[0].staffId;

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

          MoreInfoCreateDealFromLead(
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

  Widget _buildDatePicker(
      String? hintText, TextEditingController fillText, GestureTapCallback ontap) {
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
            await addDealLead();
        },
        child: Center(
          child: Text(
            // AppLocalizations.text(LangKey.convertCustomers),
            AppLocalizations.text(LangKey.creatDeal)!,
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

  Future<void> addDealLead() async {
    if (_dealNameText.text == "" ||
        detailDeal.pipelineCode == "" ||
        detailDeal.journeyCode == "" ||
        detailDeal.saleId == 0 ||
        selectedClosingDueDate == null) {
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
      AddDealModelResponse? result = await DealConnection.addDeal(
          context,
          AddDealModelRequest(
              dealName: _dealNameText.text,
              saleId: detailDeal.saleId,
              typeCustomer: "lead",
              customerCode: detailLead!.customerLeadCode,
              phone: detailDeal.phone,
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
              discountMember: _bloc.discountMember,
              discountType: _bloc.discountType,
              discountValue: _bloc.discountValue,
              discount: _bloc.discount));
      Navigator.of(context).pop();
      if (result != null) {
        if (result.errorCode == 0) {
          print(result.errorDescription);
          await DealConnection.showMyDialog(context, result.errorDescription);
          print("return true rồi` nè");
          Navigator.of(context).pop(true);
        } else {
          DealConnection.showMyDialog(context, result.errorDescription);
        }
      }
    }
  }
}
