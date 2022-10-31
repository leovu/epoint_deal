import 'dart:ffi';

import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/customer_type.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/update_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/add_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_allocator_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_option_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_customer_lead_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/model/response/update_deal_model_response.dart';
import 'package:epoint_deal_plugin/presentation/edit_deal/more_info_eidt_deal.dart';
import 'package:epoint_deal_plugin/presentation/modal/allocator_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/customer_type_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/journey_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_customer_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/list_potential_customer_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/pipeline_modal.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_date_picker.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_meni_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EditDealScreen extends StatefulWidget {
  DetailDealData detail;
  EditDealScreen({Key key, this.detail}) : super(key: key);

  @override
  _EditDealScreenState createState() => _EditDealScreenState();
}

class _EditDealScreenState extends State<EditDealScreen>
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

  String tagsString = "";

  AddDealModelRequest requestModel = AddDealModelRequest();

  CustomerOptionData customerOptonData = CustomerOptionData();

  List<PipelineData> pipeLineData = <PipelineData>[];
  PipelineData pipelineSelected = PipelineData();

  List<JourneyData> journeysData = <JourneyData>[];
  JourneyData journeySelected = JourneyData();

  List<AllocatorData> allocatorData = <AllocatorData>[];
  AllocatorData allocatorSelected = AllocatorData();

  List<OrderSourceData> orderSources;
  OrderSourceData orderSourceSelected;

  List<TagData> tags;
  List<TagData> tagsSelected = <TagData>[];

  List<TagData> tagsData;

  List<BranchData> branchData;
  BranchData branchSelected;

  List<CustomerTypeModel> customerTypeData = [
    CustomerTypeModel(
        // customerTypeName: AppLocalizations.text(LangKey.personal),
        customerTypeName: "Khách hàng",
        customerTypeNameEn: "customer",
        customerTypeID: 1,
        selected: false),
    CustomerTypeModel(
        customerTypeName: "Khách hàng tiềm năng",
        customerTypeNameEn: "lead",
        customerTypeID: 2,
        selected: false),
  ];

  DateTime selectedClosingDueDate;

  List<CustomerData> listCustomer = <CustomerData>[];
  DealItems customerSelected = DealItems();

  List<ListCustomLeadItems> items = <ListCustomLeadItems>[];
  ListCustomLeadItems leadItem = ListCustomLeadItems();

  CustomerTypeModel customerTypeSelected = CustomerTypeModel();

