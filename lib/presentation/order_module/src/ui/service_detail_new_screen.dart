import 'package:auto_size_text/auto_size_text.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/request/service_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/response/service_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_new_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/service_detail_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/container_scrollable.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

import 'description_detail_screen.dart';

class ServiceDetailNewScreen extends StatefulWidget {
  final ServiceNewModel model;

  ServiceDetailNewScreen(this.model);

  @override
  ServiceDetailNewScreenState createState() => ServiceDetailNewScreenState();
}

class ServiceDetailNewScreenState extends State<ServiceDetailNewScreen> {
  final FocusNode _focusPrice = FocusNode();
  final TextEditingController _controllerPrice = TextEditingController();

  final FocusNode _focusQuantity = FocusNode();
  final TextEditingController _controllerQuantity = TextEditingController();

  final FocusNode _focusNote = FocusNode();
  final TextEditingController _controllerNote = TextEditingController();

  double _heightHeader = AppSizes.maxWidth! * 0.9;
  double _heightHeaderImage = (AppSizes.maxWidth! - AppSizes.maxPadding * 2) / 5;

  double _widthImageDescription = AppSizes.maxWidth! - AppSizes.maxPadding * 2;
  double _heightImageDescription = 100;

  late ServiceDetailBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ServiceDetailBloc(context);

    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => _onRefresh(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _focusPrice.dispose();
    _controllerPrice.dispose();
    _focusQuantity.dispose();
    _controllerQuantity.dispose();
    _focusNote.dispose();
    _controllerNote.dispose();
    _bloc.dispose();
    super.dispose();
  }

  Future _onRefresh({bool isRefresh = true}) {
    return _bloc.serviceDetail(
        ServiceDetailRequestModel(
          serviceId: widget.model.serviceId,
        ),
        isRefresh);
  }

