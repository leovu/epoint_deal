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
import 'package:epoint_deal_plugin/model/history_customer_care_date.dart';
import 'package:epoint_deal_plugin/model/request/get_journey_model_request.dart';
import 'package:epoint_deal_plugin/model/request/list_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/get_status_work_response_model.dart';
import 'package:epoint_deal_plugin/model/response/journey_model_response.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/model/work_schedule_date.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_branch.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_closing_date.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_closing_due_date.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_create_date.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_journey.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_order_source.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_pipeline.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_by_work_status.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_history_care_date.dart';
import 'package:epoint_deal_plugin/presentation/modal/branch_modal.dart';
import 'package:epoint_deal_plugin/presentation/multi_staff_screen_customer_care/ui/multi_staff_screen_customer_care.dart';
import 'package:flutter/material.dart';

class FilterDealCustomer extends StatefulWidget {
  FilterScreenModel filterScreenModel = FilterScreenModel();

  FilterDealCustomer({Key key, this.filterScreenModel}) : super(key: key);

  @override
  _FilterDealCustomerState createState() => _FilterDealCustomerState();
}

class _FilterDealCustomerState extends State<FilterDealCustomer> {
  final ScrollController _controller = ScrollController();

  bool allowPop = false;

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

  List<HistoryCareDateModel> historyCareDateOptions = [
    HistoryCareDateModel(
        historyCareDateName: AppLocalizations.text(LangKey.today),
        historyCareDateID: 0,
        selected: false),
    HistoryCareDateModel(
        historyCareDateName: AppLocalizations.text(LangKey.tomorrow),
        historyCareDateID: 1,
        selected: false),
    HistoryCareDateModel(
        historyCareDateName: AppLocalizations.text(LangKey.seven_day_ago),
        historyCareDateID: 2,
        selected: false),
    HistoryCareDateModel(
        historyCareDateName: AppLocalizations.text(LangKey.thirty_day_ago),
        historyCareDateID: 3,
        selected: false),
    HistoryCareDateModel(
        historyCareDateName: AppLocalizations.text(LangKey.in_month),
        historyCareDateID: 4,
        selected: false),
    HistoryCareDateModel(
        historyCareDateName: AppLocalizations.text(LangKey.last_month),
        historyCareDateID: 5,
        selected: false),
    HistoryCareDateModel(
        historyCareDateName: AppLocalizations.text(LangKey.date_option),
        historyCareDateID: 6,
        selected: false)
  ];

