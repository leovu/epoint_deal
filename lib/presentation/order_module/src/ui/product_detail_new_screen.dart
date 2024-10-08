import 'package:auto_size_text/auto_size_text.dart';
import 'package:epoint_deal_plugin/model/request/product_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/response/product_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/product_new_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/bloc/product_detail_bloc.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/description_detail_screen.dart';
import 'package:epoint_deal_plugin/widget/container_scrollable.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';

class ProductDetailNewScreen extends StatefulWidget {
  final ProductNewModel model;

  ProductDetailNewScreen(this.model);

  @override
  ProductDetailNewScreenState createState() => ProductDetailNewScreenState();
}

class ProductDetailNewScreenState extends State<ProductDetailNewScreen> {
  final FocusNode _focusPrice = FocusNode();
  final TextEditingController _controllerPrice = TextEditingController();

  final FocusNode _focusQuantity = FocusNode();
  final TextEditingController _controllerQuantity = TextEditingController();

  final FocusNode _focusNote = FocusNode();
  final TextEditingController _controllerNote = TextEditingController();

  double _heightHeader = AppSizes.maxWidth! * 0.9;
  double _heightHeaderImage = (AppSizes.maxWidth! - AppSizes.maxPadding* 2) / 5;

  double _widthImageDescription = AppSizes.maxWidth! - AppSizes.maxPadding* 2;
  double _heightImageDescription = 100;

  late ProductDetailBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ProductDetailBloc(context);

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
    return _bloc.productDetail(
        ProductDetailRequestModel(productId: widget.model.productId),
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

  Widget _buildHeader(ProductDetailResponseModel? model) {
    if (model == null) return _buildSkeletonHeader();

    double rating = (model.rating?.avgRating) ?? 0;
    rating = rating > 5 ? 5 : rating;
    return Stack(
      children: [
        Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: StreamBuilder(
              stream: _bloc.outputImage,
              initialData: model.avatar,
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
              (model.listImage?.length ?? 0) == 0
                  ? Container(
                height: _heightHeaderImage / 2,
              )
                  : Container(
                height: _heightHeaderImage,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) =>
                        _buildHeaderImage(model.listImage![index].image),
                    separatorBuilder: (_, index) => Container(
                      width: AppSizes.minPadding,
                    ),
                    itemCount: model.listImage!.length > 5
                        ? 5
                        : model.listImage!.length),
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
                model.productName ?? "",
                style: AppTextStyles.style17BlackBold,
              ),
              Container(
                height: AppSizes.minPadding,
              ),
              Row(
                children: [
                  Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                                style: AppTextStyles.style12HintNormal
                                    .copyWith(
                                    decoration:
                                    TextDecoration.lineThrough),
                              ),
                            ],
                          )
                        ],
                      )),
                  Container(
                    width: AppSizes.minPadding,
                  ),
                  Row(
                    children: [
                      Text(
                        rating.toStringAsFixed(1),
                        style: AppTextStyles.style13BlackBold,
                      ),
                      Container(
                        width: 2,
                      ),
                      CustomStarRating(
                        rating: rating,
                      )
                    ],
                  ),
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

  Widget _buildAttach(ProductDetailResponseModel model){
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.attached_product),
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

  Widget _buildSkeletonInfo() {
    return CustomShimmer(
      child: Row(
        children: [
          Flexible(fit: FlexFit.tight, flex: 2, child: CustomSkeleton()),
          Container(
            width: AppSizes.minPadding,
          ),
          Flexible(fit: FlexFit.tight, flex: 5, child: CustomSkeleton()),
        ],
      ),
    );
  }

  Widget _buildProductInfoRow(String title, String content,
      {bool isColor = false}) {
    return Container(
      color: isColor ? AppColors.borderColor : Colors.white,
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.minPadding, vertical: AppSizes.maxPadding),
      child: Row(
        children: [
          Flexible(
              fit: FlexFit.tight,
              flex: 2,
              child: Text(
                title,
                style: AppTextStyles.style12BlackBold,
              )),
          Container(
            width: AppSizes.minPadding,
          ),
          Flexible(
              fit: FlexFit.tight,
              flex: 5,
              child: Text(
                content,
                style: AppTextStyles.style12BlackNormal,
              )),
        ],
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

  Widget _buildDetails(ProductDetailResponseModel? model){
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.details),
      child: model == null
          ? _buildSkeletonInfo()
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProductInfoRow(
              AppLocalizations.text(LangKey.category)!.toUpperCase(),
              "${AppLocalizations.text(LangKey.product)} > ${model.categoryName ?? ""}",
              isColor: true),
          _buildProductInfoRow(
              AppLocalizations.text(LangKey.supplier)!.toUpperCase(),
              model.supplierName ?? ""),
          _buildProductInfoRow(
              AppLocalizations.text(LangKey.trademark)!.toUpperCase(),
              model.productModelName ?? "",
              isColor: true),
          _buildProductInfoRow(
              AppLocalizations.text(LangKey.origin)!.toUpperCase(),
              model.madeIn ?? ""),
        ],
      ),
    );
  }

  Widget _buildDescription(ProductDetailResponseModel? model){
    return CustomColumnInformation(
      title: AppLocalizations.text(LangKey.product_description),
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
                DescriptionDetailScreen(model.descriptionDetail)),
          )
        ],
      ),
    );
  }

  Widget _buildProductInfo(ProductDetailResponseModel? model) {
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
          _buildDetails(model),
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
          ProductDetailResponseModel? model = snapshot.data as ProductDetailResponseModel?;
          return ContainerScrollable(
            child: ListView(
              padding: EdgeInsets.zero,
              physics: AlwaysScrollableScrollPhysics(),
              children: [
                _buildHeader(model),
                _buildProductInfo(model),
              ],
            ),
            onRefresh: _onRefresh,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.product),
      actions: [buildKeyboardAction(_focusPrice)],
      body: _buildBody(),
    );
  }
}
