import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/filter_screen_model.dart';
import 'package:epoint_deal_plugin/model/request/list_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/create_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/detail_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_deal_screen.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

class ListDealScreen extends StatefulWidget {
  const ListDealScreen({Key? key}) : super(key: key);

  @override
  _ListDealScreenState createState() => _ListDealScreenState();
}

class _ListDealScreenState extends State<ListDealScreen> {
  ScrollController _controller = ScrollController();
  final TextEditingController _searchtext = TextEditingController();
  final FocusNode _fonusNode = FocusNode();
  List<DealItems>? items;

  List<PipelineData> pipeLineData = <PipelineData>[];
  List<OrderSourceData> orderSourceData = <OrderSourceData>[];
  List<BranchData> branchData = <BranchData>[];
  List<WorkListStaffModel> models = [];

  final streamModel = BehaviorSubject<List<DealItems>?>();

  int currentPage = 1;
  int nextPage = 1;

  ListDealModelRequest? filterModel = ListDealModelRequest(
      search: "",
      isConvert: 0,
      page: 1,
      orderSourceName: "",
      createdAt: "",
      closingDate: "",
      closingDueDate: "",
      branchId: [],
      staffId: [],
      pipelineId: [],
      journey_id: [],
      manageStatusId: [],
      careHistory: "");

  FilterScreenModel filterScreenModel = FilterScreenModel();

