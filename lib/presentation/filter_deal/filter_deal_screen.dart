import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/closing_date_model.dart';
import 'package:epoint_deal_plugin/model/closing_due_date_model.dart';
import 'package:epoint_deal_plugin/model/create_date_model.dart';
import 'package:epoint_deal_plugin/model/filter_screen_model.dart';
import 'package:epoint_deal_plugin/model/request/list_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_closing_date.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_closing_due_date.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_create_date.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_order_source.dart';
import 'package:epoint_deal_plugin/presentation/modal/branch_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/journey_modal.dart';
import 'package:epoint_deal_plugin/presentation/modal/pipeline_modal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class FilterDealCustomer extends StatefulWidget {
  List<PipelineData> pipeLineData = <PipelineData>[];
  List<BranchData> branchData = <BranchData>[];
  FilterScreenModel filterScreenModel = FilterScreenModel();

  FilterDealCustomer(
      {Key key, this.filterScreenModel, this.pipeLineData, this.branchData})
      : super(key: key);

  @override
  _FilterDealCustomerState createState() => _FilterDealCustomerState();
}

class _FilterDealCustomerState extends State<FilterDealCustomer> {
  final ScrollController _controller = ScrollController();

  List<CreateDateModel> createDateOptions = [
    CreateDateModel(
        createDateName: AppLocalizations.text(LangKey.today),
        createDateID: 0,
        selected: false),
    CreateDateModel(
        createDateName: AppLocalizations.text(LangKey.tomorrow),
        createDateID: 1,
        selected: false),
    CreateDateModel(
        createDateName: AppLocalizations.text(LangKey.seven_day_ago),
        createDateID: 2,
        selected: false),
    CreateDateModel(
        createDateName: AppLocalizations.text(LangKey.thirty_day_ago),
        createDateID: 3,
        selected: false),
    CreateDateModel(
        createDateName: AppLocalizations.text(LangKey.in_month),
        createDateID: 4,
        selected: false),
    CreateDateModel(
        createDateName: AppLocalizations.text(LangKey.last_month),
        createDateID: 5,
        selected: false),
    CreateDateModel(
        createDateName: AppLocalizations.text(LangKey.date_option),
        createDateID: 6,
        selected: false)
  ];
   CreateDateModel createDateSeleted = CreateDateModel();


  List<ClosingDateModel> closingDateOptions = [
    ClosingDateModel(
        closingDateName: AppLocalizations.text(LangKey.today),
        closingDateID: 0,
        selected: false),
    ClosingDateModel(
        closingDateName: AppLocalizations.text(LangKey.tomorrow),
        closingDateID: 1,
        selected: false),
    ClosingDateModel(
        closingDateName: AppLocalizations.text(LangKey.seven_day_ago),
        closingDateID: 2,
        selected: false),
    ClosingDateModel(
        closingDateName: AppLocalizations.text(LangKey.thirty_day_ago),
        closingDateID: 3,
        selected: false),
    ClosingDateModel(
        closingDateName: AppLocalizations.text(LangKey.in_month),
        closingDateID: 4,
        selected: false),
    ClosingDateModel(
        closingDateName: AppLocalizations.text(LangKey.last_month),
        closingDateID: 5,
        selected: false),
    ClosingDateModel(
        closingDateName: AppLocalizations.text(LangKey.date_option),
        closingDateID: 6,
        selected: false)
  ];
  ClosingDateModel closingDateSeleted;

  List<ClosingDueDateModel> closingDueDateOptions = [
    ClosingDueDateModel(
        closingDueDateName: AppLocalizations.text(LangKey.today),
        closingDueDateID: 0,
        selected: false),
    ClosingDueDateModel(
        closingDueDateName: AppLocalizations.text(LangKey.tomorrow),
        closingDueDateID: 1,
        selected: false),
    ClosingDueDateModel(
        closingDueDateName: AppLocalizations.text(LangKey.seven_day_ago),
        closingDueDateID: 2,
        selected: false),
    ClosingDueDateModel(
        closingDueDateName: AppLocalizations.text(LangKey.thirty_day_ago),
        closingDueDateID: 3,
        selected: false),
    ClosingDueDateModel(
        closingDueDateName: AppLocalizations.text(LangKey.in_month),
        closingDueDateID: 4,
        selected: false),
    ClosingDueDateModel(
        closingDueDateName: AppLocalizations.text(LangKey.last_month),
        closingDueDateID: 5,
        selected: false),
    ClosingDueDateModel(
        closingDueDateName: AppLocalizations.text(LangKey.date_option),
        closingDueDateID: 6,
        selected: false)
  ];
  ClosingDueDateModel closingDueDateSeleted;

  List<OrderSourceData> orderSourceData = [
    OrderSourceData(
        orderSourceName: AppLocalizations.text(LangKey.all),
        orderSourceId: 0,
        selected: true)
  ];

  OrderSourceData orderSourceSeleted = OrderSourceData();

  List<PipelineData> pipeLineData;

  PipelineData pipelineSelected = PipelineData();

  List<JourneyData> journeysData;
  JourneyData journeySelected = JourneyData();

