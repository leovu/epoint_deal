import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/customer_type.dart';
import 'package:epoint_deal_plugin/model/object_pop_create_deal_model.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/add_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_allocator_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_option_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_customer_lead_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/more_info_creat_deal.dart';
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
  AllocatorData allocatorSelected = AllocatorData();

  List<OrderSourceData> orderSources;
  OrderSourceData orderSourceSelected;

  List<TagData> tags;
  List<TagData> tagsSelected;

  List<BranchData> branchData;
  BranchData branchSelected;

  List<CustomerTypeModel> customerTypeData = [
    CustomerTypeModel(
        // customerTypeName: AppLocalizations.text(LangKey.personal),
        customerTypeName: "Khách hàng",
        customerTypeNameEn: "customer",
        customerTypeID: 1,
        selected: true),
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

  

  CustomerTypeModel customerTypeSelected = CustomerTypeModel(
        // customerTypeName: AppLocalizations.text(LangKey.personal),
        customerTypeName: "Khách hàng",
        customerTypeNameEn: "customer",
        customerTypeID: 1,
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
      // product: <Product>[],
      product: <Product>[]);

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
      }
  var journeys =
        await DealConnection.getJourney(context, pipelineSelected.pipelineCode);
    if (journeys != null) {
      journeysData = journeys.data;

      journeySelected = journeysData[0];
    }

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
            if (customerType .customerTypeID == customerTypeSelected?.customerTypeID ?? 0) {
              return;
            }

            customerTypeSelected = customerType;
            customerSelected = DealItems(customerCode: "",customerName :"");
            leadItem = ListCustomLeadItems(customerLeadCode: "");

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

                if (customerTypeSelected.customerTypeNameEn == AppLocalizations.text(LangKey.customer))  {
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
                  _dealNameText.text = "${AppLocalizations.text(LangKey.dealOf)} ${customer?.fullName ?? ""}";

                  setState(() {});
                }
                } else if(customerTypeSelected.customerTypeNameEn == "lead")  {
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
                  DealConnection.showMyDialog(context, "Vui lòng chọn loại khách hàng*");
                }
               
              })
            : Container(),
// phone
        showMoreInfoDeal
            ? _buildTextField(AppLocalizations.text(LangKey.inputPhonenumber),
                "", Assets.iconCall, true, false, true,
                fillText: _phoneNumberText,
                focusNode: _phoneNumberFocusNode,
                inputType: TextInputType.number)
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
                  PipelineData pipeline = await showModalBottomSheet(
                      context: context,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return GestureDetector(
                          child: PipelineModal(
                            pipeLineData: pipeLineData,
                            pipelineSelected:pipelineSelected
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
                          journeySelected:journeySelected
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
        MoreInfoCreatDeal(
          branchData: branchData,
          detailDeal: detailDeal,
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
          // print("theemmm khtn");

          if (_dealNameText.text == "" ||
              _phoneNumberText.text == "" ||
              customerTypeSelected == null ||
              pipelineSelected == null ||
              journeySelected == null ||
              customerSelected == null ||
              selectedClosingDueDate == null) {
            DealConnection.showMyDialog(
                context, 'Vui lòng nhập và chọn đầy đủ thông tin bắt buộc (*)');
          } else {
            DealConnection.showLoading(context);

            int amount = 0;
            if (detailDeal.product.length > 0) {
              for (int i = 0; i < detailDeal.product.length; i++) {
                amount += detailDeal.product[i].amount*detailDeal.product[i].quantity;
              }
            }
            AddDealModelResponse result = await DealConnection.addDeal(
                context,
                AddDealModelRequest(
                    dealName: _dealNameText.text,
                    saleId: allocatorSelected.staffId,
                    typeCustomer: customerTypeSelected.customerTypeNameEn,
                    customerCode: customerSelected.customerCode,
                    phone: _phoneNumberText.text,
                    pipelineCode: pipelineSelected.pipelineCode,
                    journeyCode: journeySelected.journeyCode,
                    closingDate: "${DateFormat("yyyy-MM-dd").format(selectedClosingDueDate)}",
                    branchCode: detailDeal.branchCode,
                    tag: detailDeal.tag,
                    orderSourceId: detailDeal.orderSourceId,
                    probability: detailDeal.probability,
                    dealDescription: detailDeal.dealDescription,
                    amount: amount,
                    product: detailDeal.product));
            Navigator.of(context).pop();
            if (result != null) {
              if (result.errorCode == 0) {
                print(result.errorDescription);
                await DealConnection.showMyDialog(
                    context, result.errorDescription);
                if (result.data != null) {
                  modelResponse = ObjectPopCreateDealModel(
                      deal_id: result.data.dealId,
                      status: true);
                }
                Navigator.of(context).pop(modelResponse.toJson());
              } else {
                DealConnection.showMyDialog(context, result.errorDescription);
              }
            }
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
}