List<Product> productUpdate = <Product>[];

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
      tag: <int>[],
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
      }

      var tags = await DealConnection.getTag(context);
      if (tags != null) {
        tagsData = tags.data;
      }

      bindingData();
    });
  }

  void bindingData() async {
    _dealNameText.text = widget.detail?.dealName ?? "";

    allocatorSelected = AllocatorData(
        fullName: widget.detail?.staffName,
        staffId: widget.detail?.saleId,
        selected: true);

    for (int i = 0; i < allocatorData.length; i++) {
      if ((widget.detail?.saleId ?? 0) == allocatorData[i].staffId) {
        allocatorData[i].selected = true;

        allocatorSelected = allocatorData[i];
      } else {
        allocatorData[i].selected = false;
      }
    }

    for (int i = 0; i < customerTypeData.length; i++) {
      if ((widget.detail?.typeCustomer ?? 0) ==
          customerTypeData[i].customerTypeNameEn) {
        customerTypeData[i].selected = true;

        customerTypeSelected = customerTypeData[i];
      } else {
        customerTypeData[i].selected = false;
      }
    }

    if (customerTypeSelected.customerTypeNameEn == "customer") {
      customerSelected = DealItems(
          customerCode: widget.detail?.customerCode,
          customerName: widget.detail?.customerName);
      leadItem = ListCustomLeadItems(customerLeadCode: "");
    } else {
      customerSelected = DealItems(
          customerCode: widget.detail?.customerCode,
          customerName: widget.detail?.customerName);
      leadItem =
          ListCustomLeadItems(customerLeadCode: widget.detail?.customerCode);
    }

    _phoneNumberText.text = widget.detail?.phone;

    for (int i = 0; i < customerTypeData.length; i++) {
      if ((widget.detail?.typeCustomer ?? 0) ==
          customerTypeData[i].customerTypeNameEn) {
        customerTypeData[i].selected = true;

        customerTypeSelected = customerTypeData[i];
      } else {
        customerTypeData[i].selected = false;
      }
    }

    for (int i = 0; i < pipeLineData.length; i++) {
      if ((widget.detail?.pipelineCode ?? "").toLowerCase() ==
          pipeLineData[i].pipelineCode.toLowerCase()) {
        pipeLineData[i].selected = true;
        pipelineSelected = pipeLineData[i];
      } else {
        pipeLineData[i].selected = false;
      }
    }

    var journeys =
        await DealConnection.getJourney(context, pipelineSelected.pipelineCode);
    if (journeys != null) {
      journeysData = journeys.data;
    }

    for (int i = 0; i < journeysData.length; i++) {
      if ((widget.detail.journeyCode ?? "").toLowerCase() ==
          journeysData[i].journeyCode.toLowerCase()) {
        journeysData[i].selected = true;
        journeySelected = journeysData[i];
      } else {
        journeysData[i].selected = false;
      }
    }

    if (branchData != null && branchData.length > 0) {
      BranchData result = branchData.firstWhereOrNull(
          (element) => element.branchName == widget.detail?.branchName ?? "");
      if (result != null) {
        result.selected = true;
        branchSelected = result;
      }
    }

    if (widget.detail.tag.length > 0 && tagsData != null) {
      for (var tag in tagsData) {
        for (int tagID in widget.detail.tag) {
          if (tag.tagId == tagID) {
            tag.selected = true;
            tagsSelected?.add(tag);
          }
        }
      }
      for (int i = 0; i < tagsSelected.length; i++) {
        if (tagsString == "") {
          tagsString = tagsSelected[i].name;
        } else {
          tagsString += ", ${tagsSelected[i].name}";
        }
      }
    }

    orderSourceSelected = OrderSourceData(
        orderSourceName: widget.detail?.orderSourceName ?? "", selected: true);

        detailDeal.orderSourceId = orderSourceSelected.orderSourceId;

    _closingDueDateText.text = DateFormat("dd/MM/yyyy")
        .format(DateTime.parse(widget.detail.closingDate));

    selectedClosingDueDate =
        DateTime.parse(widget.detail.closingDate + ' 00:00:00.000');

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
              AppLocalizations.text(LangKey.edit_deal),
              style: const TextStyle(color: Colors.white, fontSize: 18.0),
            ),
            leadingWidth: 20.0,
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
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
// nhập tên deal
        _buildTextField(AppLocalizations.text(LangKey.inputDealName), "",
            Assets.iconDealName, true, false, true,
            fillText: _dealNameText,
            focusNode: _dealNameFocusNode,
            inputType: TextInputType.text),

