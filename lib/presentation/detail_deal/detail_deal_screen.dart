import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/request/assign_revoke_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/response/care_deal_response_model.dart';
import 'package:epoint_deal_plugin/model/response/description_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_deal_file_response_model.dart';
import 'package:epoint_deal_plugin/model/response/list_note_res_model.dart';
import 'package:epoint_deal_plugin/model/response/order_history_model_response.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/bloc/detail_deal_bloc.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/chat_screen.dart/chat_screen.dart';
import 'package:epoint_deal_plugin/presentation/edit_deal/edit_deal_screen.dart';
import 'package:epoint_deal_plugin/presentation/pick_one_staff_screen/ui/pick_one_staff_screen.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/utils/visibility_api_widget_name.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_info_item.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class DetailDealScreen extends StatefulWidget {
  String? deal_code;
  int? indexTab;
  bool? customerCare;
  int? id;
  Function(int)? onCallback;
  DetailDealScreen(
      {Key? key,
      this.deal_code,
      this.indexTab,
      this.customerCare,
      this.id,
      this.onCallback})
      : super(key: key);

  @override
  _DetailDealScreenState createState() => _DetailDealScreenState();
}

class _DetailDealScreenState extends State<DetailDealScreen> {
  final ScrollController _controller = ScrollController();
  List<WorkListStaffModel> models = [];
  DetailDealData? detail;
  bool allowPop = false;
  bool reloadCSKH = false;
  late DetailDealBloc _bloc;

  int index = 0;

