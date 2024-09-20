import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/bloc/detail_deal_bloc.dart';
import 'package:epoint_deal_plugin/presentation/list_product_detail/list_products_detail_deal_bloc.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';

class ListProductsDetailDealScreen extends StatefulWidget {
  final DetailDealBloc bloc;
  final DetailDealData? detail;
  const ListProductsDetailDealScreen(
      {super.key, required this.bloc, required this.detail});

  @override
  State<ListProductsDetailDealScreen> createState() =>
      _ListProductsDetailDealScreenState();
}

class _ListProductsDetailDealScreenState
    extends State<ListProductsDetailDealScreen> {
  late ListProductsDetailDealBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = ListProductsDetailDealBloc(context);
    _bloc.listProductBuy = widget.detail?.productBuy;
    _bloc.setListProductBuy(_bloc.listProductBuy ?? []);
  }

  Widget _buildBody() {
    return Container(
      padding: EdgeInsets.all(AppSizes.minPadding),
      child: Column(
        children: [
          _buildInfo(),
          Expanded(
              child: StreamBuilder(
                  stream: _bloc.outputListProductBuy,
                  initialData: null,
                  builder: (context, snapshot) {
                    List<ProductBuy>? _listProductBuy =
                        snapshot.data as List<ProductBuy>?;
                    return (_listProductBuy != null &&
                            _listProductBuy.isNotEmpty)
                        ? CustomListView(
                            padding: EdgeInsets.zero,
                            physics: ClampingScrollPhysics(),
                            children: _listProductBuy
                                .map((e) => _productItem(
                                    e!, widget.detail!.productBuy!.indexOf(e)))
                                .toList(),
                          )
                        : CustomEmpty(
                            text: "Không có sản phẩm nào",
                          );
                  }))
        ],
      ),
    );
  }

  Widget _buildInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCustomerType(),
        Gaps.vGap10,
        Text(AppLocalizations.text(LangKey.overview)!,
            style: AppTextStyles.style14PrimaryBold),
        Gaps.vGap10,
        _buildTotal(),
        Gaps.vGap10,
        _buildDiscount(),
        if (widget.detail?.otherFee != null &&
            widget.detail!.otherFee!.isNotEmpty) ...[
          Gaps.vGap10,
          _buildSurcharge(),
          Gaps.vGap10,
          _buildListSurcharge(),
        ],
        Gaps.vGap10,
        _buildTotalPreTax(),
        Gaps.vGap10,
        _buildVAT(),
        Gaps.vGap10,
        _buildFinalMoney(),
        Gaps.vGap10,
        _buildListOption(),
        Gaps.vGap10,
      ],
    );
  }

  Widget _buildCustomerType() {
    return RichText(
        text: TextSpan(
            text: widget.detail?.typeCustomer == "customer"
                ? "${AppLocalizations.text(LangKey.customerVi)} - "
                : "${AppLocalizations.text(LangKey.sales_leads)} - ",
            style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey,
                fontWeight: FontWeight.normal),
            children: [
          TextSpan(
              text: widget.detail?.dealName,
              style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold))
        ]));
  }

  Widget _buildTotal() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.total_money),
      titleStyle: AppTextStyles.style14BlackNormal,
      content: formatMoney(widget.detail?.total?.toDouble() ?? 0),
      contentStyle: AppTextStyles.style14PrimaryBold,
    );
  }

  Widget _buildDiscount() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.discount),
      titleStyle: AppTextStyles.style14BlackNormal,
      content: formatMoney(widget.detail?.discount?.toDouble() ?? 0),
      contentStyle: AppTextStyles.style14PrimaryBold,
    );
  }

  Widget _buildSurcharge() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.other_revenues),
      titleStyle: AppTextStyles.style14BlackNormal,
      content: formatMoney(widget.detail?.totalOtherFee?.toDouble() ?? 0),
      contentStyle:
          AppTextStyles.style14PrimaryBold.copyWith(color: Colors.red),
    );
  }

  Widget _buildListSurcharge() {
    return Padding(
      padding: EdgeInsets.only(left: AppSizes.maxPadding),
      child: Column(
        children: List.generate(
            widget.detail!.otherFee!.length,
            (index) => Padding(
                  padding: EdgeInsets.only(bottom: AppSizes.minPadding),
                  child: CustomRowInformation(
                    title:
                        "+ ${AppLocalizations.text(LangKey.other_revenues)} ${index + 1}",
                    titleStyle: AppTextStyles.style14BlackNormal,
                    content: formatMoney(
                        widget.detail?.otherFee![index].feeMoney?.toDouble() ??
                            0),
                    contentStyle: AppTextStyles.style14PrimaryBold
                        .copyWith(color: Colors.red),
                  ),
                )),
      ),
    );
  }

  Widget _buildTotalPreTax() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.total_pre_tax_money),
      titleStyle: AppTextStyles.style14BlackNormal,
      content: formatMoney(widget.detail?.amountBeforeVat?.toDouble() ?? 0),
      contentStyle: AppTextStyles.style14PrimaryBold,
    );
  }

  Widget _buildVAT() {
    return CustomRowInformation(
      title:
          "${AppLocalizations.text(LangKey.vat)} (${widget.detail?.totalVat})%",
      titleStyle: AppTextStyles.style14BlackNormal,
      content:
          "${formatMoney((widget.detail?.totalVat?.toDouble() ?? 0) / 100 * (widget.detail?.amountBeforeVat?.toDouble() ?? 0))}",
      contentStyle: AppTextStyles.style14PrimaryBold,
    );
  }

  Widget _buildFinalMoney() {
    return CustomRowInformation(
      title: AppLocalizations.text(LangKey.final_money),
      titleStyle: AppTextStyles.style14BlackNormal,
      content: formatMoney(widget.detail?.amount?.toDouble() ?? 0),
      contentStyle: AppTextStyles.style14PrimaryBold,
    );
  }

  Widget _buildListOption() {
    return CustomRowInformation(
        title: AppLocalizations.text(LangKey.list),
        titleStyle: AppTextStyles.style14PrimaryBold,
        child: StreamBuilder(
            stream: _bloc.outputListProductBuy,
            initialData: _bloc.selectedProductType,
            builder: (context, snapshot) {
              return CustomDropdown(
                value: _bloc.selectedProductType,
                menus: _bloc.listProductType,
                hint: "Chọn loại sản phẩm",
                onChanged: (p0) {
                  _bloc.onChange(p0!);
                },
                onRemove: () {
                  _bloc.onRemove();
                },
              );
            }));
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

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Danh sách sản phẩm',
      body: _buildBody(),
    );
  }
}