// chọn người được phân bổ
        _buildTextField(
            AppLocalizations.text(LangKey.chooseAllottedPerson),
            allocatorSelected?.fullName ?? "",
            Assets.iconName,
            true,
            true,
            false, ontap: () async {
          FocusScope.of(context).unfocus();
          print("Chọn người được phân bổ");

          if (allocatorData == null || allocatorData.length == 0) {
            DealConnection.showLoading(context);
            var allocators = await DealConnection.getAllocator(context);
            Navigator.of(context).pop();

            if (allocators != null) {
              allocatorData = allocators.data;

              AllocatorData allocator = await showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return GestureDetector(
                      child: AllocatorModal(
                          allocatorData: allocatorData,
                          allocatorSelected: allocatorSelected),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      behavior: HitTestBehavior.opaque,
                    );
                  });
              if (allocator != null) {
                allocatorSelected = allocator;
                // widget.detailPotential?.saleId = allocatorSelected.staffId;
                setState(() {});
              }
            }
          } else {
            AllocatorData allocator = await showModalBottomSheet(
                context: context,
                useRootNavigator: true,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return GestureDetector(
                    child: AllocatorModal(
                      allocatorData: allocatorData,
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    behavior: HitTestBehavior.opaque,
                  );
                });
            if (allocator != null) {
              allocatorSelected = allocator;
              // widget.detailPotential?.saleId = allocatorSelected.staffId;
              setState(() {});
            }
          }
        }),

        // Loại khách hàng
        _buildTextField(
            AppLocalizations.text(LangKey.customerStyle),
            customerTypeSelected?.customerTypeName ?? "",
            Assets.iconStyleCustomer,
            true,
            true,
            false, ontap: () async {
          print("loại khách hàng");
          FocusScope.of(context).unfocus();

          CustomerTypeModel customerType = await showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) {
                return GestureDetector(
                  child: CustomerTypeModal(
                    customerTypeData: customerTypeData,
                  ),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  behavior: HitTestBehavior.opaque,
                );
              });
          if (customerType != null) {
            customerTypeSelected = customerType;
            customerSelected = DealItems(customerCode: "", customerName: "");
            leadItem = ListCustomLeadItems(customerLeadCode: "");
            _phoneNumberText.text = "";
            setState(() {});
          }

          // print("loại khách hàng");
        }),
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

// chọn khách hàng
        showMoreInfoDeal
            ? _buildTextField(
                AppLocalizations.text(LangKey.choose_customer),
                customerSelected?.customerName ?? "",
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
                    _phoneNumberText.text = "";

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
                    customerSelected.customerCode = result.customerLeadCode;
                    customerSelected.customerName = result.leadFullName;
                    leadItem.customerLeadCode = result.customerLeadCode;
                    _phoneNumberText.text = result.phone;

                    setState(() {});
                  }
                } else {
                  DealConnection.showMyDialog(
                      context, AppLocalizations.text(LangKey.warningChooseCustomerType));
                }
              })
            : Container(),
// phone
        showMoreInfoDeal
            ? _buildTextField(
                AppLocalizations.text(LangKey.inputPhonenumber),
                "",
                Assets.iconCall,
                true,
                false,
                true,
                fillText: _phoneNumberText,
                focusNode: _phoneNumberFocusNode,
                inputType: TextInputType.number,
              )
            : Container(),

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

                if (pipeLineData == null || pipeLineData.length == 0) {
                  DealConnection.showLoading(context);
                  var pipelines = await DealConnection.getPipeline(context);
                  Navigator.of(context).pop();
                  if (pipelines != null) {
                    pipeLineData = pipelines.data;

                    PipelineData pipeline = await showModalBottomSheet(
                        context: context,
                        useRootNavigator: true,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return GestureDetector(
                            child: PipelineModal(
                              pipeLineData: pipeLineData,
                            ),
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            behavior: HitTestBehavior.opaque,
                          );
                        });
                    if (pipeline != null) {
                      if (pipelineSelected?.pipelineName !=
                          pipeline.pipelineName) {
                        journeySelected = null;
                      }

                      pipelineSelected = pipeline;
                      DealConnection.showLoading(context);
                      var journeys = await DealConnection.getJourney(
                          context, pipelineSelected.pipelineCode);
                      Navigator.of(context).pop();
                      if (journeys != null) {
                        journeysData = journeys.data;
                      }
                      setState(() {});
                    }
                  }
                } else {
                  PipelineData pipeline = await showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return GestureDetector(
                          child: PipelineModal(
                            pipeLineData: pipeLineData,
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          behavior: HitTestBehavior.opaque,
                        );
                      });
                  if (pipeline != null) {
                    if (pipelineSelected?.pipelineName !=
                        pipeline.pipelineName) {
                      journeySelected = null;
                    }

                    pipelineSelected = pipeline;
                    DealConnection.showLoading(context);
                    var journeys = await DealConnection.getJourney(
                        context, pipelineSelected.pipelineCode);
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
        showMoreInfoDeal
            ? _buildTextField(
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
                      return GestureDetector(
                        child: JourneyModal(
                          journeys: journeysData,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        behavior: HitTestBehavior.opaque,
                      );
                    });
                if (journey != null) {
                  journeySelected = journey;
                  setState(() {
                    // await LeadConnection.getDistrict(context, province.provinceid);
                  });
                }
              })
            : Container(),