  @override
  void initState() {
    super.initState();
    // _controller.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      filterScreenModel = FilterScreenModel(
        filterModel: filterModel,
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
        id_history_care_date: "",
        fromDate_work_schedule_date: null,
        toDate_work_schedule_date: null,
        id_work_schedule_date: "",
      );
      getData(false);
    });
  }

  getData(bool loadMore, {int? page}) async {
    ListDealModelResponse? model = await DealConnection.getList(
        context,
        ListDealModelRequest(
            search: _searchtext.text,
            page: filterModel!.page,
            orderSourceName: filterModel!.orderSourceName,
            createdAt: filterModel!.createdAt,
            closingDate: filterModel!.closingDate,
            closingDueDate: filterModel!.closingDueDate,
            branchId: filterModel!.branchId,
            staffId: filterModel!.staffId,
            pipelineId: filterModel!.pipelineId,
            journey_id: filterModel!.journey_id,
            manageStatusId: filterModel!.manageStatusId,
            isConvert: filterModel!.isConvert,
            careHistory: filterModel!.careHistory));
    if (model != null) {
      if (!loadMore) {
        items = [];
        items = model.data?.items;
        _controller.animateTo(
          _controller.position.minScrollExtent,
          duration: Duration(seconds: 2),
          curve: Curves.fastOutSlowIn,
        );
      } else {
        items!.addAll(model.data?.items! as Iterable<DealItems>);
      }
      currentPage = model.data?.pageInfo?.currentPage ?? 1;
      nextPage = model.data?.pageInfo?.nextPage ?? 1;
      streamModel.set(items);
    } else {
      streamModel.set([]);
    }
  }

  // _scrollListener() async {
  //   if (_controller.offset >= (_controller.position.maxScrollExtent - 500) &&
  //       !_controller.position.outOfRange) {
  //     if (this.currentPage! < this.nextPage!) {
  //       filterModel!.page = currentPage! + 1;
  //       getData(true);
  //     }
  //   }
  // }

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
          AppLocalizations.text(LangKey.list_deal)!,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        // leadingWidth: 20.0,
        actions: [
          InkWell(
            onTap: () async {
              FilterScreenModel? result =
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FilterDealCustomer(
                            filterScreenModel: filterScreenModel,
                          )));

              if (result != null) {
                filterScreenModel = result;
                filterModel = result.filterModel;
                filterModel!.page = 1;
                getData(false);
              } else {}
            },
            child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Image.asset(
                Assets.iconFilter,
                width: 24.0,
              ),
            ),
          )
        ],
      ),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primaryColor,
        onPressed: () async {
          var result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateDealScreen()));

          if (result != null) {
            var status = result["status"];
            if (status) {
              getData(false);
            }
          }
        },
        child: const Icon(
          Icons.add,
          color: AppColors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
      child: Column(
        children: [
          _buildSearch(),
          Expanded(
            child: StreamBuilder(
                stream: streamModel.output,
                builder: (context, snapshot) {
                  items = snapshot.data as List<DealItems>?;
                  return CustomListView(
                    onRefresh: () async {
                      filterModel!.page = 1;
                      getData(false);
                    },
                    onLoadmore: () async {
                      if (currentPage < nextPage) {
                        filterModel!.page = currentPage + 1;
                        getData(true);
                      }
                    },
                    padding: EdgeInsets.all(20.0 / 2),
                    physics: const AlwaysScrollableScrollPhysics(),
                    controller: _controller,
                    children: [
                      (items == null)
                          ? _buildSkeleton()
                          : (items!.length > 0)
                              ? Column(
                                  children: items!
                                      .map((e) => _dealItemV2(e))
                                      .toList())
                              : CustomDataNotFound(),
                      Container(height: 100)
                    ],
                  );
                }),
          ),
        ],
      ),
    );
  }

  Widget _buildSkeleton() {
    return LoadingWidget(
        padding: EdgeInsets.zero,
        child: CustomListView(
          padding: EdgeInsets.all(8),
          shrinkWrap: true,
          children: List.generate(
              10,
              (index) => CustomSkeleton(
                    height: 200,
                    radius: 4.0,
                  )),
        ));
  }

  Widget _buildSearch() {
    return Container(
      padding: EdgeInsets.only(left: 10.0, right: 10.0),
      child: TextField(
          enabled: true,
          controller: _searchtext,
          focusNode: _fonusNode,
          // focusNode: _focusNode,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isCollapsed: true,
            contentPadding: EdgeInsets.all(12.0),
            border: OutlineInputBorder(
              // borderSide:
              //     BorderSide(width: 1, color: Color.fromARGB(255, 21, 230, 129)),
              borderRadius: BorderRadius.circular(10.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Color(0xFFB8BFC9)),
            ),
            hintText: AppLocalizations.text(LangKey.filterNameCodePhone),
            suffixIcon: InkWell(
              splashColor: Colors.white,
              onTap: () async {
                filterModel!.page = 1;
                getData(false);
              },
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  Assets.iconSearch,
                ),
              ),
            ),
            suffixIconConstraints:
                BoxConstraints(maxHeight: 40.0, maxWidth: 40.0),
            isDense: true,
          ),
          onChanged: (event) {
            // print(event.toLowerCase());
            if (_searchtext != null) {
              // print(_searchext.text);
            }
          },
          onSubmitted: (event) async {
            filterModel!.page = 1;
            getData(false);
          }
          // },
          ),
    );
  }

  Widget _dealItemV2(DealItems item) {
    return Stack(
      children: [
        InkWell(
          onTap: () async {
            bool? result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => DetailDealScreen(
                      deal_code: item.dealCode,
                      indexTab: 0,
                      id: 667,
                    )));

            if (result != null && result) {
              getData(false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Color(0xFFC3C8D3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(bottom: 8.0, left: 5.0, top: 5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 10.0),
                        height: 20.0,
                        width: 20.0,
                        child: Image.asset(Assets.iconDeal),
                      ),
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                                text: item.dealName ?? "N/A",
                                style: TextStyle(
                                    height: 1,
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                children: [
                              WidgetSpan(
                                  child: SizedBox(
                                width: 5.0,
                              )),
                              WidgetSpan(
                                  alignment: ui.PlaceholderAlignment.top,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 8.0),
                                    decoration: BoxDecoration(
                                        color: Color(0xFF3AEDB6),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    child: Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Text(item.journeyName ?? "N/A",
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 3, 68, 48),
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal)),
                                    ),
                                  )),
                            ])),
                      ),
                      // Expanded(
                      //   child: Text(
                      //     item.dealName!,
                      //     textAlign: TextAlign.start,
                      //     style: TextStyle(
                      //         fontSize: 16.0,
                      //         color: AppColors.primaryColor,
                      //         fontWeight: FontWeight.w500),
                      //     // maxLines: 1,
                      //   ),
                      // ),
                      // Container(
                      //   padding: EdgeInsets.only(left: 4.0, right: 4.0),
                      //   decoration: BoxDecoration(
                      //       color: HexColor(
                      //           item.backgroundColorJourney ?? "#0067AC"),
                      //       borderRadius: BorderRadius.circular(10.0)),
                      //   constraints:
                      //       BoxConstraints(maxWidth: AppSizes.maxWidth! / 2.5),
                      //   child: Padding(
                      //     padding: EdgeInsets.all(5.0),
                      //     child: Text(item.journeyName!,
                      //         style: TextStyle(
                      //             color: Colors.white,
                      //             fontSize: 14.0,
                      //             fontWeight: FontWeight.w600)),
                      //   ),
                      // )
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          infoItem(Assets.iconPerson, item?.customerName ?? "",
                              false),
                          infoItem(Assets.iconCall, item?.phone ?? "", false),
                          infoItem(
                              Assets.iconTime, item?.createdAt ?? "", false),
                          infoItem(
                              Assets.iconName, item?.staffFullName ?? "", true),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 8, bottom: 8.0),
                            margin: EdgeInsets.only(bottom: 8.0, left: 5.0),
                            child: Row(
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  height: 15.0,
                                  width: 15.0,
                                  child: Image.asset(Assets.iconInteraction),
                                ),
                                Expanded(
                                  child: RichText(
                                      text: TextSpan(
                                          text: item.createdAt! + " ",
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.normal),
                                          children: [
                                        TextSpan(
                                            text: "(${item.diffDay ?? 0} ngày)",
                                            style: TextStyle(
                                                color: AppColors.primaryColor,
                                                fontSize: 14.0,
                                                fontWeight: FontWeight.normal))
                                      ])),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: 6.0, bottom: 6.0),
                            margin: EdgeInsets.only(left: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(right: 10.0),
                                  height: 15.0,
                                  width: 15.0,
                                  child: Image.asset(Assets.iconTag),
                                ),
                                Expanded(
                                  child: Text(
                                    AppFormat.moneyFormatDot
                                            .format(item.amount ?? 0) +
                                        " VND",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold),
                                    // maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )),

                    //     Container(
                    //   margin: EdgeInsets.only(bottom: 13.0, right: 10.0, top: 21.0),
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.end,
                    //     children: [
                    //       _actionItem(Assets.iconCalendar, Color(0xFF26A7AD), number: item?.relatedWork ?? 0, ontap: () async {
                    //         bool result =
                    //             await Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (context) => DetailDealScreen(
                    //                       deal_code: item.dealCode,
                    //                       indexTab: 1,
                    //                       id: 667,
                    //                     )));

                    //         if (result != null && result) {
                    //           getData(false);
                    //         }
                    //         print("1");
                    //       }),
                    //       _actionItem(Assets.iconOutdate, Color(0xFFDD2C00), number: item.appointment ?? 0, ontap: () async {
                    //         bool result =
                    //             await Navigator.of(context).push(MaterialPageRoute(
                    //                 builder: (context) => DetailDealScreen(
                    //                       deal_code: item.dealCode,
                    //                       indexTab: 1,
                    //                       id: 667,
                    //                     )));

                    //         if (result != null && result) {
                    //           getData(false);
                    //         }
                    //         print("2");
                    //       }),
                    //     ],
                    //   ),
                    // )
                    Container(
                      margin: EdgeInsets.only(right: 10.0),
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if ((checkVisibilityKey(
                                  VisibilityWidgetName.CM000008)))
                            Container(
                              margin: EdgeInsets.only(bottom: 12.0),
                              child: InkWell(
                                onTap: () async {
                                  if (item.phone != null && item.phone != "") {
                                    if (Global.callHotline != null) {
                                      Global.callHotline!({
                                        "id": item.dealId,
                                        "code": item.dealCode,
                                        "avatar": "",
                                        "name": item.dealName,
                                        "customer_name": item.customerName,
                                        "phone": item.phone,
                                        "type": item.typeCustomer,
                                      });
                                    }
                                  } else {
                                    DealConnection.showMyDialog(
                                        context, "Không có thông tin số điện thoại");
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(20.0 / 2),
                                  height: 45,
                                  width: 45,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(6, 166, 5, 1),
                                    borderRadius: BorderRadius.circular(50),
                                    // border:  Border.all(color: AppColors.white,)
                                  ),
                                  child: Center(
                                      child: Image.asset(
                                    Assets.iconCall,
                                    color: AppColors.white,
                                  )),
                                ),
                              ),
                            ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _actionItem(
                                  Assets.iconCalendar, Color(0xFF26A7AD),
                                  number: item?.relatedWork ?? 0,
                                  ontap: () async {
                                bool? result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => DetailDealScreen(
                                              deal_code: item.dealCode,
                                              indexTab: 1,
                                              id: 667,
                                            )));

                                if (result != null && result) {
                                  getData(false);
                                }
                                print("1");
                              }),
                              _actionItem(Assets.iconOutdate, Color(0xFFDD2C00),
                                  number: item.appointment ?? 0,
                                  ontap: () async {
                                bool? result = await Navigator.of(context)
                                    .push(MaterialPageRoute(
                                        builder: (context) => DetailDealScreen(
                                              deal_code: item.dealCode,
                                              indexTab: 1,
                                              id: 667,
                                            )));

                                if (result != null && result) {
                                  getData(false);
                                }
                                print("2");
                              }),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                item.tag!.length > 0
                    ? Container(
                        // width: AppSizes.maxWidth * 0.55,
                        padding:
                            EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                        child: Wrap(
                          children: List.generate(item.tag!.length,
                              (index) => _optionItem(item.tag![index])),
                          spacing: 10,
                          runSpacing: 10,
                        ),
                      )
                    : Container()
              ],
            ),
          ),
        ),
        // Positioned(
        //   right: 10,
        //   top: 50,
        //   child: InkWell(
        //     onTap: () async {
        //       print(item.phone);
        //       await callPhone(item?.phone ?? "");
        //     },
        //     child: Container(
        //       padding: EdgeInsets.all(20.0 / 2),
        //       height: 50,
        //       width: 50,
        //       decoration: BoxDecoration(
        //         color: Color.fromRGBO(6, 166, 5, 1),
        //         borderRadius: BorderRadius.circular(50),
        //         // border:  Border.all(color: AppColors.white,)
        //       ),
        //       child: Center(
        //           child: Image.asset(
        //         Assets.iconCall,
        //         color: AppColors.white,
        //       )),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _optionItem(TagData item) {
    return Container(
      padding: EdgeInsets.only(left: 4.0, right: 4.0),
      height: 24,
      decoration: BoxDecoration(
          color: Color(0x420067AC), borderRadius: BorderRadius.circular(5.0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 8.0,
              width: 8.0,
              margin: EdgeInsets.only(right: 5.0),
              decoration: BoxDecoration(
                  color: Color(0x790067AC),
                  borderRadius: BorderRadius.circular(1000.0))),
          Text(item.name!,
              style: TextStyle(
                  color: Color(0xFF0067AC),
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600))
        ],
      ),
    );
  }

  Widget _actionItem(String icon, Color color,
      {required num number, GestureTapCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
          margin: EdgeInsets.only(left: 14),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(1000.0)),
                child: Center(
                  child: Image.asset(
                    icon,
                    scale: 2.5,
                  ),
                ),
              ),
              (number > 0)
                  ? Positioned(
                      left: 30,
                      bottom: 30,
                      child: Container(
                        width: (number > 99)
                            ? 30
                            : (number > 9)
                                ? 25
                                : 22,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFFF45E38)),
                        child: Center(
                            child: Text((number > 10) ? "9+" : "${number ?? 0}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600))),
                      ))
                  : Container()
            ],
          )),
    );
  }

  Widget infoItem(String icon, String title, bool minWidth) {
    return Container(
      width: minWidth
          ? MediaQuery.of(context).size.width - 80
          : MediaQuery.of(context).size.width - 40,
      // height: 40,
      padding: const EdgeInsets.only(left: 5, bottom: 8.0),
      margin: EdgeInsets.only(left: 15.0 / 2, bottom: 8.0),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            height: 15.0,
            width: 15.0,
            child: Image.asset(icon),
          ),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.style14BlackWeight500,
              // maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}