  List<WorkScheduleModel> workScheduleDateOptions = [
    WorkScheduleModel(
        workscheduleDateName: AppLocalizations.text(LangKey.today),
        workscheduleDateID: 0,
        selected: false),
    WorkScheduleModel(
        workscheduleDateName: AppLocalizations.text(LangKey.tomorrow),
        workscheduleDateID: 1,
        selected: false),
    WorkScheduleModel(
        workscheduleDateName: AppLocalizations.text(LangKey.seven_day_ago),
        workscheduleDateID: 2,
        selected: false),
    WorkScheduleModel(
        workscheduleDateName: AppLocalizations.text(LangKey.thirty_day_ago),
        workscheduleDateID: 3,
        selected: false),
    WorkScheduleModel(
        workscheduleDateName: AppLocalizations.text(LangKey.in_month),
        workscheduleDateID: 4,
        selected: false),
    WorkScheduleModel(
        workscheduleDateName: AppLocalizations.text(LangKey.last_month),
        workscheduleDateID: 5,
        selected: false),
    WorkScheduleModel(
        workscheduleDateName: AppLocalizations.text(LangKey.date_option),
        workscheduleDateID: 6,
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
  List<WorkListStaffModel> _modelStaffSSupportSelected = [];
  List<GetStatusWorkData> statusWorkData;

  List<BranchData> branchData;
  BranchData branchSelected;

  List<int> statusWorkID = [];

  String branchString = "";
  String statusWorkString = "";
  String tagsString = "";
  String staffs = "";
  String customerSourceString = "";
  String pipelineString = "";
  String journeyString = "";

  FilterScreenModel filterScreenModel = FilterScreenModel(
      filterModel: ListDealModelRequest(
          search: "",
          page: 1,
          orderSourceName: "",
          createdAt: "",
          closingDate: "",
          closingDueDate: "",
          branchId: [],
          staffId: [],
          pipelineId: [],
          journeyName: [],
          manageStatusId: [],
          careHistory: ""

          ),
      fromDate_closing_date: null,
      fromDate_closing_due_date: null,
      fromDate_created_at: null,
      toDate_created_at: null,
      id_created_at: "",
      id_closing_date: "",
      toDate_closing_date: null,
      toDate_closing_due_date: null,
      id_closing_due_date: "",
      fromDate_history_care_date: null,
      toDate_history_care_date: null,
      fromDate_work_schedule_date: null,
      toDate_work_schedule_date: null,
      id_history_care_date: "",
      id_work_schedule_date: "",
      
      
      )
      
      ;

  @override
  void initState() {
    super.initState();
    filterScreenModel = FilterScreenModel(
        filterModel: ListDealModelRequest.fromJson(
            widget.filterScreenModel.filterModel.toJson()),
        fromDate_closing_date: widget.filterScreenModel.fromDate_closing_date,
        toDate_closing_date: widget.filterScreenModel.toDate_closing_due_date,
        id_closing_date: widget.filterScreenModel.id_closing_date,
        fromDate_created_at: widget.filterScreenModel.fromDate_created_at,
        toDate_created_at: widget.filterScreenModel.toDate_created_at,
        id_created_at: widget.filterScreenModel.id_created_at,
        fromDate_closing_due_date:
            widget.filterScreenModel.fromDate_closing_due_date,
        toDate_closing_due_date:
            widget.filterScreenModel.toDate_closing_due_date,
        id_closing_due_date: widget.filterScreenModel.id_closing_due_date,
        fromDate_history_care_date:
            widget.filterScreenModel.fromDate_history_care_date,
        toDate_history_care_date:
            widget.filterScreenModel.toDate_history_care_date,
        fromDate_work_schedule_date:
            widget.filterScreenModel.fromDate_work_schedule_date,
        toDate_work_schedule_date:
            widget.filterScreenModel.toDate_work_schedule_date,
        id_history_care_date: widget.filterScreenModel.id_history_care_date,
        id_work_schedule_date: widget.filterScreenModel.id_work_schedule_date,
        
        
        
        
        );

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      DealConnection.showLoading(context);
      await getData();
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

    bindingModel();
  }

  void bindingModel() async {
    for (int i = 0; i < orderSourceData.length; i++) {
      if (filterScreenModel.filterModel.orderSourceName != "") {
        if (widget.filterScreenModel.filterModel.orderSourceName ==
            orderSourceData[i].orderSourceName) {
          orderSourceData[i].selected = true;
        } else {
          orderSourceData[i].selected = false;
        }
      }
    }

    // if (filterScreenModel.filterModel.branchName != "") {
    //   BranchData data = branchData.firstWhere((element) =>
    //       element.branchName ==
    //       widget.filterScreenModel.filterModel.branchName);
    //   branchSelected = data;
    //   branchSelected.selected = true;
    // }

    // if (filterScreenModel.filterModel.pipelineName != "") {
    //   PipelineData data = pipeLineData.firstWhere((element) =>
    //       element.pipelineName ==
    //       widget.filterScreenModel.filterModel.pipelineName);
    //   pipelineSelected = data;
    //   pipelineSelected.selected = true;

    //   var journeys = await DealConnection.getJourney(
    //       context, GetJourneyModelRequest(
    //         pipelineCode: [pipelineSelected.pipelineCode]
    //       ));
    //   if (journeys != null) {
    //     journeysData = journeys.data;

    //     if (filterScreenModel.filterModel.journeyName != "") {
    //       JourneyData data = journeysData.firstWhere((element) =>
    //           element.journeyName ==
    //           widget.filterScreenModel.filterModel.journeyName);
    //       journeySelected = data;
    //       journeySelected.selected = true;
    //     }
    //   }
    // }
    if (filterScreenModel.id_created_at != "") {
      int index = int.parse(widget.filterScreenModel.id_created_at);
      createDateSeleted = createDateOptions[index];
    } else {
      createDateSeleted = null;
    }

    if (filterScreenModel.id_closing_date != "") {
      int index = int.parse(widget.filterScreenModel.id_closing_date);
      closingDateSeleted = closingDateOptions[index];
    } else {
      closingDateSeleted = null;
    }

    if (filterScreenModel.id_closing_due_date != "") {
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
    return WillPopScope(
      onWillPop: () {
        if (allowPop) {
          widget.filterScreenModel = FilterScreenModel(
              filterModel: ListDealModelRequest(
                  search: "",
                  page: 1,
                  orderSourceName: "",
          createdAt: "",
          closingDate: "",
          closingDueDate: "",
          branchId: [],
          staffId: [],
          pipelineId: [],
          journeyName: [],
          manageStatusId: [],
          careHistory: ""),
              fromDate_closing_date: null,
              fromDate_closing_due_date: null,
              fromDate_created_at: null,
              toDate_created_at: null,
              id_created_at: "",
              id_closing_date: "",
              toDate_closing_date: null,
              toDate_closing_due_date: null,
              id_closing_due_date: "");

          Navigator.of(context).pop(widget.filterScreenModel);
        } else {
          Navigator.of(context).pop();
        }
        return;
      },
      child: Scaffold(
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
              child: _buildBody())),
    );
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
          branchString,
          Assets.iconItinerary,
          false,
          true,
          false, ontap: () async {
        print("Chon chi nhanh");
        List<int> branchID = [];
        var branchDataSelected = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => FilterByBranch(branchData: branchData)));

                if (branchDataSelected != null) {
                  // widget.detailDeal.tag = [];
                  branchString = "";
                  branchData = branchDataSelected;

                  for (int i = 0; i < branchData.length; i++) {
                    if (branchData[i].selected) {
                      branchID.add(branchData[i].branchId);
                      if (branchString == "") {
                        branchString = branchData[i].branchName;
                      } else {
                        branchString += ", ${branchData[i].branchName}";
                      }
                    }
                  }

                  filterScreenModel.filterModel.branchId = branchID;
                  setState(() {});
                }


      }),
      Container(height: 10.0),

