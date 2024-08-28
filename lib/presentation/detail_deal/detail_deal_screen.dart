import 'dart:async';
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/model/response/care_deal_response_model.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/list_note_res_model.dart';
import 'package:epoint_deal_plugin/model/response/order_history_model_response.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/bloc/detail_deal_bloc.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/chat_screen.dart/chat_screen.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_data_not_found.dart';
import 'package:epoint_deal_plugin/widget/custom_info_item.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
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
        _bloc.getCareDeal(context);
        _bloc.getListNote(context);
        _bloc.getOrderHistory(context);

        // selectedTab(index);
        setState(() {});
      } else {
        await DealConnection.showMyDialog(context, dataDetail.errorDescription);
        Navigator.of(context).pop();
      }
    }
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
                padding: EdgeInsets.only(
                    bottom: AppSizes.maxHeight * 0.1 +
                        (index == 0 ? 0 : AppSizes.bottomHeight!)),
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
                    height: AppSizes.maxHeight * 0.11 +
                        (index == 0 ? 0 : AppSizes.bottomHeight!),
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

  // // thông tin chi tiết
  // Widget detailInformation() {
  //   return Container(
  //     padding: const EdgeInsets.all(8.0),
  //     margin: EdgeInsets.only(bottom: 20.0),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         // Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.customerVi)!,
  //           ((detail?.customerName == null || detail?.customerName == "")
  //               ? "N/A"
  //               : detail?.customerName!)!,
  //         ),
  //         Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.allottedPerson)!,
  //           ((detail?.staffName == null || detail?.staffName == "")
  //               ? "N/A"
  //               : detail?.staffName!)!,
  //         ),
  //         // Divider(),
  //         // _infoDetailItem(
  //         //   AppLocalizations.text(LangKey.product),
  //         //   detail?.productNameBuy ?? "N/A",
  //         // ),
  //         Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.expectedEndingDate)!,
  //           ((detail?.closingDate == null || detail?.closingDate == "")
  //               ? "N/A"
  //               : detail?.closingDate!)!,
  //         ),
  //         // Divider(),
  //         // _infoDetailItem(
  //         //   AppLocalizations.text(LangKey.actualEndDate),
  //         //   detail?.closingDueDate ?? "N/A",
  //         // ),
  //         // Divider(),
  //         // _infoDetailItem(
  //         //   AppLocalizations.text(LangKey.reasonForFailure),
  //         //   detail?.reasonLoseCode ?? "N/A",
  //         // ),
  //         Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.agency)!,
  //           ((detail?.branchName == null || detail?.branchName == "")
  //               ? "N/A"
  //               : detail?.branchName!)!,
  //         ),
  //         Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.orderSource)!,
  //           ((detail?.orderSourceName == null || detail?.orderSourceName == "")
  //               ? "N/A"
  //               : detail?.orderSourceName!)!,
  //         ),
  //         Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.probability)!,
  //           "${detail?.probability ?? 0} %",
  //         ),
  //         Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.dealDetail)!,
  //           ((detail?.dealDescription == null || detail?.dealDescription == "")
  //               ? "N/A"
  //               : detail?.dealDescription!)!,
  //         ),
  //         Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.dateCreated)!,
  //           ((detail?.createdAt == null || detail?.createdAt == "")
  //               ? "N/A"
  //               : detail?.createdAt!)!,
  //         ),
  //         Divider(),
  //         _infoDetailItem(
  //           AppLocalizations.text(LangKey.lastModifiedDate)!,
  //           ((detail?.updatedAt == null || detail?.updatedAt == "")
  //               ? "N/A"
  //               : detail?.updatedAt!)!,
  //         ),
  //         Divider(),
  //       ],
  //     ),
  //   );
  // }

  Widget _infoDetailItem(String title, String content, {TextStyle? style}) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 2,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    title,
                    style: AppTextStyles.style15BlackNormal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Text(
            content,
            style: style ?? AppTextStyles.style15BlackNormal,
            // maxLines: 1,
          )),
        ],
      ),
    );
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
            icon: Assets.iconDeal,
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
            icon: Assets.iconProbability,
            title:
                "Doanh thu kỳ vọng: ${NumberFormat("#,###", "vi-VN").format(detail!.amount ?? 0)} VNĐ",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconProbability,
            title: "Số tiền: ${detail!.probability ?? NULL_VALUE}",
          ),
          Gaps.vGap4,
          CustomRowImageContentWidget(
            icon: Assets.iconProbability,
            title: "Tỉ lệ thành công: ${detail!.probability ?? NULL_VALUE}",
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
              "Đây là một ghi chú",
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
            title: detail?.phone,
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

          if (model != null && _bloc.children == null) {
             _bloc.children = [];
            _bloc.children!.add(_buildLisNote());
          _bloc.children!.add(SizedBox(height: AppSizes.minPadding / 2));
          _bloc.children!.add(_buildListCustomerCare());
          _bloc.children!.add(SizedBox(height: AppSizes.minPadding / 2));
          _bloc.children!.add(_buildListOrderHistory());
          }

          return Column(
            children: [
              if (_bloc.children != null) ..._bloc.children!,
            ],
          );

          // return ContainerDataBuilder(
          //   data: model,
          //   skeletonBuilder: _buildSkeleton(),
          //   bodyBuilder: () {
          //     if (_bloc.children == null && model!.tabConfigs != null) {
          //         _bloc.children = [];
          //       for (var e in model.tabConfigs!) {
          //         switch (e.code) {
          //           case leadConfigDeal:
          //             _bloc.children!.add(_buildListDeal(e));
          //             _bloc.children!.add(SizedBox(height: AppSizes.minPadding/2));
          //             break;
          //           case leadConfigCustomerCare:
          //             _bloc.children!.add(_buildListCustomerCare(e));
          //             _bloc.children!.add(SizedBox(height: AppSizes.minPadding/2));
          //             break;
          //           case leadConfigContact:
          //             _bloc.children!.add(_buildListContact(e));
          //             break;
          //         }
          //       }
          //     }
          //     return Column(
          //       children: [
          //         if (_bloc.children != null) ..._bloc.children!,
          //       ],
          //     );
          //   },
          // );
        });
  }

  Widget _buildLisNote() {
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
                  title: "Ghi chú",
                  isExpand: _bloc.expandListNote,
                  // onTapList: _bloc.onTapListDeal,
                  onTapPlus: () => print("onTapPlus"),
                  quantity: _bloc.listNoteData.length,
                  child: CustomListView(
                    padding: EdgeInsets.only(
                        top: AppSizes.minPadding, bottom: AppSizes.minPadding),
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

  Widget _buildListCustomerCare() {
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
                  onTapPlus: () => print("onTapPlus"),
                  // onTapList: _bloc.onTapListCustomerCare,
                  title: "Chăm sóc khách hàng",
                  isExpand: _bloc.expandCareDeal,
                  quantity:_bloc.listCareDeal.length,
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

  Widget _buildListOrderHistory() {
    return StreamBuilder(
        stream: _bloc.outputExpandOrderHistory,
        initialData: _bloc.expandOrderHistory,
        builder: (_, snapshot) {
          _bloc.expandOrderHistory = snapshot.data as bool;
          return StreamBuilder(
              stream: _bloc.outputOrderHistory,
              initialData: _bloc.listOrderHistory,
              builder: (context, snapshot) {
                _bloc.listOrderHistory =
                    snapshot.data as List<OrderHistoryData>;
                return CustomComboBox(
                  onChanged: (event) =>
                      _bloc.onSetExpand(() => _bloc.expandOrderHistory = event),
                  onTapPlus: () => print("onTapPlus"),
                  // onTapList: _bloc.onTapListOrderHistory,
                  title: "Lịch sử đơn hàng",
                  isExpand: _bloc.expandOrderHistory,
                  quantity: _bloc.listOrderHistory.length,
                  child: CustomListView(
                    padding: EdgeInsets.only(
                        top: AppSizes.minPadding, bottom: AppSizes.minPadding),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    children: _bloc.listOrderHistory!
                        .map((e) => orderHistoryItem(e))
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

  Widget infoProductBuy() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 8.0, right: 8.0),
          margin: EdgeInsets.only(bottom: 8.0),
          child: (detail!.productBuy != null && detail!.productBuy!.length > 0)
              ? Column(
                  children: detail!.productBuy!
                      .map((e) => infoProductButyItem(e))
                      .toList())
              : Center(child: CustomDataNotFound()),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.text(LangKey.discount)!,
                  style: TextStyle(
                      fontSize: AppTextSizes.size14,
                      color: AppColors.bluePrimary,
                      fontWeight: FontWeight.bold)),
              Text(
                  AppFormat.moneyFormatDot.format(detail!.discount ?? 0) +
                      " VND",
                  style: TextStyle(
                      fontSize: AppTextSizes.size14,
                      color: AppColors.bluePrimary,
                      fontWeight: FontWeight.w500))
            ],
          ),
        )
      ],
    );
  }

  Widget infoProductButyItem(ProductBuy item) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RichText(
                  text: TextSpan(
                      text: "${item.quantity ?? 0}x ",
                      style: TextStyle(
                          fontSize: AppTextSizes.size15,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.normal),
                      children: [
                    TextSpan(
                        text: item.objectName ?? "N/A",
                        style: TextStyle(color: Colors.black))
                  ])),
            ),
            Text(
              AppFormat.moneyFormatDot.format(item.amount ?? 0) + " VND",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 14.0,
                  fontWeight: FontWeight.bold),
              // maxLines: 1,
            )
          ],
        ),
        (item != detail!.productBuy!.last)
            ? Divider(
                color: Colors.black,
              )
            : Container()
      ],
    );
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

  Widget infoItem(String icon, String title) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8.0),
      margin: EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 5.0),
            height: 15.0,
            width: 15.0,
            child: Image.asset(icon),
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal),
              // maxLines: 1,
            ),
          ),
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
          var result = await Global.editJob!(item.manageWorkId);
          if (result != null && result) {
            allowPop = true;
            reloadCSKH = true;
            await getData();
            selectedTab(1);
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
                                item.manageTypeWorkName ?? "N/A",
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
                              name: item.staffFullName ?? "N/A",
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
                                  item.staffFullName ?? "N/A",
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

  Widget _actionItem(String icon, Color color,
      {required num number, GestureTapCallback? ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
          margin: EdgeInsets.only(left: 8.0),
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
                            child: Text((number > 9) ? "9+" : "${number ?? 0}",
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
    return Column(
      children: [
        Text(
          model.content ?? "",
          style: AppTextStyles.style14BlackNormal,
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
                  parseAndFormatDate(date, format: AppFormat.formatDateTime),
                  style: AppTextStyles.style14HintNormal,
                ),
              ],
            )),
            if (index != 0) ...[
              SizedBox(
                width: AppSizes.minPadding,
              ),
              CustomIndex(index: index)
            ]
          ],
        ),
      ],
    );
  }

  Widget orderHistoryItem(OrderHistoryData item) {
    return Container(
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
                      icon: Assets.iconDeal, title: item.orderCode ?? "N/A")),
              Container(
                height: 24,
                // width: 55,
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                // margin: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                    color: Color(0xFF11B482),
                    borderRadius: BorderRadius.circular(50.0)),
                child: Center(
                  child: Text(item.processStatusName ?? "N/A",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
          CustomInfoItem(icon: Assets.iconTime, title: item.createdAt ?? "N/A"),
          CustomInfoItem(
              icon: Assets.iconBranch, title: item.branchName ?? "N/A"),
          CustomInfoItem(
              icon: Assets.iconShipper,
              title:
                  "${AppLocalizations.text(LangKey.ship)} - ${item.deliveryRequestDate ?? "N/A"}"),
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
                    AppFormat.moneyFormatDot.format(item.amount ?? 0) + " VND",
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
    );
  }

  Widget _phoneNumberItem() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 2.1,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    AppLocalizations.text(LangKey.phoneNumber)!,
                    style: AppTextStyles.style15BlackNormal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(detail?.phone ?? "",
                style: AppTextStyles.style16BlueWeight500),
          ),
          InkWell(
            onTap: () {
              callPhone(detail?.phone ?? "");
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: 30,
              width: 30,
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
        ],
      ),
    );
  }

  // Future<bool> callPhone(String phone) async {
  //   final regSpace = RegExp(r"\s+");
  //   // return await launchUrl(Uri.parse("tel:" + phone.replaceAll(regSpace, "")));
  //   return await launch("tel:" + phone.replaceAll(regSpace, ""));
  // }

  Widget _listButtonRelevant() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.minPadding),
      child: Row(
        children: [
          Flexible(
            child: CustomButton(
              style: AppTextStyles.style15WhiteNormal
                  .copyWith(fontWeight: FontWeight.bold),
              height: AppSizes.sizeOnTap,
              text: "Chỉnh sửa",
              onTap: () async {},
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
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _listButtonInfo() {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.minPadding),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: CustomButton(
                    style: AppTextStyles.style15WhiteNormal
                        .copyWith(fontWeight: FontWeight.bold),
                    height: AppSizes.sizeOnTap,
                    text: "Chuyển đổi KH",
                    onTap: () {},
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
                    text: "Cập nhật liên hệ",
                    onTap: () {},
                  ),
                )
              ],
            ),
            SizedBox(
              height: AppSizes.minPadding,
            ),
            Flexible(
              child: CustomButton(
                style: AppTextStyles.style15WhiteNormal
                    .copyWith(fontWeight: FontWeight.bold),
                isExpand: true,
                height: AppSizes.sizeOnTap,
                text: "Thêm cơ hội bán hàng",
                onTap: () {},
              ),
            ),
          ],
        ));
  }

  Widget _buildAvatar(String name) {
    return Container(
      width: 87.0,
      height: 87.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: AppColors.primaryColor,
        ),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000.0),
        child: CustomAvatarDetail(
          color: Color(0xFFEEB132),
          name: name,
          textSize: 36.0,
        ),
      ),
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