  List<BranchData> branchData;
  BranchData branchSelected;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DealConnection.showLoading(context);
      await getData();
      // await bindingModel();
      Navigator.of(context).pop();

      setState(() {});
    });
  }

  void getData() async {
    var orderSources = await DealConnection.getOrderSource(context);
    if (orderSources != null) {
      orderSourceData.addAll(orderSources.data);
    }

    var branchs = await DealConnection.getBranch(context);
    if (branchs != null) {
      branchData = branchs.data;
    }

    var pipelines = await DealConnection.getPipeline(context);
    if (pipelines != null) {
      pipeLineData = pipelines.data;
    }

    bindingModel ();
  }


void bindingModel () async {

  for (int i = 0; i < orderSourceData.length; i++) {
      if (widget.filterScreenModel.filterModel.orderSourceName != "") {
        if (widget.filterScreenModel.filterModel.orderSourceName ==
            orderSourceData[i].orderSourceName) {
          orderSourceData[i].selected = true;
        } else {
          orderSourceData[i].selected = false;
        }
      }
    }

    if (widget.filterScreenModel.filterModel.branchName != "") {
      BranchData data = branchData.firstWhere((element) =>
          element.branchName ==
          widget.filterScreenModel.filterModel.branchName);
      branchSelected = data;
    }

    if (widget.filterScreenModel.filterModel.pipelineName != "") {
      PipelineData data = pipeLineData.firstWhere((element) =>
          element.pipelineName ==
          widget.filterScreenModel.filterModel.pipelineName);
      pipelineSelected = data;

      var journeys = await DealConnection.getJourney(
          context, pipelineSelected.pipelineCode);
      if (journeys != null) {
        journeysData = journeys.data;

        if (widget.filterScreenModel.filterModel.journeyName != "") {
          JourneyData data = journeysData.firstWhere((element) =>
              element.journeyName ==
              widget.filterScreenModel.filterModel.journeyName);
          journeySelected = data;
        }
      }
    }
    if (widget.filterScreenModel.id_created_at != "") {
      int index = int.parse(widget.filterScreenModel.id_created_at);
      createDateSeleted = createDateOptions[index];
    } else {
      createDateSeleted = null;
    }

    if (widget.filterScreenModel.id_closing_date != "") {
      int index = int.parse(widget.filterScreenModel.id_closing_date);
      closingDateSeleted = closingDateOptions[index];
    } else {
      closingDateSeleted = null;
    }

    if (widget.filterScreenModel.id_closing_due_date != "") {
      int index = int.parse(widget.filterScreenModel.id_closing_due_date);
      closingDueDateSeleted = closingDueDateOptions[index];
    } else {
      closingDueDateSeleted = null;
    }
    setState(() {});

}


  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppLocalizations.text(LangKey.filter),
            style: const TextStyle(color: Colors.white, fontSize: 20.0),
          ),
        ),
        body: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: _buildBody()));
  }

  Widget _buildBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: ListView(
          padding:
              EdgeInsets.only(top: 16.0, bottom: 16.0, left: 16.0, right: 8.0),
          physics: ClampingScrollPhysics(),
          controller: _controller,
          // separator: const Divider(),
          children: _listWidget(),
        )),
        _buildButton(),
        Container(
          height: 20.0,
        )
      ],
    );
  }

  List<Widget> _listWidget() {
    return [
      // theo nguon don hang
      Text(
        AppLocalizations.text(LangKey.accordingOrderSource),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),
      FilterByOrderSource(
        orderSourceData: orderSourceData,
      ),


      Container(height: 10.0),
      Text(
        AppLocalizations.text(LangKey.byBranch),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),
      Container(height: 10.0),
      _buildTextField(
          AppLocalizations.text(LangKey.chooseBranch),
          branchSelected?.address ?? "",
          Assets.iconItinerary,
          false,
          true,
          false, ontap: () async {
        print("Chon chi nhanh");

        BranchData branch = await showModalBottomSheet( 
            context: context,
            useRootNavigator: true,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return GestureDetector(
                child: BranchModal(
                  branchData: branchData,
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
                behavior: HitTestBehavior.opaque,
              );
            });
        if (branch != null) {
          branchSelected = branch;
          widget.filterScreenModel.filterModel.branchName =
              branchSelected.branchName;

          setState(() {});
        }
      }),

      // theo ngày tạo
      Text(
        AppLocalizations.text(LangKey.byCreationDate),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),
      FilterByCreateDate(
        filterScreenModel: widget.filterScreenModel,
        createDateOptions: createDateOptions,
        id_create_at: widget.filterScreenModel.id_created_at,
      ),

      Text(
        AppLocalizations.text(LangKey.accordingExpectedEnding),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),

      FilterByClosingDate(
        filterScreenModel: widget.filterScreenModel,
        closingDateOptions: closingDateOptions,
        id_closing_date: widget.filterScreenModel.id_closing_date,
      ),

      Text(
        AppLocalizations.text(LangKey.accordingActualEnding),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),

      FilterByClosingDueDate(
        filterScreenModel: widget.filterScreenModel,
        closingDueDateOptions: closingDueDateOptions,
        id_closing_due_date:  widget.filterScreenModel.id_closing_due_date,
      ),

      Text(
        AppLocalizations.text(LangKey.byPipeline),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),

      Container(height: 10.0),

      // chọn pipeline
      _buildTextField(
          AppLocalizations.text(LangKey.choosePipeline),
          pipelineSelected?.pipelineName ?? "",
          Assets.iconChance,
          false,
          true,
          false, ontap: () async {
        print("Pipeline");
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
          widget.filterScreenModel.filterModel.pipelineName =
              pipelineSelected.pipelineName;

          widget.filterScreenModel.filterModel.journeyName = "";

          var journeys = await DealConnection.getJourney(
              context, pipelineSelected.pipelineCode);
          if (journeys != null) {
            journeysData = journeys.data;
          }
          setState(() {});
        }
      }),
      Container(height: 10.0),

      Text(
        AppLocalizations.text(LangKey.byJourney),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),

      Container(height: 10.0),
      _buildTextField(
          AppLocalizations.text(LangKey.chooseItinerary),
          journeySelected?.journeyName ?? "",
          Assets.iconItinerary,
          false,
          true,
          false, ontap: () async {
        print("Chọn hành trình");

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
          widget.filterScreenModel.filterModel.journeyName =
              journeySelected.journeyName;

          setState(() {
            // await LeadConnection.getDistrict(context, province.provinceid);
          });
        }
      }),
    ];
  }

  Widget _buildButton() {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: AppColors.primaryColor,
              borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () {
              print("ap dung");

              if (Global.validateCreateDate == false || Global.validateClosingDate == false || Global.validateClosingDueDate == false) {
                DealConnection.showMyDialog(context, AppLocalizations.text(LangKey.warningChooseFullFromdateTodate));
                return;
              }

              var orderSource =
                  orderSourceData.firstWhere((element) => element.selected);

              if (orderSource.orderSourceName ==
                  AppLocalizations.text(LangKey.all)) {
                widget.filterScreenModel.filterModel.orderSourceName = "";
              } else {
                widget.filterScreenModel.filterModel.orderSourceName =
                    orderSource.orderSourceName;
              }
              Navigator.of(context).pop(widget.filterScreenModel);
            },
            child: Center(
              child: Text(
                // AppLocalizations.text(LangKey.convertCustomers),
                AppLocalizations.text(LangKey.apply),
                style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 15.0),
          height: 40,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1.0, color: Colors.blue, style: BorderStyle.solid)),
          child: InkWell(
            onTap: () async {
              print("xoa");
              await clearData();
            },
            child: Center(
              child: Text(
                AppLocalizations.text(LangKey.delete),
                style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF1A76B4),
                    fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
        )
      ],
    );
  }

  void clearData() async {

    widget.filterScreenModel = FilterScreenModel(
        filterModel: ListDealModelRequest(
            search: "",
            page: 1,
            orderSourceName: "",
            branchName: "",
            createdAt: "",
            closingDate: "",
            closingDueDate: "",
            pipelineName: "",
            journeyName: ""),
        fromDate_closing_date: null,
        fromDate_closing_due_date: null,
        fromDate_created_at: null,
        toDate_created_at: null,
        id_created_at: "",
        id_closing_date: "",
        toDate_closing_date: null,
        toDate_closing_due_date: null,
        id_closing_due_date: "");

    for(int i = 0; i < createDateOptions.length ; i++) {
          createDateOptions[i].selected = false;
    }
    createDateSeleted = null;

    for(int i = 0; i < closingDateOptions.length ; i++) {
          closingDateOptions[i].selected = false;
    }
    closingDateSeleted = null;

    for(int i = 0; i < closingDueDateOptions.length ; i++) {
          closingDueDateOptions[i].selected = false;
    }
    closingDueDateSeleted = null;
    
    for(int i = 0; i < branchData.length ; i++) {
        if (i == 0) {
          branchData[i].selected = true;
        } else {
          branchData[i].selected = false;
        }
    }
     branchSelected = null;

    for(int i = 0; i < orderSourceData.length ; i++) {
        if (i == 0) {
          orderSourceData[i].selected = true;
        } else {
          orderSourceData[i].selected = false;
        }
    }


    for(int i = 0; i < pipeLineData.length ; i++) {
        if (i == 0) {
          pipeLineData[i].selected = true;
        } else {
          pipeLineData[i].selected = false;
        }
    }
    pipelineSelected = null;
    journeysData = [];
    journeySelected = null;
    

    // initModel() ;

    setState(() {
      
    });

    // LeadConnection.showLoading(context);
    // await getData();
    // Navigator.of(context).pop();
  }

  Widget _buildTextField(String title, String content, String icon,
      bool mandatory, bool dropdown, bool textfield,
      {Function ontap, TextEditingController fillText}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: ontap,
        child: TextField(
          enabled: textfield,
          readOnly: !textfield,
          controller: fillText,
          // focusNode: _focusNode,
          keyboardType: TextInputType.text,
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
            }
          },
        ),
      ),
    );
  }
}
