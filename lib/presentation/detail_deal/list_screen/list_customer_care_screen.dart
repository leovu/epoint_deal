import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/care_deal_response_model.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/bloc/detail_deal_bloc.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/list_screen/list_customer_care_bloc.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class ListCustomerCareScreen extends StatefulWidget {
  final DetailDealBloc bloc;

  const ListCustomerCareScreen({super.key, required this.bloc});

  @override
  ListCustomerCareScreenState createState() => ListCustomerCareScreenState();
}

class ListCustomerCareScreenState extends State<ListCustomerCareScreen> {
  late ListCustomerCareBloc _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ListCustomerCareBloc(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc.listCareDeal = widget.bloc.listCareDeal;
      _bloc.setCareDeal(widget.bloc.listCareDeal);
      _bloc.getStatusWork();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    widget.bloc.dispose();
    super.dispose();
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.vGap10,
          _buildCustomerType(),
          Gaps.vGap10,
          _buildListOption(),
          Gaps.vGap10,
          Expanded(child: _buildContent())
        ],
      ),
    );
  }

  Widget _buildContent() {
    return StreamBuilder(
        stream: _bloc.outputCareDeal,
        initialData: null,
        builder: (_, snapshot) {
          List<CareDealData>? models = snapshot.data as List<CareDealData>?;
          return ContainerDataBuilder(
              data: models,
              skeletonBuilder: _buildSkeleton(),
              emptyBuilder: CustomEmpty(
                title: AppLocalizations.text(LangKey.data_empty),
              ),
              bodyBuilder: () => _buildContainer(models!
                  .map((e) => customerCareItem(
                        e,
                      ))
                  .toList()));
        });
  }

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      padding: EdgeInsets.all(AppSizes.minPadding),
      separator: SizedBox(height: AppSizes.minPadding),
      children: children,
    );
  }

  Widget _buildListOption() {
    return CustomRowInformation(
        title: AppLocalizations.text(LangKey.list),
        titleStyle: AppTextStyles.style14PrimaryBold,
        child: StreamBuilder(
            stream: _bloc.outputStatusWorkData,
            initialData: null,
            builder: (context, snapshot) {
              return CustomDropdown(
                value: _bloc.statusWorkDataSelected,
                menus: _bloc.statusWorkData,
                hint: "Chọn trạng thái",
                onChanged: (p0) {
                  _bloc.onChange(p0!);
                },
                onRemove: () {
                  _bloc.onRemove();
                },
              );
            }));
  }

  Widget _buildSkeleton() {
    return LoadingWidget(
        padding: EdgeInsets.zero,
        child: CustomListView(
          children: List.generate(
              10,
              (index) => CustomSkeleton(
                    height: 100,
                    radius: 4.0,
                  )),
        ));
  }

  _buildCustomerType() {
    return RichText(
        text: TextSpan(
            text: widget.bloc.detail?.typeCustomer == "customer"
                ? "${AppLocalizations.text(LangKey.customerVi)} - "
                : "${AppLocalizations.text(LangKey.sales_leads)} - ",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
            children: [
          TextSpan(
              text: widget.bloc.detail?.dealName,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold))
        ]));
  }

  Widget customerCareItem(CareDealData item) {
    final createTime = DateTime.parse(item.createdAt ?? "");

    return InkWell(
      onTap: () async {
        if (Global.editJob != null) {
          var result = await Global.editJob!(item.manageWorkId ?? 0);
          if (result != null) {
            widget.bloc.getCareDeal(context).then((value) {
              if (value != null) {
                _bloc.onRemove();
                _bloc.setCareDeal(widget.bloc.listCareDeal);
              }
            });
          }
        }
      },
      child: Container(
        child: Container(
          // margin: EdgeInsets.all(10),
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
                                url: item.manageTypeWorkIcon ??
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
                                  "${item.countFile}",
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
                                  "${item.countComment}",
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
                                  "${item.daysLate}",
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
                                children: List.generate(
                                    item.listTag!.length,
                                    (index) => _tagItemCustomCare(
                                        item.listTag![index])),
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

  Widget _tagItemCustomCare(ListTagCareDeal item) {
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.care_list),
      body: _buildBody(),
      onWillPop: () => CustomNavigator.pop(context, object: false),
    );
  }
}
