import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/service_card_response_model.dart';
import 'package:epoint_deal_plugin/presentation/category_module/src/bloc/category_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class CategoryServiceCardActivatedScreen extends StatefulWidget {
  final CategoryBloc bloc;

  CategoryServiceCardActivatedScreen(this.bloc);

  @override
  CategoryServiceCardActivatedScreenState createState() =>
      CategoryServiceCardActivatedScreenState();
}

class CategoryServiceCardActivatedScreenState
    extends State<CategoryServiceCardActivatedScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>
        widget.bloc.onRefreshServiceCardActivated(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _buildSearchBox() {
    return StreamBuilder(
        stream: widget.bloc.outputSearchServiceCardActivated,
        initialData: "",
        builder: (_, snapshot) {
          String event = snapshot.data as String;
          return CustomSearchBox(
            focusNode: widget.bloc.focusSearchServiceCardActivated,
            controller: widget.bloc.controllerSearchServiceCardActivated,
            hint: AppLocalizations.text(LangKey.search_for_service_card),
            suffixIcon:
                event.isEmpty ? Assets.iconSearch : Assets.iconCloseCircle,
            onSuffixTap: event.isEmpty
                ? null
                : widget.bloc.clearSearchServiceCardActivated,
            onChanged: (_) => widget.bloc.listenerServiceCardActivated(),
          );
        });
  }

  Widget _buildContainerItem(List<Widget> children, {bool isSelected = false}) {
    return ContainerBooking(
      CustomListView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.maxPadding, vertical: AppSizes.minPadding),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: children,
      ),
      isSelected: isSelected,
    );
  }

  Widget _buildItem(ServiceCardModel model, GestureTapCallback onSelected) {
    bool isSelected = Globals.cart?.serviceActivatedCards.firstWhereOrNull(
            (element) => element.cardCode == model.cardCode) !=
        null;
    return ContainerBooking(
      CustomListView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.maxPadding, vertical: AppSizes.minPadding),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Text(
            model.name ?? "",
            style: AppTextStyles.style14BlackBold,
          ),
          Text(
            model.cardCode ?? "",
            style: AppTextStyles.style14HintNormal,
          ),
          Text.rich(TextSpan(
              text: "${parseAndFormatDate(model.activedDate)} -> ",
              style: AppTextStyles.style14BlackNormal,
              children: [
                TextSpan(
                    text: model.expiredDate == null
                        ? AppLocalizations.text(LangKey.infinite)
                        : parseAndFormatDate(model.expiredDate),
                    style: AppTextStyles.style14BlackNormal)
              ])),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Text(
                "${AppLocalizations.text(LangKey.remain)} ${model.remainAmount} ${AppLocalizations.text(LangKey.uses_left)!.toLowerCase()}",
                style: AppTextStyles.style14BlackNormal,
              )),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: !isSelected
                          ? AppColors.whiteColor
                          : AppColors.primaryColor),
                  padding: EdgeInsets.all(4.0),
                  child: CustomImageIcon(
                    icon: Assets.iconCalendar1,
                    size: 12.0,
                    color: AppColors.whiteColor,
                  )),
            ],
          )
        ],
      ),
      isSelected: isSelected,
      onTap: onSelected,
    );
  }

  Widget _buildEmpty() {
    return CustomEmpty(title: AppLocalizations.text(LangKey.data_empty));
  }

  Widget _buildSkeleton() {
    return _buildContainerItem(List.generate(2,
            (index) => CustomShimmer(child: CustomRowWithoutTitleInformation()))
        .toList());
  }

  Widget _buildContainer(List<Widget> children,
      {Function? onLoadmore, bool? showLoadmore}) {
    return CustomListView(
      children: children,
      onLoadmore: onLoadmore,
      showLoadmore: showLoadmore,
    );
  }

  Widget _buildContent() {
    return StreamBuilder(
        stream: widget.bloc.outputServiceCardActivatedModel,
        initialData: null,
        builder: (_, snapshot) {
          ServiceCardResponseModel? model =
              snapshot.data as ServiceCardResponseModel?;
          return ContainerDataBuilder(
            data: model?.items,
            emptyBuilder: _buildEmpty(),
            skeletonBuilder: _buildContainer(
                List.generate(2, (index) => _buildSkeleton()).toList()),
            bodyBuilder: () => _buildContainer(
              model!.items!
                  .map((e) => _buildItem(
                        e!,
                        () => widget.bloc.onSelectedServiceCardActivated(e),
                      ))
                  .toList(),
              showLoadmore: model.pageInfo?.enableLoadmore,
              onLoadmore: () =>
                  widget.bloc.orderServiceCardUsing(isLoadmore: true),
            ),
            onRefresh: widget.bloc.onRefreshServiceCardActivated,
          );
        });
  }

  Widget _buildBody() {
    return Column(
      children: [_buildSearchBox(), Expanded(child: _buildContent())],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return _buildBody();
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
