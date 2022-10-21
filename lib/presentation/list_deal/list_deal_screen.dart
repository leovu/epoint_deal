import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/filter_screen_model.dart';
import 'package:epoint_deal_plugin/model/request/list_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/branch_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_model_reponse.dart';
import 'package:epoint_deal_plugin/model/response/order_source_model_response.dart';
import 'package:epoint_deal_plugin/model/response/pipeline_model_response.dart';
import 'package:epoint_deal_plugin/presentation/create_deal/create_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/detail_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/filter_deal/filter_deal_screen.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ListDealScreen extends StatefulWidget {
  const ListDealScreen({Key key}) : super(key: key);

  @override
  _ListDealScreenState createState() => _ListDealScreenState();
}

class _ListDealScreenState extends State<ListDealScreen> {
  ScrollController _controller = ScrollController();
  final TextEditingController _searchtext = TextEditingController();
  final FocusNode _fonusNode = FocusNode();
  List<DealItems> items = <DealItems>[];

  List<PipelineData> pipeLineData = <PipelineData>[];
  List<OrderSourceData> orderSourceData = <OrderSourceData>[];
  List<BranchData> branchData = <BranchData>[];



  int currentPage = 1;
  int nextPage = 2;

  ListDealModelRequest filterModel = ListDealModelRequest(
      search: "",
      page: 1,
      orderSourceName: "",
      branchName: "",
      createdAt: "",
      closingDate: "",
      closingDueDate: "",
      pipelineName: "",
      journeyName: "");

  FilterScreenModel filterScreenModel = FilterScreenModel();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);

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
          id_closing_due_date: "");
      getData(false);
    });
  }

  getData(bool loadMore, {int page}) async {
    ListDealModelResponse model = await DealConnection.getList(
        context,
        ListDealModelRequest(
            search: _searchtext.text,
            page: filterModel.page,
            orderSourceName: filterModel.orderSourceName,
            branchName: filterModel.branchName,
            createdAt: filterModel.createdAt,
            closingDate: filterModel.closingDate,
            closingDueDate: filterModel.closingDueDate,
            pipelineName: filterModel.pipelineName,
            journeyName: filterModel.journeyName));
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
        items.addAll(model.data?.items);
      }
      currentPage = model.data?.pageInfo?.currentPage;
      nextPage = model.data?.pageInfo?.nextPage;
      setState(() {});
    } else {
      items = [];
      setState(() {});
    }
  }

  _scrollListener() async {
    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      if (this.currentPage < this.nextPage) {
        filterModel.page = currentPage + 1;
        getData(true);
      }
    }
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
          AppLocalizations.text(LangKey.listPotential),
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        leadingWidth: 20.0,
        actions: [  
          InkWell(
            onTap: () async {
              FilterScreenModel result =
                  await Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FilterDealCustomer(
                            filterScreenModel: filterScreenModel,
                            pipeLineData: pipeLineData,
                            branchData: branchData,
                          )
                        )
                      );
              print("bbbb");

              if (result != null) {
                filterModel = result.filterModel;
                print("aaaaa");
                filterModel.page = 1;
                getData(false);
              }
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
        onPressed: () async {
          //  ObjectPopDetailModel result = await LeadNavigator.push(context, CreatePotentialCustomer());

          var result = await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => CreateDealScreen()));

          if (result != null) {
            if (result.status) {
              getData(false);
            }
          }
        },
        child: const Icon(Icons.add),
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
            child: CustomListView(
              padding: EdgeInsets.all(20.0 / 2),
              physics: const AlwaysScrollableScrollPhysics(),
              controller: _controller,
              // separator: const Divider(),
              children: [
                (items == null || items?.length == 0)
                    ? CustomDataNotFound()
                    : Column(
                        children: items.map((e) => potentialItem(e)).toList()),
                Container(height: 100)
              ],
            ),
          ),
        ],
      ),
    );
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
                filterModel.page = 1;
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
            filterModel.page = 1;
            getData(false);
          }
          // },
          ),
    );
  }

  Widget potentialItem(DealItems item) {
    return Stack(
      children: [
        InkWell(
          onTap: () async {
            bool result = await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    DetailDealScreen(deal_code: item.dealCode)));

            if (result != null && result) {
              getData(false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
                color: Color(0xFFF6F6F7),
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Color(0xFFC3C8D3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(5.0),
                  margin: EdgeInsets.only(bottom: 8.0, left: 8.0),
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10.0),
                        height: 20.0,
                        width: 20.0,
                        child: Image.asset(Assets.iconDeal),
                      ),
                      Expanded(
                        child: Text(
                          item.dealName,
                          style: TextStyle(
                              fontSize: 16.0,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w500),
                          // maxLines: 1,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(15.0 / 1.5),
                        margin: EdgeInsets.only(right: 5),
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xFF11B482),
                            borderRadius: BorderRadius.circular(50)),
                        child: Center(
                          child: Text(
                            item.journeyName,
                            style: AppTextStyles.style14WhiteWeight400,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                infoItem(Assets.iconPerson, item?.customerName ?? "", false),
                infoItem(Assets.iconCall, item?.phone ?? "", false),
                infoItem(
                    Assets.iconChance,
                    "${item?.pipelineName ?? ""} - ${item?.journeyName ?? ""}",
                    false),
                infoItem(Assets.iconTime, item?.createdAt ?? "", false),
                infoItem(Assets.iconName, item?.staffFullName ?? "", true),
              ],
            ),
          ),
        ),
        Positioned(
          right: 10,
          bottom: 20,
          child: InkWell(
            onTap: () async {
              print(item.phone);
              await callPhone(item?.phone ?? "");
            },
            child: Container(
              padding: EdgeInsets.all(20.0 / 2),
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: Color(0xFF06A605),
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
      ],
    );
  }

  Widget infoItem(String icon, String title, bool minWidth) {
    return Container(
      width: minWidth
          ? MediaQuery.of(context).size.width - 80
          : MediaQuery.of(context).size.width - 40,
      // height: 40,
      padding: const EdgeInsets.only(left: 8, bottom: 8.0),
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

  Future<bool> callPhone(String phone) async {
    final regSpace = RegExp(r"\s+");
    // return await launchUrl(Uri.parse("tel:" + phone.replaceAll(regSpace, "")));
    return await launch("tel:" + phone.replaceAll(regSpace, ""));
  }
}