      // theo ngày tạo
      Text(
        AppLocalizations.text(LangKey.byCreationDate),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),
      FilterByCreateDate(
        filterScreenModel: filterScreenModel,
        createDateOptions: createDateOptions,
        id_create_at: filterScreenModel.id_created_at,
      ),

      Text(
        AppLocalizations.text(LangKey.accordingExpectedEnding),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),

      FilterByClosingDate(
        filterScreenModel: filterScreenModel,
        closingDateOptions: closingDateOptions,
        id_closing_date: filterScreenModel.id_closing_date,
      ),

      Text(
        AppLocalizations.text(LangKey.accordingActualEnding),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),

      FilterByClosingDueDate(
        filterScreenModel: filterScreenModel,
        closingDueDateOptions: closingDueDateOptions,
        id_closing_due_date: filterScreenModel.id_closing_due_date,
      ),

      Text(
        AppLocalizations.text(LangKey.byAllocator),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),

      Container(
        height: 10.0,
      ),

       _buildTextField(AppLocalizations.text(LangKey.chooseAllottedPerson),
          staffs, Assets.iconName, false, true, false, ontap: () async {
        print("Chọn người được phân bổ");
        List<int> listStaff = [];
        _modelStaffSSupportSelected =
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => MultipleStaffScreenCustomerCare(
                      models: _modelStaffSSupportSelected,
                    )));

