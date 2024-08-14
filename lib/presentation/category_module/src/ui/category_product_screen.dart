

import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/product_category_response_model.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

import '../bloc/category_bloc.dart';

class CategoryProductScreen extends StatefulWidget {
  final CategoryBloc bloc;

  CategoryProductScreen(this.bloc);

  @override
  CategoryProductScreenState createState() => CategoryProductScreenState();
}

class CategoryProductScreenState extends State<CategoryProductScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
        (timeStamp) => widget.bloc.onRefreshProduct(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Widget _buildSearchBox() {
    return StreamBuilder(
        stream: widget.bloc.outputSearchProduct,
        initialData: "",
        builder: (_, snapshot) {
          String event = snapshot.data as String;
          return CustomSearchBox(
            focusNode: widget.bloc.focusSearchProduct,
            controller: widget.bloc.controllerSearchProduct,
            hint: AppLocalizations.text(LangKey.search_for_products),
            suffixIcon:
                event.isEmpty ? Assets.iconSearch : Assets.iconCloseCircle,
            onSuffixTap: event.isEmpty ? null : widget.bloc.clearSearchProduct,
            onChanged: (_) => widget.bloc.listenerProduct(),
          );
        });
  }

  Widget _buildCategory(ProductCategoryModel? model) {
    bool isSelected = false;
    if (model == null) {
      if (widget.bloc.selectedCategoryProduct == null) {
        isSelected = true;
      }
    } else {
      isSelected = model.productCategoryId ==
          widget.bloc.selectedCategoryProduct?.productCategoryId;
    }
    return CustomButton(
      text: model == null ? AppLocalizations.text(LangKey.all) : model.categoryName,
      backgroundColor: isSelected ? null : Colors.transparent,
      style: AppTextStyles.style12WhiteNormal.copyWith(
          color: isSelected ? AppColors.whiteColor : AppColors.blackColor),
      onTap: () => widget.bloc.onSelectedCategoryProduct(model),
    );
  }

  Widget _buildSkeletonCategory() {
    return CustomShimmer(
        child: CustomSkeleton(
          width: double.infinity,
          height: AppSizes.sizeOnTap,
          radius: 5.0,
        ));
  }

  Widget _buildContainerCategory(List<Widget> children) {
    return CustomListView(
      padding: EdgeInsets.only(
          left: AppSizes.maxPadding,
          top: AppSizes.maxPadding,
          bottom: AppSizes.maxPadding),
      children: children,
    );
  }

  Widget _buildCategories() {
    return StreamBuilder(
        stream: widget.bloc.outputProductCategoryModels,
        initialData: null,
        builder: (_, snapshot) {
          List<ProductCategoryModel>? models =
          snapshot.data as List<ProductCategoryModel>?;
          return ContainerDataBuilder(
            data: models,
            skeletonBuilder: _buildContainerCategory(
                List.generate(2, (index) => _buildSkeletonCategory())
                    .toList()),
            bodyBuilder: () => _buildContainerCategory(
                ([null, ...models!].map(_buildCategory).toList())),
          );
        });
  }

  Widget _buildContainerItem(List<Widget> children, {bool isSelected = false, GestureTapCallback? onTap}) {
    return ContainerBooking(
      CustomListView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.maxPadding, vertical: AppSizes.minPadding),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: children,
      ),
      isSelected: isSelected,
      onTap: onTap,
    );
  }

  Widget _buildItem(ProductNewModel model, GestureTapCallback onSelected) {
    bool isSelected = Globals.cart?.products.firstWhereOrNull(
            (element) => element.productCode == model.productCode) !=
        null;
    return _buildContainerItem(
      [
        Row(
          children: [
            Expanded(
                child: Text(
                  model.productCode ?? "",
                  style: AppTextStyles.style14HintNormal,
                )),
            SizedBox(
              width: AppSizes.minPadding,
            ),
            Text(
              formatMoney(model.newPrice),
              style: AppTextStyles.style14BlackNormal,
            )
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Text(
                  model.productName ?? "",
                  style: AppTextStyles.style14BlackBold,
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
      padding: EdgeInsets.only(
          right: AppSizes.maxPadding,
          top: AppSizes.maxPadding,
          bottom: AppSizes.maxPadding),
      children: children,
      onLoadmore: onLoadmore,
      showLoadmore: showLoadmore,
    );
  }

  Widget _buildItems() {
    return StreamBuilder(
        stream: widget.bloc.outputProductNewModel,
        initialData: null,
        builder: (_, snapshot) {
          ProductNewResponseModel? model =
              snapshot.data as ProductNewResponseModel?;
          return ContainerDataBuilder(
            data: model?.items,
            emptyBuilder: _buildEmpty(),
            skeletonBuilder: _buildContainer(
                List.generate(2, (index) => _buildSkeleton()).toList()),
            bodyBuilder: () => _buildContainer(
              model!.items!
                  .map((e) => _buildItem(
                        e!,
                        () => widget.bloc.onSelectedProduct(e),
                      ))
                  .toList(),
              showLoadmore: model.pageInfo?.enableLoadmore,
              onLoadmore: () => widget.bloc.getProduct(isLoadmore: true),
            ),
            onRefresh: widget.bloc.onRefreshProduct,
          );
        });
  }

  Widget _buildContent() {
    return CustomCategory(category: _buildCategories(), child: _buildItems());
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