  List<DetailPotentialTabModel> tabDeal = [
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.connection),
        typeID: 0,
        selected: true),
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.generalInfomation),
        typeID: 1,
        selected: false),
  ];

  List<OrderHistoryData>? orderHistorys;
  List<CareDealData>? customerCareDeal;

  final formatter = NumberFormat.currency(
    locale: 'vi_VN',
    decimalDigits: 0,
    symbol: '',
  );

  @override
  void initState() {
    super.initState();
    _bloc = DetailDealBloc(context);
    index = widget.indexTab ?? 0;
    for (int i = 0; i < tabDeal.length; i++) {
      if (index == tabDeal[i].typeID) {
        tabDeal[i].selected = true;
      } else {
        tabDeal[i].selected = false;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
  }

  getData() async {
    var dataDetail =
        await DealConnection.getdetailDeal(context, widget.deal_code);
    if (dataDetail != null) {
      if (dataDetail.errorCode == 0) {
        detail = dataDetail.data;
        _bloc.detail = detail;
        _bloc.setModel(detail);
        _bloc.setListProductBuy(detail!.productBuy ?? []);
        _bloc.getCareDeal(context);
        _bloc.getListNote(context);
        _bloc.getOrderHistory(context);
        _bloc.getListFile(context);

        // selectedTab(index);
        setState(() {});
      } else {
        await DealConnection.showMyDialog(context, dataDetail.errorDescription);
        Navigator.of(context).pop();
      }
    }
  }

  String getNameFromPath(String path) {
    String event = path ?? "";
    return event.contains("/") ? event.split("/").last : event;
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  Widget buildBody() {
    return (detail == null)
        ? Container()
        : Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: AppSizes.maxHeight * 0.1),
                child: Column(
                  children: [
                    buildListOption(),
                    Expanded(
                        child: ListView(
                      padding: EdgeInsets.zero,
                      physics: AlwaysScrollableScrollPhysics(),
                      controller: _controller,
                      children: buildInfomation(),
                    )),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: AppSizes.maxHeight * 0.1,
                    child: (index == 0)
                        ? _listButtonRelevant()
                        : _listButtonInfo()),
              )
            ],
          );
  }

  Widget buildListOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        option(tabDeal[0].typeName!, tabDeal[0].selected!, 100, () {
          index = 0;
          selectedTab(0);
        }),
        option(tabDeal[1].typeName!, tabDeal[1].selected!, 100, () async {
          index = 1;
          selectedTab(1);
        }),
      ],
    );
  }

  selectedTab(int index) async {
    List<DetailPotentialTabModel> models = tabDeal;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;

    setState(() {});
  }

  Widget option(
      String title, bool show, double width, GestureTapCallback ontap) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15.0 / 1.5),
          height: 40,
          child: InkWell(
            onTap: ontap,
            child: Center(
              child: Text(
                title,
                style: show
                    ? TextStyle(
                        fontSize: AppTextSizes.size16,
                        color: AppColors.blueColor,
                        fontWeight: FontWeight.bold)
                    : TextStyle(
                        fontSize: AppTextSizes.size16,
                        color: AppColors.colorTabUnselected,
                        fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
        ),
        show
            ? Container(
                decoration: const BoxDecoration(color: AppColors.blueColor),
                width: width,
                height: 3.0,
              )
            : Container()
      ],
    );
  }

  List<Widget> buildInfomation() {
    return [(index == 0) ? listInfomationRelevant() : infomation()];
  }

  Widget infomation() {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomInformationDealWidget(
            name: detail?.dealName ?? "",
            type: detail!.typeCustomer == "customer"
                ? AppLocalizations.text(LangKey.customer)
                : AppLocalizations.text(LangKey.sales_leads),
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconDeal,
            title:
                "${AppLocalizations.text(LangKey.dealCode)} : ${detail?.dealCode ?? NULL_VALUE}",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconPerson,
            title:
                "${AppLocalizations.text(LangKey.allottedPerson)} : ${detail?.staffName ?? NULL_VALUE}",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconCall,
            title: detail?.phone,
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconStyleCustomer,
            title: detail!.dealName ?? NULL_VALUE,
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconPin,
            title:
                "${AppLocalizations.text(LangKey.pipeline)}: ${detail!.pipelineCode ?? NULL_VALUE}",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconStatus,
            title:
                "${AppLocalizations.text(LangKey.journeys)}: ${detail!.journeyName ?? NULL_VALUE}",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconTime,
            title:
                "${AppLocalizations.text(LangKey.expectedEndingDate)!}: ${detail!.closingDate ?? NULL_VALUE}",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconOrderSource,
            title:
                "${AppLocalizations.text(LangKey.deal_source)!}: ${detail!.orderSourceName ?? NULL_VALUE}",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconBranch,
            title:
                "${AppLocalizations.text(LangKey.branch)!}: ${detail!.branchName ?? NULL_VALUE}",
          ),
          if (detail?.tag != null && (detail?.tag!.length ?? 0) > 0)
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  Assets.iconTag,
                  scale: 3.0,
                ),
                SizedBox(width: AppSizes.minPadding),
                Expanded(
                  child: Container(
                    child: Wrap(
                      children: List.generate(detail!.tag!.length,
                          (index) => _tagDetail(detail!.tag![index])),
                      spacing: 10,
                      runSpacing: 10,
                    ),
                  ),
                ),
              ],
            ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconProjectName,
            title:
                "Doanh thu kỳ vọng: ${NumberFormat("#,###", "vi-VN").format(detail!.expectedRevenue ?? 0)} VNĐ",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconMoneySquare,
            title:
                "Số tiền: ${NumberFormat("#,###", "vi-VN").format(detail!.amount ?? 0)} VNĐ",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconProbability,
            title: "Tỉ lệ thành công: ${detail!.probability ?? NULL_VALUE}%",
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              "Ghi chú",
              style: AppTextStyles.style14PrimaryBold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              detail!.dealDescription ?? NULL_VALUE,
              style: AppTextStyles.style14BlackNormal,
            ),
          )
        ],
      ),
    );
  }

  Widget listInfomationRelevant() {
    return Padding(
      padding: EdgeInsets.all(AppSizes.minPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          probability(),
          SizedBox(
            height: AppSizes.minPadding,
          ),
          RichText(
              text: TextSpan(
                  text: detail?.typeCustomer == "customer"
                      ? "${AppLocalizations.text(LangKey.customer)} - "
                      : "${AppLocalizations.text(LangKey.sales_leads)} - ",
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                  children: [
                TextSpan(
                    text: detail?.dealName,
                    style: TextStyle(
                        color: AppColors.primaryColor,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold))
              ])),
          SizedBox(
            height: AppSizes.minPadding,
          ),
          CustomRowImageContentWidget(
            icon: Assets.iconCall,
            title: hidePhone(detail?.phone ?? NULL_VALUE,
                checkVisibilityKey(VisibilityWidgetName.CM000004)),
          ),
          CustomRowImageContentWidget(
            icon: Assets.iconInteraction,
            child: RichText(
                text: TextSpan(
                    text: detail?.dateLastCare ?? NULL_VALUE,
                    style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                        fontWeight: FontWeight.normal),
                    children: [
                  TextSpan(
                      text: "(${detail?.diffDay ?? NULL_VALUE} ngày)",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14.0,
                          fontWeight: FontWeight.normal))
                ])),
          ),
          infomationRelevant()
        ],
      ),
    );
  }

  Widget infomationRelevant() {
    return StreamBuilder(
        stream: _bloc.outputModel,
        initialData: null,
        builder: (_, snapshot) {
          DetailDealData? model = snapshot.data as DetailDealData?;
          return (model != null)
              ? Container(
                  child: ContainerDataBuilder(
                    data: model,
                    skeletonBuilder: _buildSkeleton(),
                    bodyBuilder: () {
                      if (_bloc.children == null && model.tabConfigs != null) {
                        _bloc.children = [];
                        for (var e in model.tabConfigs!) {
                          switch (e.code) {
                            case dealConfigOrder:
                              _bloc.children!.add(_buildListOrderHistory(e));
                              _bloc.children!.add(
                                  SizedBox(height: AppSizes.minPadding / 2));
                              break;
                            case dealConfigCustomerCare:
                              _bloc.children!.add(_buildListCustomerCare(e));
                              _bloc.children!.add(
                                  SizedBox(height: AppSizes.minPadding / 2));
                              break;
                            case dealConfigNote:
                              _bloc.children!.add(_buildLisNote(e));
                              _bloc.children!.add(
                                  SizedBox(height: AppSizes.minPadding / 2));
                              break;
                            case dealConfigFile:
                              _bloc.children!.add(_buildListDealFile(e));
                              _bloc.children!.add(
                                  SizedBox(height: AppSizes.minPadding / 2));
                              break;
                            case dealConfigProduct:
                              _bloc.children!.add(_buildListProduct(e));
                              _bloc.children!.add(
                                  SizedBox(height: AppSizes.minPadding / 2));
                              break;
                          }
                        }
                      }
                      return Column(
                        children: [
                          if (_bloc.children != null) ..._bloc.children!,
                        ],
                      );
                    },
                  ),
                )
              : Container();
        });
  }

  Widget _buildSkeleton() {
    return LoadingWidget(
        padding: EdgeInsets.zero,
        child: CustomListView(
          children: List.generate(
              3,
              (index) => CustomSkeleton(
                    height: 60,
                    radius: 4.0,
                  )),
        ));
  }

  Widget _buildLisNote(CustomerDetailConfigModel e) {
    return StreamBuilder(
        stream: _bloc.outputExpandListNote,
        initialData: _bloc.expandListNote,
        builder: (_, snapshot) {
          _bloc.expandListNote = snapshot.data as bool;
          return StreamBuilder(
              stream: _bloc.outputListNote,
              initialData: _bloc.listNoteData,
              builder: (context, snapshot) {
                _bloc.listNoteData = snapshot.data as List<NoteData>;
                return CustomComboBox(
                  onChanged: (event) =>
                      _bloc.onSetExpand(() => _bloc.expandListNote = event),
                  title: e.tabNameVi ?? "Ghi chú",
                  isExpand: _bloc.expandListNote,
                  onTapList: _bloc.onTapListNote,
                  onTapPlus: () {
                    _bloc.onAddNote(() {
                      _bloc.getListNote(context);
                    });
                  },
                  quantity: _bloc.listNoteData.length,
                  child: CustomListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.minPadding / 2,
                        vertical: AppSizes.minPadding / 2),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: List.generate(
                        _bloc.listNoteData.length,
                        (index) => noteItem(
                              _bloc.listNoteData[index],
                              index,
                            )).toList(),
                  ),
                );
              });
        });
  }

  Widget _buildListCustomerCare(CustomerDetailConfigModel e) {
    return StreamBuilder(
        stream: _bloc.outputExpandCareDeal,
        initialData: _bloc.expandCareDeal,
        builder: (_, snapshot) {
          _bloc.expandCareDeal = snapshot.data as bool;
          return StreamBuilder(
              stream: _bloc.outputCareDeal,
              initialData: _bloc.listCareDeal,
              builder: (context, snapshot) {
                _bloc.listCareDeal = snapshot.data as List<CareDealData>;
                return CustomComboBox(
                  onChanged: (event) =>
                      _bloc.onSetExpand(() => _bloc.expandCareDeal = event),
                  onTapPlus: () async {
                    if (Global.createCare != null) {
                      var result =
                          await Global.createCare!(_bloc.detail!.toJson());
                      if (result != null) {
                        allowPop = true;
                        getData();
                      }
                    }
                  },
                  onTapList: _bloc.onTapListCustomerCare,
                  title: e.tabNameVi ?? "Chăm sóc khách hàng",
                  isExpand: _bloc.expandCareDeal,
                  quantity: _bloc.listCareDeal.length,
                  child: CustomListView(
                    padding: EdgeInsets.only(
                        top: AppSizes.minPadding, bottom: AppSizes.minPadding),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _bloc.listCareDeal
                        .map((e) => customerCareItem(e))
                        .toList(),
                  ),
                );
              });
        });
  }

  Widget _buildListOrderHistory(CustomerDetailConfigModel e) {
    return StreamBuilder(
        stream: _bloc.outputExpandOrderHistory,
        initialData: _bloc.expandOrderHistory,
        builder: (_, snapshot) {
          _bloc.expandOrderHistory = snapshot.data as bool;
          return StreamBuilder(
              stream: _bloc.outputListOrderHistory,
              initialData: _bloc.listOrderHistory,
              builder: (context, snapshot) {
                _bloc.listOrderHistory =
                    snapshot.data as List<OrderHistoryData>;
                return CustomComboBox(
                  isShowPlus: _bloc.listOrderHistory.length == 0,
                  onChanged: (event) =>
                      _bloc.onSetExpand(() => _bloc.expandOrderHistory = event),
                  onTapPlus: () async {
                    if ((_bloc.detail?.productBuy?.length ?? 0) > 0) {
                      DealConnection.showMyDialogWithFunction(context,
                        "Bạn có chắc chắn muốn tạo đơn cho ${detail?.dealCode}",
                        ontap: () async {
                           Navigator.of(context).pop();
                      _bloc.createOrder().then((value) {
                        if (value) {
                          allowPop = true;
                          _bloc.getOrderHistory(context);
                        }
                      });
                    });
                    } else {
                      DealConnection.showMyDialog(context,
                          "Vui lòng thêm sản phẩm/ dịch vụ trước khi tạo đơn hàng");
                    }
                  },
                  onTapList: _bloc.onTapListOrDerHistory,
                  title: e.tabNameVi ?? "Lịch sử đơn hàng",
                  isExpand: _bloc.expandOrderHistory,
                  quantity: _bloc.listOrderHistory.length,
                  child: CustomListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.minPadding / 2,
                        vertical: AppSizes.minPadding / 2),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _bloc.listOrderHistory
                        .map((e) => orderHistoryItem(e))
                        .toList(),
                  ),
                );
              });
        });
  }

  Widget _buildListDealFile(CustomerDetailConfigModel e) {
    return StreamBuilder(
        stream: _bloc.outputExpandListFile,
        initialData: _bloc.expandListFile,
        builder: (_, snapshot) {
          _bloc.expandListFile = snapshot.data as bool;
          return StreamBuilder(
              stream: _bloc.outputDealsFile,
              initialData: _bloc.listDealFiles,
              builder: (context, snapshot) {
                _bloc.listDealFiles = snapshot.data as List<DealFilesModel>;
                return CustomComboBox(
                  onChanged: (event) =>
                      _bloc.onSetExpand(() => _bloc.expandListFile = event),
                  onTapPlus: () {
                    _bloc.onAddFile();
                  },
                  onTapList: () {
                    _bloc.onTapListFile();
                  },
                  title: e.tabNameVi ?? "Tập tin",
                  isExpand: _bloc.expandListFile,
                  quantity: _bloc.listDealFiles.length,
                  child: CustomListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.minPadding / 2,
                        vertical: AppSizes.minPadding / 2),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _bloc.listDealFiles
                        .map(
                            (e) => _fileItem(e, _bloc.listDealFiles.indexOf(e)))
                        .toList(),
                  ),
                );
              });
        });
  }

  Widget _buildListProduct(CustomerDetailConfigModel e) {
    return StreamBuilder(
        stream: _bloc.outputExpandListProduct,
        initialData: _bloc.expandListProduct,
        builder: (_, snapshot) {
          _bloc.expandListProduct = snapshot.data as bool;
          return StreamBuilder(
              stream: _bloc.outputListProductBuy,
              initialData: null,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data == null) {
                  return Container();
                }
                List<ProductBuy> _listProduct =
                    snapshot.data as List<ProductBuy>;
                return CustomComboBox(
                  isShowPlus: false,
                  onChanged: (event) =>
                      _bloc.onSetExpand(() => _bloc.expandListProduct = event),
                  onTapPlus: () {},
                  onTapList: () {
                    _bloc.onTapListProduct();
                  },
                  title: e.tabNameVi ?? "Sản phẩm",
                  isExpand: _bloc.expandListProduct,
                  quantity: _listProduct.length,
                  child: CustomListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: AppSizes.minPadding / 2,
                        vertical: AppSizes.minPadding / 2),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _listProduct
                        .map((e) => _productItem(e, _listProduct.indexOf(e)))
                        .toList(),
                  ),
                );
              });
        });
  }

  Widget probability() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
            text: "",
            style: TextStyle(
                fontSize: 16.0,
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w700),
            children: [
              WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: Container(
                    // margin: EdgeInsets.only(right: 12.0),
                    decoration: BoxDecoration(
                        color: Color(0xFF3AEDB6),
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(detail!.journeyName ?? "",
                          style: TextStyle(
                              color: Color.fromARGB(255, 8, 88, 64),
                              fontSize: 14,
                              fontWeight: FontWeight.normal)),
                    ),
                  )),
              WidgetSpan(
                  child: SizedBox(
                width: 5.0,
              )),
              TextSpan(
                  text: "${detail?.probability ?? 0}%",
                  style: TextStyle(
                      fontSize: 15.0,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold)),
            ]));
  }

  Widget _tagDetail(TagData item) {
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

  Widget customerCare() {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: (customerCareDeal != null && customerCareDeal!.length > 0)
          ? Column(
              children:
                  customerCareDeal!.map((e) => customerCareItem(e)).toList())
          : Center(child: CustomDataNotFound()),
    );
  }

  Widget customerCareItem(CareDealData item) {
    final createTime = DateTime.parse(item.createdAt ?? "");
    return InkWell(
      onTap: () async {
        if (Global.editJob != null) {
          var result = await Global.editJob!(item.manageWorkId ?? 0);
          if (result != null) {
            allowPop = true;
            await getData();
          }
        }
      },
      child: Container(
        child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          // height: 300,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                child: SizedBox(
                  //Cái này là bên trái
                  width: MediaQuery.of(context).size.width / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${createTime.hour}:${createTime.minute}",
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '${createTime.day},\ntháng ${createTime.month},\nnăm ${createTime.year}',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                //Cai này là bên phải
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                    left: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Cái này là dòng tiêu đề
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text:
                                      "[${item.manageWorkCode}] ${item.manageWorkTitle}",
                                  style: TextStyle(
                                    color: Color(0xFF0067AC),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: ' ',
                                    ),
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.check_circle_outline_sharp,
                                      color: Colors.green,
                                      size: 16,
                                    )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        padding: EdgeInsets.only(left: 5.0, right: 5.0),
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 1),
                            blurRadius: 2,
                            color: Colors.black.withOpacity(0.3),
                          )
                        ], color: Colors.white),
                        child: Padding(
                          padding: EdgeInsets.all(6.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomNetworkImage(
                                width: 15,
                                height: 15,
                                url: item?.manageTypeWorkIcon ??
                                    "https://epoint-bucket.s3.ap-southeast-1.amazonaws.com/0f73a056d6c12b508a05eea29735e8a52022/07/14/3Ujo25165778317714072022.png",
                                fit: BoxFit.fill,
                                backgroundColor: Colors.transparent,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                item.manageTypeWorkName ?? NULL_VALUE,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                                // maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "${item.countFile ?? 0}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconFiles,
                                  scale: 3.0,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${item.countComment ?? 0}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconComment,
                                  scale: 3.0,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "${item.daysLate ?? 0}",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconTimeDetail,
                                  scale: 3.0,
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            CustomAvatarWithURL(
                              name: item.staffFullName ?? NULL_VALUE,
                              url: item.staffAvatar ?? "",
                              size: 50.0,
                            ),
                            Container(
                              width: 10.0,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.staffFullName ?? NULL_VALUE,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),

                      (item.listTag != null && item.listTag!.length > 0)
                          ? Container(
                              child: Wrap(
                                alignment: WrapAlignment.spaceAround,
                                children: List.generate(item.listTag!.length,
                                    (index) => _tagItem(item.listTag![index])),
                                spacing: 10,
                                runSpacing: 10,
                              ),
                            )
                          : Container()

                      //cái này là button gọi điện
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tagItem(ListTagCareDeal item) {
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 2,
          color: Colors.black.withOpacity(0.3),
        )
      ], color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.iconTag,
            scale: 3.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            item.tagName!,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w500),
            // maxLines: 1,
          )
        ],
      ),
    );
  }

  Widget orderHistory() {
    return Container(
      margin: EdgeInsets.only(bottom: 20, left: 8.0, right: 8.0),
      child: (orderHistorys != null && orderHistorys!.length > 0)
          ? Column(
              children: orderHistorys!.map((e) => orderHistoryItem(e)).toList())
          : Center(child: CustomDataNotFound()),
    );
  }

  Widget noteItem(NoteData model, int index) {
    String? name, date;

    if (model.createdByName != null) {
      name = model.createdByName ?? "";
      date = model.createdAt ?? "";
    }
    return CustomContainerList(
      child: Padding(
        padding: EdgeInsets.all(AppSizes.minPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              model.content ?? "",
              style: AppTextStyles.style14BlackWeight600,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: CustomListView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  children: [
                    Text(
                      name ?? "",
                      style: AppTextStyles.style14HintNormal,
                    ),
                    Text(
                      parseAndFormatDate(date,
                          format: AppFormat.formatDateTime),
                      style: AppTextStyles.style14HintNormal,
                    ),
                  ],
                )),
                SizedBox(
                  width: AppSizes.minPadding,
                ),
                CustomIndex(index: index)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _fileItem(DealFilesModel model, int index) {
    String? name, date;

    if (model.createdBy != null) {
      name = model.createdBy ?? "";
      date = model.createdAt ?? "";
    }
    return GestureDetector(
      onTap: () {
        _bloc.onOpenFile(model.fileName ?? "", model.path);
      },
      child: CustomContainerList(
        child: Padding(
          padding: EdgeInsets.all(AppSizes.minPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          pathToImage(model.path!)!,
                          width: 24,
                        ),
                        Container(
                          width: 5.0,
                        ),
                        Container(
                          child: AutoSizeText(
                            model.fileName!,
                            style: AppTextStyles.style14BlackNormal,
                            minFontSize: 1,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
              Text(
                model.content ?? "",
                style: AppTextStyles.style14BlackWeight600,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                      child: CustomListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    children: [
                      Text(
                        name ?? "",
                        style: AppTextStyles.style14HintNormal,
                      ),
                      Text(
                        parseAndFormatDate(date,
                            format: AppFormat.formatDateTime),
                        style: AppTextStyles.style14HintNormal,
                      ),
                    ],
                  )),
                  SizedBox(
                    width: AppSizes.minPadding,
                  ),
                  CustomIndex(index: index)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _productItem(ProductBuy model, int index) {
    return Container(
      padding: EdgeInsets.all(AppSizes.minPadding),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.0),
          boxShadow: [
            BoxShadow(
                color: AppColors.black.withOpacity(0.1),
                blurRadius: 10.0,
                offset: Offset(0, 2))
          ],
          border: Border.all(color: AppColors.grey100)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    CustomRowImageContentWidget(
                      paddingBottom: 8.0,
                      icon: Assets.iconDeal,
                      title: model.objectCode ?? NULL_VALUE,
                      titleStyle: AppTextStyles.style14PrimaryBold,
                    ),
                    CustomRowImageContentWidget(
                      paddingBottom: 0.0,
                      icon: Assets.iconTag,
                      title: formatMoney(model.amount!.toDouble()),
                      titleStyle: AppTextStyles.style14PrimaryBold,
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(16.0)),
                padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.minPadding * 1.5,
                    vertical: AppSizes.minPadding / 2),
                child:
                    Text("${index + 1}", style: AppTextStyles.style14WhiteBold),
              )
            ],
          ),
          Gaps.vGap8,
          Text(
            model.objectName ?? NULL_VALUE,
            textAlign: TextAlign.start,
            style: AppTextStyles.style12BlackNormal,
            // maxLines: 1,
          ),
          Gaps.vGap8,
          CustomRowInformation(
            title: formatMoney(model.price!.toDouble()),
            content: "${model.quantity}x",
          ),
          Gaps.vGap8,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomRowImageContentWidget(
                  icon: Assets.iconTag,
                  iconColor: Colors.orange,
                  title: formatMoney(model.discount!.toDouble()),
                  titleStyle: AppTextStyles.style14BlackNormal
                      .copyWith(color: Colors.orange),
                ),
              ),
              Text(
                model.unitName ?? NULL_VALUE,
                style: AppTextStyles.style12BlackNormal,
              ),
            ],
          ),
          Text(
            model.objectDescription ?? NULL_VALUE,
            textAlign: TextAlign.start,
            style: AppTextStyles.style12grey500Normal,
            // maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget orderHistoryItem(OrderHistoryData item) {
    return GestureDetector(
      onTap: () async {
        if (Global.navigateDetailOrder != null) {
          var result = await Global.navigateDetailOrder!(item.orderId ?? 0);
          if (result != null) {
            allowPop = true;
            _bloc.getOrderHistory(context);
          }
        }
      },
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 1),
                blurRadius: 2,
                color: Colors.black.withOpacity(0.3),
              )
            ]),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                    child: CustomInfoItem(
                        icon: Assets.iconDeal,
                        title: item.orderCode ?? NULL_VALUE)),
                Container(
                  height: 24,
                  // width: 55,
                  padding: EdgeInsets.only(left: 10.0, right: 10.0),
                  // margin: EdgeInsets.only(right: 8.0),
                  decoration: BoxDecoration(
                      color: Color(0xFF11B482),
                      borderRadius: BorderRadius.circular(50.0)),
                  child: Center(
                    child: Text(item.processStatusName ?? NULL_VALUE,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500)),
                  ),
                )
              ],
            ),
            CustomInfoItem(
                icon: Assets.iconTime, title: item.createdAt ?? NULL_VALUE),
            CustomInfoItem(
                icon: Assets.iconBranch, title: item.branchName ?? NULL_VALUE),
            CustomInfoItem(
                icon: Assets.iconShipper,
                title:
                    "${AppLocalizations.text(LangKey.ship)} - ${item.deliveryRequestDate ?? NULL_VALUE}"),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: CustomInfoItem(
                        icon: Assets.iconDeal,
                        title: "${item.countProd ?? 0} sản phẩm")),
                Row(
                  children: [
                    Image.asset(
                      Assets.iconTag,
                      scale: 2.5,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      AppFormat.moneyFormatDot.format(item.amount ?? 0) +
                          " VND",
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _listButtonRelevant() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.minPadding),
          child: Row(
            children: [
              Flexible(
                child: CustomButton(
                    style: AppTextStyles.style15WhiteNormal
                        .copyWith(fontWeight: FontWeight.bold),
                    height: AppSizes.sizeOnTap,
                    text: "Chỉnh sửa",
                    onTap: () async {
                      if (detail?.journeyCode != "PJD_DEAL_END") {
                        bool? result = await Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditDealScreen(detail: detail)));

                        if (result != null) {
                          if (result) {
                            allowPop = true;
                            getData();
                            ;
                          }
                        }
                      }
                    }),
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Flexible(
                child: CustomButton(
                  style: AppTextStyles.style15WhiteNormal
                      .copyWith(fontWeight: FontWeight.bold),
                  height: AppSizes.sizeOnTap,
                  text: AppLocalizations.text(LangKey.discuss),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ChatScreen(
                              detail: detail,
                            )));
                  },
                ),
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Flexible(
                child: CustomButton(
                  style: AppTextStyles.style15WhiteNormal
                      .copyWith(fontWeight: FontWeight.bold),
                  height: AppSizes.sizeOnTap,
                  text: "Liên hệ",
                  onTap: () {
                    if (detail?.phone != null && detail?.phone != "") {
                      if (Global.callHotline != null) {
                        Global.callHotline!({
                          "id": detail?.dealId,
                          "code": detail?.dealCode,
                          "avatar": "",
                          "name": detail?.dealName,
                          "customer_name": detail?.customerName,
                          "phone": detail?.phone,
                          "type": detail?.typeCustomer,
                        });
                      }
                    } else {
                      DealConnection.showMyDialog(
                          context, "Không có số điện thoại");
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(top: 0, left: 0, right: 0, child: Gaps.line(1)),
      ],
    );
  }

  Widget _listButtonInfo() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.minPadding),
            child: Row(
              children: [
                Flexible(
                  child: CustomButton(
                    backgroundColor: AppColors.redColor,
                    style: AppTextStyles.style15WhiteNormal
                        .copyWith(fontWeight: FontWeight.bold),
                    height: AppSizes.sizeOnTap,
                    text: "XÓA DEAL",
                    onTap: () {
                      DealConnection.showMyDialogWithFunction(context,
                          "${AppLocalizations.text(LangKey.warningDeleteDeal)} ${detail?.dealCode}",
                          ontap: () async {
                        DescriptionModelResponse? result =
                            await DealConnection.deleteDeal(
                                context, detail!.dealCode);
                        Navigator.of(context).pop();
                        if (result != null) {
                          if (result.errorCode == 0) {
                            await DealConnection.showMyDialog(
                                context, result.errorDescription);
                            allowPop = true;
                            CustomNavigator.pop(context, object: true);
                          } else {
                            DealConnection.showMyDialog(
                                context, result.errorDescription);
                          }
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  width: AppSizes.minPadding,
                ),
                Flexible(
                  child: CustomButton(
                    style: AppTextStyles.style15WhiteNormal
                        .copyWith(fontWeight: FontWeight.bold),
                    height: AppSizes.sizeOnTap,
                    text: (_bloc.detail?.saleId != null &&
                            _bloc.detail?.saleId != 0)
                        ? "THU HỒI"
                        : "PHÂN CÔNG",
                    onTap: () async {
                      if (detail?.saleId != null && detail?.saleId != 0) {
                        await _bloc
                            .assignRevokeDeal(AssignRevokeDealModelRequest(
                                dealCode: detail?.dealCode,
                                saleId: detail?.saleId ?? 0,
                                timeRevokeLead: detail?.timeRevokeLead ?? 0,
                                type: "revoke"))
                            .then((value) {
                          if (value) {
                            allowPop = true;
                            getData();
                          }
                        });
                      } else {
                        List<WorkListStaffModel>? models =
                            await Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => PickOneStaffScreen()));
                        if (models != null && models.length > 0) {
                          await _bloc
                              .assignRevokeDeal(AssignRevokeDealModelRequest(
                                  dealCode: detail?.dealCode,
                                  saleId: models[0].staffId,
                                  timeRevokeLead: detail?.timeRevokeLead ?? 0,
                                  type: "assign"))
                              .then((value) {
                            if (value) {
                              allowPop = true;
                              getData();
                            }
                          });
                        }
                      }
                    },
                  ),
                ),
              ],
            )),
        Positioned(top: 0, left: 0, right: 0, child: Gaps.line(1))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (allowPop) {
          Navigator.of(context).pop(allowPop);
        } else {
          Navigator.of(context).pop();
        }
        return allowPop;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppLocalizations.text(LangKey.detail_deal)!,
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          // leadingWidth: 20.0,
        ),
        body: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: buildBody()),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        // floatingActionButton: ExpandableDraggableFab(
        //   initialDraggableOffset:
        //       Offset(12, MediaQuery.of(context).size.height * 11 / 14),
        //   initialOpen: false,
        //   curveAnimation: Curves.easeOutSine,
        //   childrenBoxDecoration: BoxDecoration(
        //       color: Colors.black.withOpacity(0.35),
        //       borderRadius: BorderRadius.circular(10.0)),
        //   childrenCount: 3,
        //   distance: 10,
        //   childrenType: ChildrenType.columnChildren,
        //   childrenAlignment: Alignment.centerRight,
        //   childrenInnerMargin: EdgeInsets.all(20.0),
        //   openWidget: Container(
        //       decoration: BoxDecoration(boxShadow: [
        //         BoxShadow(
        //           offset: Offset(0, 1),
        //           blurRadius: 2,
        //           color: Colors.black.withOpacity(0.3),
        //         )
        //       ], shape: BoxShape.circle, color: AppColors.primaryColor),
        //       width: 60,
        //       height: 60,
        //       child: Image.asset(
        //         Assets.iconFABMenu,
        //         scale: 2.5,
        //       )),
        //   closeWidget: Container(
        //       decoration: BoxDecoration(boxShadow: [
        //         BoxShadow(
        //           offset: Offset(0, 1),
        //           blurRadius: 2,
        //           color: Colors.black.withOpacity(0.3),
        //         )
        //       ], shape: BoxShape.circle, color: Color(0xFF5F5F5F)),
        //       width: 60,
        //       height: 60,
        //       child: Icon(
        //         Icons.clear,
        //         size: 35,
        //         color: Colors.white,
        //       )),
        //   children: [
        //     Column(
        //       children: [
        //         FloatingActionButton(
        //             backgroundColor: Color(0xFF41AC8D),
        //             heroTag: "btn2",
        //             onPressed: () async {
        //               // if (Global.createJob != null) {
        //               //   await Global.createJob();
        //               // }

        //               bool result =
        //                   await (Navigator.of(context).push(MaterialPageRoute(
        //                       builder: (context) => CustomerCareDeal(
        //                             detail: detail,
        //                           ))));
        //               if (result) {
        //                 allowPop = true;
        //                 getData();
        //                 reloadCSKH = true;
        //                 index = 1;
        //                 selectedTab(1);
        //               }

        //               print("iconTask");
        //             },
        //             child: Image.asset(
        //               Assets.iconCustomerCare,
        //               scale: 2.5,
        //             )),
        //         SizedBox(
        //           height: 5.0,
        //         ),
        //         Text("CSKH",
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 14.0,
        //                 fontWeight: FontWeight.w400))
        //       ],
        //     ),
        //     Column(
        //       children: [
        //         FloatingActionButton(
        //             backgroundColor: Color(0xFFDD2C00),
        //             heroTag: "btn3",
        //             onPressed: () async {
        //               DealConnection.showMyDialogWithFunction(context,
        //                   AppLocalizations.text(LangKey.warningDeleteDeal),
        //                   ontap: () async {
        //                 DescriptionModelResponse? result =
        //                     await DealConnection.deleteDeal(
        //                         context, detail!.dealCode);

        //                 Navigator.of(context).pop();

        //                 if (result != null) {
        //                   if (result.errorCode == 0) {
        //                     print(result.errorDescription);

        //                     await DealConnection.showMyDialog(
        //                         context, result.errorDescription);
        //                     Navigator.of(context).pop(true);
        //                   } else {
        //                     DealConnection.showMyDialog(
        //                         context, result.errorDescription);
        //                   }
        //                 }
        //               });

        //               print("iconDelete");
        //             },
        //             child: Image.asset(
        //               Assets.iconDelete,
        //               scale: 2.5,
        //             )),
        //         SizedBox(
        //           height: 5.0,
        //         ),
        //         Text(AppLocalizations.text(LangKey.delete)!,
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 14.0,
        //                 fontWeight: FontWeight.w400))
        //       ],
        //     ),
        //     Column(
        //       children: [
        //         FloatingActionButton(
        //           heroTag: "btn4",
        //           onPressed: () async {
        //             // if (detail.journeyCode != "PJD_DEAL_END") {
        //             bool? result = await Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                     builder: (context) =>
        //                         EditDealScreen(detail: detail)));

        //             if (result != null) {
        //               if (result) {
        //                 allowPop = true;
        //                 selectedTab(index);
        //                 getData();
        //                 ;
        //               }
        //             }
        //             // }

        //             print("iconEdit");
        //           },
        //           backgroundColor: Color(0xFF00BE85),
        //           child: Image.asset(
        //             Assets.iconEdit,
        //             scale: 2.5,
        //           ),
        //         ),
        //         SizedBox(
        //           height: 5.0,
        //         ),
        //         Text(AppLocalizations.text(LangKey.edit)!,
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 14.0,
        //                 fontWeight: FontWeight.w400))
        //       ],
        //     )
        //   ],
        // ),
      ),
    );
  }
}

class DetailPotentialTabModel {
  String? typeName;
  int? typeID;
  bool? selected;

  DetailPotentialTabModel({this.typeName, this.typeID, this.selected});
}