  Widget _buildSkeletonHeader() {
    return CustomShimmer(
      child: Column(
        children: [
          CustomSkeleton(
            width: AppSizes.maxWidth,
            height: _heightHeader,
            radius: 0.0,
          ),
          Container(
            margin: EdgeInsets.all(AppSizes.maxPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomSkeleton(
                  height: 20.0,
                ),
                Container(
                  height: AppSizes.minPadding,
                ),
                CustomSkeleton(
                  height: 20.0,
                  width: AppSizes.maxWidth! / 2,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderImage(String? url) {
    return InkWell(
      child: CustomNetworkImage(
        width: _heightHeaderImage,
        height: _heightHeaderImage,
        url: url,
        fit: BoxFit.contain,
        backgroundColor: Colors.transparent,
      ),
      onTap: () => _bloc.setImage(url),
    );
  }

  Widget _buildHeader(ServiceDetailResponseModel? model) {
    if (model == null) return _buildSkeletonHeader();
    return Stack(
      children: [
        Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: StreamBuilder(
              stream: _bloc.outputImage,
              initialData: model.serviceAvatar,
              builder: (_, snapshot) {
                return CustomNetworkImage(
                  width: AppSizes.maxWidth,
                  height: _heightHeader,
                  url: snapshot.data as String?,
                  fit: BoxFit.contain,
                  backgroundColor: Colors.white,
                );
              },
            )),
        Container(
          margin: EdgeInsets.only(
              top: _heightHeader - _heightHeaderImage / 2,
              right: AppSizes.maxPadding,
              left: AppSizes.maxPadding,
              bottom: AppSizes.maxPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (model.serviceImages?.length ?? 0) == 0
                  ? Container(
                height: _heightHeaderImage / 2,
              )
                  : Container(
                height: _heightHeaderImage,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => _buildHeaderImage(
                        model.serviceImages![index].name),
                    separatorBuilder: (_, index) => Container(
                      width: AppSizes.minPadding,
                    ),
                    itemCount: model.serviceImages!.length > 5
                        ? 5
                        : model.serviceImages!.length),
              ),
              Container(
                height: AppSizes.minPadding,
              ),
              model.promotion == null
                  ? Container()
                  : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                          fit: FlexFit.loose,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    right: Radius.circular(50.0)),
                                color: Colors.red),
                            padding: EdgeInsets.all(AppSizes.minPadding),
                            child: AutoSizeText(
                              model.promotion == null
                                  ? ""
                                  : model.promotion!.gift != null
                                  ? model.promotion!.gift!
                                  : model.promotion!.price != null
                                  ? model.promotion!.price!
                                  : "",
                              style: AppTextStyles.style13WhiteNormal,
                              minFontSize: 4.0,
                            ),
                          ))
                    ],
                  ),
                  Container(
                    height: AppSizes.maxPadding,
                  ),
                ],
              ),
              Text(
                "${model.time ?? 0} ${AppLocalizations.text(LangKey.minutes)!.toUpperCase()}",
                style: AppTextStyles.style13HintNormal,
              ),
              Container(
                height: AppSizes.minPadding,
              ),
              Text(
                model.serviceName ?? "",
                style: AppTextStyles.style17BlackBold,
              ),
              Container(
                height: AppSizes.minPadding,
              ),
              Row(
                children: [
                  Flexible(
                      fit: FlexFit.loose,
                      child: AutoSizeText(
                        formatMoney(model.newPrice),
                        style: AppTextStyles.style17BlackBold,
                        minFontSize: 1.0,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  model.oldPrice == null
                      ? Container()
                      : Row(
                    children: [
                      Container(
                        width: AppSizes.minPadding,
                      ),
                      Text(
                        formatMoney(model.oldPrice),
                        style: AppTextStyles.style12HintNormal.copyWith(
                            decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  BoxShadow _buildBoxShadow() {
    return BoxShadow(
        color: AppColors.blackColor.withOpacity(0.1),
        offset: Offset(0.0, -2),
        blurRadius: 4.0);
  }

  Widget _buildAttach(ServiceDetailResponseModel model){
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.attached_service),
      child: CustomListView(
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        children: model.attach!.map((e) => CustomRowWithoutTitleInformation(
          text: e.objectName,
          subText: formatMoney(e.price),
        )).toList(),
      ),
    );
  }

  Widget _buildSkeletonDescription() {
    return CustomShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSkeleton(),
          Container(
            height: AppSizes.minPadding/ 2,
          ),
          CustomSkeleton(),
          Container(
            height: AppSizes.minPadding/ 2,
          ),
          CustomSkeleton(
            width: AppSizes.maxWidth! / 2,
          ),
          Container(
            height: AppSizes.minPadding,
          ),
          CustomSkeleton(
            width: AppSizes.maxWidth! - AppSizes.maxPadding* 2,
            height: 100,
            radius: 0.0,
          )
        ],
      ),
    );
  }

  Widget _buildDescription(ServiceDetailResponseModel? model){
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.service_description),
      child: model == null
          ? _buildSkeletonDescription()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            model.description ?? "",
            style: AppTextStyles.style14HintNormal,
          ),
          Container(
            height: AppSizes.minPadding,
          ),
          Stack(
            children: [
              CustomNetworkImage(
                width: _widthImageDescription,
                height: _heightImageDescription,
                url: model.descriptionImage,
              ),
              Container(
                width: _widthImageDescription,
                height: _heightImageDescription,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.0),
                          Colors.white.withOpacity(0.5),
                          Colors.white,
                        ],
                        stops: [
                          0.0,
                          0.5,
                          1.0
                        ])),
              )
            ],
          ),
          CustomButton(
            text: AppLocalizations.text(LangKey.view_detail),
            style: AppTextStyles.style15PrimaryNormal,
            backgroundColor: Colors.transparent,
            onTap: () => CustomNavigator.showCustomBottomDialog(
                context,
                DescriptionDetailScreen(model.detailDescription)),
          )
        ],
      ),
    );
  }

  Widget _buildServiceInfo(ServiceDetailResponseModel? model) {
    return Container(
      decoration:
      BoxDecoration(boxShadow: [_buildBoxShadow()], color: Colors.white),
      child: CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorPadding: AppSizes.maxPadding,
        children: [
          if((model?.attach?.length ?? 0) > 0)
            _buildAttach(model!),
          _buildDescription(model)
        ],
      ),
    );
  }

  Widget _buildBody() {
    return StreamBuilder(
        stream: _bloc.outputModel,
        initialData: null,
        builder: (_, snapshot) {
          ServiceDetailResponseModel? model = snapshot.data as ServiceDetailResponseModel?;
          return ContainerScrollable(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                _buildHeader(model),
                _buildServiceInfo(model),
              ],
            ),
            onRefresh: _onRefresh,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.service),
      body: _buildBody(),
    );
  }
}
