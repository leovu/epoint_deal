import 'package:auto_size_text/auto_size_text.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/request/service_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/response/service_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/service_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_category/bloc/service_detail_bloc.dart';
import 'package:epoint_deal_plugin/presentation/order_category/ui/description_detail_screen.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/widget/container_scrollable.dart';
import 'package:epoint_deal_plugin/widget/custom_avatar_with_url.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/custom_scaffold.dart';
import 'package:epoint_deal_plugin/widget/custom_shimer.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:flutter/material.dart';

class ServiceDetailScreen extends StatefulWidget {

  final ServiceModel model;
  final bool isViewOnly;

  ServiceDetailScreen(this.model, this.isViewOnly);

  @override
  ServiceDetailScreenState createState() => ServiceDetailScreenState();
}

class ServiceDetailScreenState extends State<ServiceDetailScreen> {

  double _heightHeader = AppSizes.maxWidth * 0.9;
  double _heightHeaderImage = (AppSizes.maxWidth - AppSizes.maxPadding * 2) / 5;

  double _widthImageDescription = AppSizes.maxWidth - AppSizes.maxPadding * 2;
  double _heightImageDescription = 100;

  ServiceDetailBloc _bloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc = ServiceDetailBloc(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => _onRefresh(isRefresh: false));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _bloc.dispose();
    super.dispose();
  }

  Future _onRefresh({bool isRefresh = true}){
    return _bloc.serviceDetail(ServiceDetailRequestModel(
        serviceId: widget.model.serviceId,
    ), isRefresh);
  }

  Widget _buildSkeletonHeader(){
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
                CustomSkeleton(height: 20.0,),
                Container(height: AppSizes.minPadding,),
                CustomSkeleton(height: 20.0, width: AppSizes.maxWidth / 2,),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderImage(String url){
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

  Widget _buildHeader(ServiceDetailResponseModel model){
    if(model == null)
      return _buildSkeletonHeader();
    return Stack(
      children: [
        Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: StreamBuilder(
              stream: _bloc.outputImage,
              initialData: model.serviceAvatar,
              builder: (_, snapshot){
                return CustomNetworkImage(
                  width: AppSizes.maxWidth,
                  height: _heightHeader,
                  url: snapshot.data,
                  fit: BoxFit.contain,
                  backgroundColor: Colors.white,
                );
              },
            )
        ),
        Container(
          margin: EdgeInsets.only(
              top: _heightHeader - _heightHeaderImage / 2,
              right: AppSizes.maxPadding,
              left: AppSizes.maxPadding,
              bottom: AppSizes.maxPadding
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (model.serviceImages?.length ?? 0) == 0?Container(
                height: _heightHeaderImage / 2,
              ):Container(
                height: _heightHeaderImage,
                child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) => _buildHeaderImage(model.serviceImages[index].name),
                    separatorBuilder: (_, index) => Container(width: AppSizes.minPadding,),
                    itemCount: model.serviceImages.length > 5?5:model.serviceImages.length
                ),
              ),
              Container(height: AppSizes.minPadding,),
              model.promotion == null?Container():Column(
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
                                  : model.promotion.gift != null
                                  ? model.promotion.gift
                                  : model.promotion.price != null
                                  ? model.promotion.price
                                  : "",
                              style: AppTextStyles.style13WhiteNormal,
                              minFontSize: 4.0,
                            ),
                          ))
                    ],
                  ),
                  Container(height: AppSizes.maxPadding,),
                ],
              ),
              Text(
                "${model.time??0} ${AppLocalizations.text(LangKey.minutes).toUpperCase()}",
                style: AppTextStyles.style13HintNormal,
              ),
              Container(height: AppSizes.minPadding,),
              Text(
                model.serviceName??"",
                style: AppTextStyles.style17BlackBold,
              ),
              Container(height: AppSizes.minPadding,),
              Row(
                children: [
                  Flexible(
                      fit: FlexFit.loose,
                      child: AutoSizeText(
                        model.newPrice.getMoneyFormat(),
                        style: AppTextStyles.style17BlackBold,
                        minFontSize: 1.0,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                  model.oldPrice == null?Container():Row(
                    children: [
                      Container(width: AppSizes.minPadding,),
                      Text(
                        model.oldPrice.getMoneyFormat(),
                        style: AppTextStyles.style12HintNormal.copyWith(
                            decoration: TextDecoration.lineThrough
                        ),
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

  BoxShadow _buildBoxShadow(){
    return BoxShadow(
        color: AppColors.black.withOpacity(0.1),
        offset: Offset(0.0, -2),
        blurRadius: 4.0
    );
  }

  Widget _buildSkeletonDescription(){
    return CustomShimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSkeleton(),
          Container(height: AppSizes.minPadding / 2,),
          CustomSkeleton(),
          Container(height: AppSizes.minPadding / 2,),
          CustomSkeleton(width: AppSizes.maxWidth / 2,),
          Container(height: AppSizes.minPadding,),
          CustomSkeleton(
            width: AppSizes.maxWidth - AppSizes.maxPadding * 2,
            height: 100,
            radius: 0.0,
          )
        ],
      ),
    );
  }

  Widget _buildServiceInfo(ServiceDetailResponseModel model){
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            _buildBoxShadow()
          ],
          color: Colors.white
      ),
      padding: EdgeInsets.all(AppSizes.maxPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.text(LangKey.service_description),
            style: AppTextStyles.style17BlackBold,
          ),
          Container(height: AppSizes.minPadding,),
          model == null?_buildSkeletonDescription():Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.description??"",
                style: AppTextStyles.style14HintNormal,
              ),
              Container(height: AppSizes.minPadding,),
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
                            ])
                    ),
                  )
                ],
              ),
              CustomButton(
                text: AppLocalizations.text(LangKey.view_detail),
                style: AppTextStyles.style15PrimaryNormal,
                backgroundColor: Colors.transparent,
                onTap: () => CustomNavigator.showCustomBottomDialog(context, DescriptionDetailScreen(model.detailDescription)),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _inputField(ServiceModel value) {
    return Center(
      child: AutoSizeTextField(
        keyboardType: TextInputType.number,
        focusNode: value.node,
        controller: value.controller,
        maxLength: 3,
        onChanged: (text) {
          try {
            if (text[0] == '0' && text.length > 1) {
              String val = text.substring(1, text.length);
              value.controller.text = '$val';
              GlobalCart.shared.addService(value, int.tryParse(val));
              value.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.controller.text.length));
            } else {
              if (text == '' || text == null) {
                GlobalCart.shared.addService(value, 0);
              } else {
                GlobalCart.shared.addService(value, int.tryParse(text));
                value.controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: value.controller.text.length));
              }
            }
          } catch (e) {
            if (text == '' || text == null) {
              value.controller.text = '0';
              GlobalCart.shared.addService(value, 0);
              value.controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: value.controller.text.length));
            }
          }
        },
        buildCounter: (BuildContext context,
            {int currentLength, int maxLength, bool isFocused}) =>
        null,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }

  Widget _buildAddToCart(){
    return StreamBuilder(
        stream: _bloc.outputQuantity,
        initialData: widget.model.qty,
        builder: (_, snapshot){
          return widget.model.qty == 0?CustomButton(
            text: AppLocalizations.text(LangKey.add_to_cart),
            backgroundColor: AppColors.subColor,
            onTap: (){
              int qty = (widget.model.qty + 1) > 999
                  ? 999
                  : widget.model.qty + 1;
              GlobalCart.shared.addService(widget.model, qty);
              _bloc.setQuantity(widget.model.qty);
            },
          ):Row(
            children: [
              Expanded(child: Text(
                AppLocalizations.text(LangKey.quantity),
                style: AppTextStyles.style15BlackNormal,
              )),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: InkWell(
                  onTap: () {
                    int qty = (widget.model.qty - 1) <= 0
                        ? 0
                        : widget.model.qty - 1;
                    GlobalCart.shared.addService(widget.model, qty);
                    _bloc.setQuantity(widget.model.qty);
                  },
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10.0)),
                    child: Center(
                      child: Text('-',
                          style: TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5.0),
                    border: Border.all(color: Colors.grey)),
                width: 60.0,
                height: 25.0,
                child: _inputField(widget.model),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: InkWell(
                  onTap: () {
                    int qty = (widget.model.qty + 1) > 999
                        ? 999
                        : widget.model.qty + 1;
                    GlobalCart.shared.addService(widget.model, qty);
                  },
                  child: Container(
                    height: 20.0,
                    width: 20.0,
                    decoration: BoxDecoration(
                        borderRadius:
                        BorderRadius.circular(10.0)),
                    child: Icon(
                      Icons.add,
                      size: 20.0,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ),
              )
            ],
          );
        }
    );
  }

  Widget _buildBottom(){
    return Container(
      decoration: BoxDecoration(
          border: Border(
              top: BorderSide(color: AppColors.borderColor)
          )
      ),
      child: CustomListView(
          padding: EdgeInsets.symmetric(
              horizontal: AppSizes.maxPadding,
              vertical: AppSizes.minPadding
          ),
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          children: [
            _buildAddToCart(),
            CustomButton(
              text: AppLocalizations.text(LangKey.buy_now),
              onTap: (){
                if(widget.model.qty == 0){
                  GlobalCart.shared.addService(widget.model, 1);
                }
                // CustomNavigator.pushReplacement(context, CartScreen());
              },
            )
          ],
    ),
    );
  }

  Widget _buildBody(){
    return StreamBuilder(
        stream: _bloc.outputModel,
        initialData: null,
        builder: (_, snapshot){
          ServiceDetailResponseModel model = snapshot.data;
          return Column(
            children: [
              Expanded(
                  child: ContainerScrollable(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        _buildHeader(model),
                        _buildServiceInfo(model),
                      ],
                    ),
                    onRefresh: _onRefresh,
                  )
              ),
              if(widget.isViewOnly)
                _buildBottom(),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppLocalizations.text(LangKey.service),
      body: _buildBody(),
    );
  }
}
