import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/customer_type.dart';
import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/get_allocator_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_customer_option_model_response.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/presentation/modal/allocator_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/customer_source_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/customer_type_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/journey_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/pipeline_modal.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';

class CreateDealScreen extends StatefulWidget {
  const CreateDealScreen({Key key}) : super(key: key);

  @override
  _CreateDealScreenState createState() => _CreateDealScreenState();
}

class _CreateDealScreenState extends State<CreateDealScreen>
    with WidgetsBindingObserver {
  var _isKeyboardVisible = false;

  ScrollController _controller = ScrollController();
  TextEditingController _fullNameText = TextEditingController();
  FocusNode _fullnameFocusNode = FocusNode();

  TextEditingController _phoneNumberText = TextEditingController();
  FocusNode _phoneNumberFocusNode = FocusNode();

  bool showMoreAddress = false;
  bool showMoreAll = false;

  AddDealModelRequest requestModel = AddDealModelRequest();

  CustomerOptionData customerOptonData = CustomerOptionData();

  List<CustomerOptionSource> customerSourcesData = <CustomerOptionSource>[];
  CustomerOptionSource sourceSelected = CustomerOptionSource();

  List<PipelineData> pipeLineData = <PipelineData>[];
  PipelineData pipelineSelected = PipelineData();

  List<JourneyData> journeysData = <JourneyData>[];
  JourneyData journeySelected = JourneyData();

  List<AllocatorData> allocatorData = <AllocatorData>[];
   AllocatorData allocatorSelected = AllocatorData();

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

  CustomerTypeModel customerTypeSelected = CustomerTypeModel(
        customerTypeName: "Khách hàng",
        customerTypeNameEn: "customer",
        customerTypeID: 1,
        selected: true);

  // DetailPotentialData detailPotential = DetailPotentialData(
  //     provinceId: 0,
  //     districtId: 0,
  //     address: "",
  //     saleId: 0,
  //     businessClue: "",
  //     zalo: "");

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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
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
              AppLocalizations.text(LangKey.addPotentialCustomer),
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
          physics: const AlwaysScrollableScrollPhysics(),
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
        Text(
          // AppLocalizations.text(LangKey.infomationDeal),
          "Thông tin cơ hội bán hàng",
          style: TextStyle(
              fontSize: AppTextSizes.size16,
              color: const Color(0xFF0067AC),
              fontWeight: FontWeight.normal),
        ),

Container(
          height: 10,
        ),

         _buildTextField(
          //  AppLocalizations.text(LangKey.inputPhonenumber)
          "Nhập tên deal"
            , "",
            Assets.iconCall, true, false, true,
            fillText: _phoneNumberText,
            focusNode: _phoneNumberFocusNode,
            inputType: TextInputType.phone),

        _buildTextField(
            AppLocalizations.text(LangKey.chooseAllottedPerson),
            allocatorSelected?.fullName ?? "",
            Assets.iconName,
            true,
            true,
            false, ontap: () async {
          FocusScope.of(context).unfocus();
          print("Chọn người được phân bổ");

          if (allocatorData == null ||
              allocatorData.length == 0) {
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
            customerTypeSelected = customerType;
            setState(() {});
          }

          // print("loại khách hàng");
        }),

   
        _buildTextField(AppLocalizations.text(LangKey.inputPhonenumber), "",
            Assets.iconCall, true, false, true,
            fillText: _phoneNumberText,
            focusNode: _phoneNumberFocusNode,
            inputType: TextInputType.phone),
        // chọn pipeline
        _buildTextField(
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
                if (pipelineSelected?.pipelineName != pipeline.pipelineName) {
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
              if (pipelineSelected?.pipelineName != pipeline.pipelineName) {
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
        }),

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
      ])
    ];
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

          // if (_fullNameText.text == "" ||
          //     _phoneNumberText.text == "" ||
          //     customerTypeSelected == null ||
          //     sourceSelected == null ||
          //     pipelineSelected == null ||
          //     journeySelected == null)
          //     {
          //   DealConnection.showMyDialog(
          //       context, 'Vui lòng nhập và chọn đầy đủ thông tin bắt buộc (*)');
          // } else {
          //   LeadConnection.showLoading(context);
          //   AddLeadModelResponse result = await LeadConnection.addLead(
          //       context,
          //       AddLeadModelRequest(
          //           avatar: "",
          //           customerType: customerTypeSelected.customerTypeName,
          //           fullName: _fullNameText.text,
          //           phone: _phoneNumberText.text,
          //           customerSource: sourceSelected.customerSourceId,
          //           pipelineCode: pipelineSelected.pipelineCode,
          //           journeyCode: journeySelected.journeyCode,
          //           provinceId: detailPotential.provinceId,
          //           districtId: detailPotential.districtId,
          //           address: detailPotential.address,
          //           saleId: detailPotential.saleId,
          //           businessClue: detailPotential.businessClue,
          //           zalo: detailPotential.zalo ?? "",
          //           gender: detailPotential.gender,
          //           email: detailPotential.email));
          //   Navigator.of(context).pop();
          //   if (result != null) {
          //     if (result.errorCode == 0) {
          //       print(result.errorDescription);
          //       await LeadConnection.showMyDialog(
          //           context, result.errorDescription);
          //       if (result.data != null) {
          //         modelResponse = ObjectPopDetailModel(
          //             customer_lead_id: result.data.customerLeadId,
          //             status: true);
          //       }
          //       Navigator.of(context).pop(modelResponse.toJson());
          //     } else {
          //       LeadConnection.showMyDialog(context, result.errorDescription);
          //     }
          //   }

          print("Okie call api add");
          // }
        },
        child: Center(
          child: Text(
            // AppLocalizations.text(LangKey.convertCustomers),
            AppLocalizations.text(LangKey.addPotentialCustomer),
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