// chọn ngày kết thúc thực tế
        showMoreInfoDeal
            ? Container(
                margin: const EdgeInsets.only(bottom: 10.0),
                // width: (MediaQuery.of(context).size.width - 60) / 2 - 8,
                child: _buildDatePicker(
                    AppLocalizations.text(LangKey.expectedEndingDate),
                    _closingDueDateText, () {
                  _showClosingDueDate();
                }))
            : Container(),
        // showAdditionDeal ?
        MoreInfoEditDeal(
          detail: widget.detail,
          branchData: branchData,
          detailDeal: detailDeal,
          orderSourceSelected: orderSourceSelected,
          tagsData: tagsData,
          tagsString: tagsString,
        )
      ])
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
          if (_dealNameText.text == "" ||
              _phoneNumberText.text == "" ||
              customerTypeSelected == null ||
              pipelineSelected == null ||
              journeySelected == null ||
              customerSelected == null ||
              selectedClosingDueDate == null) {
            DealConnection.showMyDialog(
                context, AppLocalizations.text(LangKey.warningChooseAllRequiredInfo));
          } else {
            DealConnection.showLoading(context);

            double amount = 0;
            if (widget.detail.productBuy.length > 0) {
              for (int i = 0; i < widget.detail.productBuy.length; i++) {

                productUpdate.add(
                  Product(
                    objectType: widget.detail.productBuy[i].objectType,
                    objectName: widget.detail.productBuy[i].objectName,
                    objectCode: "",
                    objectId: widget.detail.productBuy[i].objectId,
                    quantity: widget.detail.productBuy[i].quantity,
                    price: widget.detail.productBuy[i].price,
                    amount: widget.detail.productBuy[i].amount


                  )
                );

                amount += widget.detail.productBuy[i].amount *
                    widget.detail.productBuy[i].quantity;
              }
            }

            UpdateDealModelResponse result = await DealConnection.updateDeal(
                context,
                UpdateDealModelRequest(
                  dealCode: widget.detail.dealCode,
                    dealName: _dealNameText.text,
                    saleId: allocatorSelected.staffId,
                    typeCustomer: customerTypeSelected.customerTypeNameEn,
                    customerCode: customerSelected.customerCode,
                    phone: _phoneNumberText.text,
                    pipelineCode: pipelineSelected.pipelineCode,
                    journeyCode: journeySelected.journeyCode,
                    closingDate:
                        "${DateFormat("yyyy-MM-dd").format(selectedClosingDueDate)}",
                    branchCode: detailDeal.branchCode,
                    tag: widget.detail.tag,
                    orderSourceId: detailDeal.orderSourceId,
                    probability: double.parse(widget.detail?.probability ?? ""),
                    dealDescription: widget.detail.dealDescription,
                    amount: amount,
                    product: productUpdate
                    ));
            Navigator.of(context).pop();
            if (result != null) {
              if (result.errorCode == 0) {
                print(result.errorDescription);
                await DealConnection.showMyDialog(
                    context, result.errorDescription);
                Navigator.of(context).pop(true);
              } else {
                DealConnection.showMyDialog(context, result.errorDescription);
              }
            }
          }
          print("Okie call api add");
        },
        child: Center(
          child: Text(
            // AppLocalizations.text(LangKey.convertCustomers),
            AppLocalizations.text(LangKey.editDealTolowcase),
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
}
