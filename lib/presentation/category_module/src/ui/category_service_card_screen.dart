import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/order_service_card_response_model.dart';
import 'package:epoint_deal_plugin/presentation/category_module/src/bloc/category_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';


class CategoryServiceCardScreen extends StatefulWidget {
  final CategoryBloc bloc;

  CategoryServiceCardScreen(this.bloc);

  @override
  CategoryServiceCardScreenState createState() =>
      CategoryServiceCardScreenState();
}

class CategoryServiceCardScreenState extends State<CategoryServiceCardScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => widget.bloc.onRefreshServiceCard(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _buildSearchBox() {
    return StreamBuilder(
        stream: widget.bloc.outputSearchServiceCard,
        initialData: "",
        builder: (_, snapshot) {
          String event = snapshot.data as String;
          return CustomSearchBox(
            focusNode: widget.bloc.focusSearchServiceCard,
            controller: widget.bloc.controllerSearchServiceCard,
            hint: AppLocalizations.text(LangKey.search_for_service_card),
            suffixIcon:
                event.isEmpty ? Assets.iconSearch : Assets.iconCloseCircle,
            onSuffixTap:
                event.isEmpty ? null : widget.bloc.clearSearchServiceCard,
            onChanged: (_) => widget.bloc.listenerServiceCard(),
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

  Widget _buildItem(
      OrderServiceCardModel model, GestureTapCallback onSelected) {
    bool isSelected = Globals.cart?.serviceCards
            .firstWhereOrNull((element) => element.code == model.code) !=
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
            model.code ?? "",
            style: AppTextStyles.style14HintNormal,
          ),
          CustomTextSpanInformation(
            title: AppLocalizations.text(LangKey.number_of_uses),
            content: (model.numberUsing ?? 0) == 0
                ? AppLocalizations.text(LangKey.no_limit)
                : model.numberUsing.toString(),
            contentStyle: AppTextStyles.style14DarkRedNormal,
          ),
          CustomTextSpanInformation(
            title: AppLocalizations.text(LangKey.number_of_days_of_use),
            content: (model.dateUsing ?? 0) == 0
                ? AppLocalizations.text(LangKey.no_limit)
                : model.dateUsing.toString(),
            contentStyle: AppTextStyles.style14PrimaryRegular,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                  child: Text(
                formatMoney(model.price),
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
        stream: widget.bloc.outputServiceCardModel,
        initialData: null,
        builder: (_, snapshot) {
          OrderServiceCardResponseModel? model =
              snapshot.data as OrderServiceCardResponseModel?;
          return ContainerDataBuilder(
            data: model?.items,
            emptyBuilder: _buildEmpty(),
            skeletonBuilder: _buildContainer(
                List.generate(2, (index) => _buildSkeleton()).toList()),
            bodyBuilder: () => _buildContainer(
              model!.items!
                  .map((e) => _buildItem(
                        e,
                        () => widget.bloc.onSelectedServiceCard(e),
                      ))
                  .toList(),
              showLoadmore: model.pageInfo?.enableLoadmore,
              onLoadmore: () => widget.bloc.orderServiceCard(isLoadmore: true),
            ),
            onRefresh: widget.bloc.onRefreshServiceCard,
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