        if (_modelStaffSSupportSelected != null &&
            _modelStaffSSupportSelected.length > 0) {
          staffs = "";
          for (int i = 0; i < _modelStaffSSupportSelected.length; i++) {
            if (_modelStaffSSupportSelected[i].isSelected) {
              listStaff.add(_modelStaffSSupportSelected[i].staffId);
              if (staffs == "") {
                staffs = _modelStaffSSupportSelected[i].staffName;
              } else {
                staffs += ", ${_modelStaffSSupportSelected[i].staffName}";
              }
            }
          }
          filterScreenModel.filterModel.staffId = listStaff;
          setState(() {});
        }
      }),
      Container(height: 10.0),

      

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
          pipelineString,
          Assets.iconChance,
          false,
          true,
          false, ontap: () async {
        print("Pipeline");

        List<int> pipelineSelected = [];
        List<String> pipelineStringSelected = [];
        List<PipelineData> pipeline = await Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => FilterByPipeline(pipeLineData)));

        if (pipeline != null) {
          journeyString = "";
          pipelineString = "";
          pipeLineData = pipeline;

          for (int i = 0; i < pipeLineData.length; i++) {
            if (pipeLineData[i].selected) {
              pipelineSelected.add(pipeLineData[i].pipelineId);
              pipelineStringSelected.add(pipeLineData[i].pipelineCode);
              if (pipelineString == "") {
                pipelineString = pipeLineData[i].pipelineName;
              } else {
                pipelineString += ", ${pipeLineData[i].pipelineName}";
              }
            }
          }
          filterScreenModel.filterModel.pipelineId = pipelineSelected;

          var journeys = await DealConnection.getJourney(context,
              GetJourneyModelRequest(pipelineCode: pipelineStringSelected));
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
          journeyString,
          Assets.iconItinerary,
          false,
          true,
          false, ontap: () async {
        print("Chọn hành trình");

        List<int> journeySelected = [];
        List<JourneyData> journeys =
            await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => FilterByJourney(
                      journeys: journeysData,
                    )));

        if (journeys != null) {
          journeyString = "";
          journeysData = journeys;

          for (int i = 0; i < journeysData.length; i++) {
            if (journeysData[i].selected) {
              journeySelected.add(journeysData[i].journeyId);
              if (journeyString == "") {
                journeyString = journeysData[i].journeyName;
              } else {
                journeyString += ", ${journeysData[i].journeyName}";
              }
            }
          }
          filterScreenModel.filterModel.journeyName = journeySelected;
          setState(() {});
        }
      }),
      Container(height: 10.0),

      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.text(LangKey.byHistoryCustomerCare),
            style: TextStyle(
                fontSize: 16.0,
                color: const Color(0xFF0067AC),
                fontWeight: FontWeight.bold),
          ),
          FilterHistoryCareDate(
            filterScreenModel: filterScreenModel,
            historyCareDateOptions: historyCareDateOptions,
            id_history_care_date: filterScreenModel.id_history_care_date,
          ),
        ],
      ),

      Container(height: 10.0),

         Text(
        AppLocalizations.text(LangKey.byWorkStatus),
        style: TextStyle(
            fontSize: 16.0,
            color: const Color(0xFF0067AC),
            fontWeight: FontWeight.bold),
      ),
      Container(height: 10.0),

      _buildTextField(
          AppLocalizations.text(LangKey.chooseWorkStatus),
          statusWorkString,
          Assets.iconName,
          false,
          true,
          false , ontap: () async {
            var statuswork = await Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => FilterByWorkStatus(statusWorkData: statusWorkData)));

                if (statuswork != null) {
                  statusWorkID = [];
                  
                  statusWorkString = "";
                  statusWorkData = statuswork;

                  for (int i = 0; i < statusWorkData.length; i++) {
                    if (statusWorkData[i].selected) {
                      statusWorkID.add(statusWorkData[i].manageStatusId);
                      if (statusWorkString == "") {
                        statusWorkString = statusWorkData[i].manageStatusName;
                      } else {
                        statusWorkString += ", ${statusWorkData[i].manageStatusName}";
                      }
                    }
                  }
                  setState(() {});
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

              if (Global.validateCreateDate == false ||
                  Global.validateClosingDate == false ||
                  Global.validateClosingDueDate == false ||
                  Global.validateHistoryCareDate == false ||
                  Global.validateWorkScheduleDate == false) {
                DealConnection.showMyDialog(
                    context,
                    AppLocalizations.text(
                        LangKey.warningChooseFullFromdateTodate),
                    warning: true);
                return;
              }

              var orderSource =
                  orderSourceData.firstWhere((element) => element.selected);

              if (orderSource.orderSourceName ==
                  AppLocalizations.text(LangKey.all)) {
                filterScreenModel.filterModel.orderSourceName = "";
              } else {
                filterScreenModel.filterModel.orderSourceName =
                    orderSource.orderSourceName;
              }

              widget.filterScreenModel = filterScreenModel;
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
              allowPop = true;
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
          createdAt: "",
          closingDate: "",
          closingDueDate: "",
          branchId: [],
          staffId: [],
          pipelineId: [],
          journeyName: [],
          manageStatusId: [],
          careHistory: ""),
        fromDate_closing_date: null,
        fromDate_closing_due_date: null,
        fromDate_created_at: null,
        toDate_created_at: null,
        id_created_at: "",
        id_closing_date: "",
        toDate_closing_date: null,
        toDate_closing_due_date: null,
        id_closing_due_date: "",
        fromDate_history_care_date: null,
        toDate_history_care_date: null,
        fromDate_work_schedule_date: null,
        toDate_work_schedule_date: null,
        id_history_care_date: "",
        id_work_schedule_date: "");

    filterScreenModel = FilterScreenModel(
        filterModel: ListDealModelRequest.fromJson(
            widget.filterScreenModel.filterModel.toJson()),
        fromDate_closing_date: widget.filterScreenModel.fromDate_closing_date,
        toDate_closing_date: widget.filterScreenModel.toDate_closing_due_date,
        id_closing_date: widget.filterScreenModel.id_closing_date,
        fromDate_created_at: widget.filterScreenModel.fromDate_created_at,
        toDate_created_at: widget.filterScreenModel.toDate_created_at,
        id_created_at: widget.filterScreenModel.id_created_at,
        fromDate_closing_due_date:
            widget.filterScreenModel.fromDate_closing_due_date,
        toDate_closing_due_date:
            widget.filterScreenModel.toDate_closing_due_date,
        id_closing_due_date: widget.filterScreenModel.id_closing_due_date,
        fromDate_history_care_date:
            widget.filterScreenModel.fromDate_history_care_date,
        toDate_history_care_date:
            widget.filterScreenModel.toDate_history_care_date,
        fromDate_work_schedule_date:
            widget.filterScreenModel.fromDate_work_schedule_date,
        toDate_work_schedule_date:
            widget.filterScreenModel.toDate_work_schedule_date,
        id_history_care_date: widget.filterScreenModel.id_history_care_date,
        id_work_schedule_date: widget.filterScreenModel.id_work_schedule_date);

    for (int i = 0; i < createDateOptions.length; i++) {
      createDateOptions[i].selected = false;
    }
    createDateSeleted = null;

    for (int i = 0; i < closingDateOptions.length; i++) {
      closingDateOptions[i].selected = false;
    }
    closingDateSeleted = null;

    for (int i = 0; i < closingDueDateOptions.length; i++) {
      closingDueDateOptions[i].selected = false;
    }
    closingDueDateSeleted = null;

    for (int i = 0; i < branchData.length; i++) {
      branchData[i].selected = false;
    }
    branchSelected = null;

    for (int i = 0; i < historyCareDateOptions.length; i++) {
      historyCareDateOptions[i].selected = false;
    }

    for (int i = 0; i < workScheduleDateOptions.length; i++) {
      workScheduleDateOptions[i].selected = false;
    }

    for (int i = 0; i < orderSourceData.length; i++) {
      if (i == 0) {
        orderSourceData[i].selected = true;
      } else {
        orderSourceData[i].selected = false;
      }
    }

    for (int i = 0; i < pipeLineData.length; i++) {
      pipeLineData[i].selected = false;
    }
    pipelineSelected = null;
    journeysData = [];
    journeySelected = null;

    Global.validateCreateDate = true;
    Global.validateClosingDate = true;
    Global.validateClosingDueDate = true;

    Global.validateHistoryCareDate = true;
    Global.validateWorkScheduleDate = true;

    // initModel() ;

    setState(() {});

    // LeadConnection.showLoading(context);
    // await getData();
    // Navigator.of(context).pop();
  }

  Widget _buildTextField(String title, String content, String icon,
      bool mandatory, bool dropdown, bool textfield,
      {Function ontap, TextEditingController fillText, int maxlines}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: InkWell(
        onTap: ontap,
        child: TextField(
          maxLines: maxlines ?? 1,
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
            }
          },
        ),
      ),
    );
  }
}
