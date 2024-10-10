part of widget;

class ContainerOrder extends StatelessWidget {
  final OrderResponseModel? model;
  final Function? onLoadmore;
  final Function(OrderModel)? onTap;

  const ContainerOrder({this.model, this.onLoadmore, this.onTap, Key? key})
      : super(key: key);

  Widget _buildContainer(List<Widget> children,
      {Function? onLoadmore, bool? showLoadmore}) {
    return CustomListView(
      children: children,
      onLoadmore: onLoadmore,
      showLoadmore: showLoadmore,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildContainer(
          List.generate(1, (index) => CustomOrder()).toList());
    }

    return _buildContainer(
        List.generate(
            model!.items!.length,
            (index) => CustomOrder(
                model: model!.items![index],
                onTap: onTap == null
                    ? null
                    : () => onTap!(model!.items![index]))).toList(),
        onLoadmore: onLoadmore,
        showLoadmore: model!.pageInfo?.enableLoadmore);
  }
}

class CustomOrder extends StatelessWidget {
  final OrderModel? model;
  final GestureTapCallback? onTap;

  const CustomOrder({this.model, this.onTap, Key? key}) : super(key: key);

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      padding: EdgeInsets.all(AppSizes.minPadding),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomContainerList(
      child: CustomShimmer(
        child: _buildContainer(
            List.generate(4, (index) => CustomRowWithoutTitleInformation())
                .toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
        child: CustomContainerList(
          child: _buildContainer([
            Row(
              children: [
                Expanded(
                  child: CustomRowWithoutTitleInformation(
                    icon: Assets.iconUserOutline,
                    text: model!.fullName ?? "",
                    textStyle: AppTextStyles.style14BlackBold,
                  ),
                ),
                CustomChip(
                  text: model!.processStatusName,
                  backgroundColor: HexColor(model!.processStatusColor),
                  style: AppTextStyles.style14WhiteBold,
                )
              ],
            ),
            CustomRowWithoutTitleInformation(
              icon: Assets.iconBranch,
              text: model!.branchName ?? "",
              textStyle: AppTextStyles.style14HintNormal,
            ),
            Row(
              children: [
                Expanded(
                    child: CustomRowWithoutTitleInformation(
                  icon: Assets.iconBarcode,
                  text: model!.orderCode ?? "",
                  textStyle: AppTextStyles.style14PrimaryRegular,
                )),
                SizedBox(
                  width: AppSizes.minPadding,
                ),
                Expanded(
                    child: CustomRowWithoutTitleInformation(
                        icon: Assets.iconCalendar,
                        text: model!.orderDate ?? "")),
              ],
            ),
            CustomRowWithoutTitleInformation(
                icon: Assets.iconMoney,
                text: hideMoney(model!.total,
                    checkVisibilityKey(VisibilityWidgetName.OD000009))),
            CustomLine(),
            if ((model!.orderDetail?.length ?? 0) > 0)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomNetworkImage(
                    url: model!.orderDetail!.first.objectImage,
                    width: AppSizes.maxWidth! * 0.1,
                    height: AppSizes.maxWidth! * 0.1,
                  ),
                  SizedBox(
                    width: AppSizes.minPadding,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          model!.orderDetail!.first.objectName ?? "",
                          style: AppTextStyles.style14BlackNormal,
                        ),
                        SizedBox(
                          height: AppSizes.minPadding,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "${hideMoney(model!.orderDetail!.first.price, checkVisibilityKey(VisibilityWidgetName.OD000009))}${(model!.orderDetail!.first.unitName ?? "").isEmpty ? "" : " / ${model!.orderDetail!.first.unitName}"}",
                                style: AppTextStyles.style14HintNormal,
                              ),
                            ),
                            Container(
                              child: Text(
                                'x${model!.orderDetail!.first.quantity ?? 0}',
                                style: AppTextStyles.style14BlackNormal,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            if ((model!.orderDetail?.length ?? 0) > 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Flexible(
                      child: Text.rich(
                    TextSpan(
                        text: AppLocalizations.text(LangKey.and)!.toLowerCase(),
                        style: AppTextStyles.style13HintNormal,
                        children: [
                          TextSpan(
                              text: " ${model!.orderDetail!.length - 1} ",
                              style: AppTextStyles.style14PrimaryBold),
                          TextSpan(
                            text: AppLocalizations.text(
                                    LangKey.other_products_services)!
                                .toLowerCase(),
                            style: AppTextStyles.style13HintNormal,
                          )
                        ]),
                  ))
                ],
              )
          ]),
        ),
        onTap: onTap);
  }
}

class CustomOrderStatus extends StatelessWidget {
  final FilterModel? model;
  final List<FilterModel>? models;
  final Function(FilterModel)? onChanged;
  final GestureTapCallback? onTap;

  const CustomOrderStatus(
      {Key? key, this.model, this.models, this.onChanged, this.onTap})
      : super(key: key);

  _showOptions(BuildContext context) {
    List<CustomBottomOptionModel> options = models!
        .map((e) => CustomBottomOptionModel(
            text: e.text,
            textColor: e.color,
            isSelected: model!.id == e.id,
            onTap: () {
              CustomNavigator.pop(context);
              onChanged!(e);
            }))
        .toList();

    CustomNavigator.showCustomBottomDialog(
        context,
        CustomBottomSheet(
          title: AppLocalizations.text(LangKey.status),
          body: CustomBottomOption(
            options: options,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit =
        onTap != null || (onChanged != null && (models?.length ?? 0) != 0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.maxPadding),
      child: InkWell(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0), color: model!.color),
          padding: EdgeInsets.all(AppSizes.minPadding),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  model!.text ?? "",
                  style: AppTextStyles.style15WhiteBold,
                  textAlign: TextAlign.center,
                ),
              ),
              if (isEdit)
                Padding(
                  padding: EdgeInsets.only(left: AppSizes.minPadding),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: AppColors.whiteColor,
                  ),
                )
            ],
          ),
        ),
        onTap: onTap ?? (isEdit ? () => _showOptions(context) : null),
      ),
    );
  }
}

class ContainerItemsOrder extends StatelessWidget {
  final List<ProductNewModel>? productModels;
  final Function(ProductNewModel)? onProductDelete;
  final Function(ProductNewModel)? onProductTap;
  final List<ServiceNewModel>? serviceModels;
  final Function(ServiceNewModel)? onServiceDelete;
  final Function(ServiceNewModel)? onServiceTap;
  final List<OrderServiceCardModel>? serviceCardModels;
  final Function(OrderServiceCardModel)? onServiceCardDelete;
  final Function(OrderServiceCardModel)? onServiceCardTap;
  final List<ServiceCardModel>? serviceCardActivatedModels;
  final Function(ServiceCardModel)? onServiceCardActivatedDelete;
  final Function(ServiceCardModel)? onServiceCardActivatedTap;

  const ContainerItemsOrder(
      {super.key,
      this.productModels,
      this.onProductDelete,
      this.onProductTap,
      this.serviceModels,
      this.onServiceDelete,
      this.onServiceTap,
      this.serviceCardModels,
      this.onServiceCardDelete,
      this.onServiceCardTap,
      this.serviceCardActivatedModels,
      this.onServiceCardActivatedDelete,
      this.onServiceCardActivatedTap});

  @override
  Widget build(BuildContext context) {
    return ContainerDataBuilder(
      data: (productModels?.length ?? 0) == 0
          ? (serviceModels?.length ?? 0) == 0
              ? (serviceCardModels?.length ?? 0) == 0
                  ? (serviceCardActivatedModels?.length ?? 0) == 0
                      ? []
                      : serviceCardActivatedModels
                  : serviceCardModels
              : serviceModels
          : productModels,
      emptyBuilder: Text(
        AppLocalizations.text(LangKey.you_have_not_selected_a_product_service)!,
        style: AppTextStyles.style14HintNormalItalic,
      ),
      emptyPhysics: NeverScrollableScrollPhysics(),
      emptyShinkWrap: true,
      bodyBuilder: () {
        List<Widget> children = [];
        if (productModels != null) {
          children.addAll(productModels!.map((e) => CustomItemOrder(
                name: e.productName,
                code: e.productCode,
                note: e.note,
                quantity: e.quantity,
                discount: e.discount,
                price: e.changePrice ?? e.newPrice,
                surcharge: e.surcharge,
                staffModels: e.staffModels,
                voucherModel: e.voucherModel,
                onTap: () => onProductTap!(e),
                onDelete: () => onProductDelete!(e),
              )));
        }
        if (serviceModels != null) {
          children.addAll(serviceModels!.map((e) => CustomItemOrder(
                name: e.serviceName,
                code: e.serviceCode,
                note: e.note,
                quantity: e.quantity,
                discount: e.discount,
                price: e.changePrice ?? e.newPrice,
                surcharge: e.surcharge,
                staffModels: e.staffModels,
                roomModel: e.roomModel,
                voucherModel: e.voucherModel,
                onTap: () => onServiceTap!(e),
                onDelete: () => onServiceDelete!(e),
              )));
        }
        if (serviceCardModels != null) {
          children.addAll(serviceCardModels!.map((e) => CustomItemOrder(
                name: e.name,
                code: e.code,
                note: e.note,
                quantity: e.quantity,
                discount: e.discount,
                price: e.changePrice ?? e.price,
                surcharge: e.surcharge,
                staffModels: e.staffModels,
                roomModel: e.roomModel,
                voucherModel: e.voucherModel,
                onTap: () => onServiceCardTap!(e),
                onDelete: () => onServiceCardDelete!(e),
              )));
        }
        if (serviceCardActivatedModels != null) {
          children
              .addAll(serviceCardActivatedModels!.map((e) => CustomItemOrder(
                    name: e.name,
                    code: e.cardCode,
                    note: e.note,
                    quantity: e.quantity,
                    surcharge: e.surcharge,
                    staffModels: e.staffModels,
                    roomModel: e.roomModel,
                    voucherModel: e.voucherModel,
                    onTap: () => onServiceCardActivatedTap!(e),
                    onDelete: () => onServiceCardActivatedDelete!(e),
                    isActivatedServiceCard: true,
                  )));
        }
        return CustomListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          separator: Column(
            children: [
              SizedBox(
                height: AppSizes.minPadding,
              ),
              CustomLine(),
              SizedBox(
                height: AppSizes.minPadding,
              ),
            ],
          ),
          children: children,
        );
      },
    );
  }
}

class CustomItemOrder extends StatelessWidget {
  final String? name;
  final String? code;
  final String? note;
  final double? discount;
  final double? price;
  final double? surcharge;
  final double? quantity;
  final List<BookingStaffModel>? staffModels;
  final CustomDropdownModel? roomModel;
  final DiscountCartModel? voucherModel;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onDelete;
  final bool isActivatedServiceCard;

  const CustomItemOrder(
      {super.key,
      this.name,
      this.code,
      this.note,
      this.discount,
      this.price,
      this.surcharge,
      this.voucherModel,
      this.onTap,
      this.onDelete,
      this.staffModels,
      this.roomModel,
      this.quantity,
      this.isActivatedServiceCard = false});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (staffModels != null) {
      for (var e in staffModels!) {
        children.add(CustomAvatar(
          url: e.staffAvatar,
          name: e.fullName,
          size: 26,
        ));
      }
    }
    if (roomModel != null) {
      children.add(CustomChip(
        text: roomModel!.text,
        style: AppTextStyles.style14WhiteNormal,
      ));
    }
    return InkWell(
      child: Row(
        children: [
          CustomImageIcon(
            icon: Assets.iconPen,
            size: 14.0,
            color: AppColors.hintColor,
          ),
          SizedBox(
            width: AppSizes.minPadding / 2,
          ),
          Expanded(
              child: CustomListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              Text(
                name ?? "",
                style: AppTextStyles.style14BlackNormal,
              ),
              Text(
                code ?? "",
                style: AppTextStyles.style13HintNormal,
              ),
              if (children.isNotEmpty)
                Wrap(
                  alignment: WrapAlignment.start,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: AppSizes.minPadding / 2,
                  runSpacing: AppSizes.minPadding / 2,
                  children: children,
                ),
              if ((note ?? "").isNotEmpty)
                Text(
                  note!,
                  style: AppTextStyles.style14HintNormalItalic,
                )
            ],
          )),
          SizedBox(
            width: AppSizes.minPadding / 2,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (voucherModel != null || surcharge != null) ...[
                Row(
                  children: [
                    if (voucherModel != null) ...[
                      Image.asset(
                        getVoucherImage(voucherModel!),
                        width: 14.0,
                      ),
                      SizedBox(
                        width: AppSizes.minPadding / 2,
                      ),
                    ],
                    Text(
                      formatMoney((surcharge ?? 0) - (discount ?? 0)),
                      style: AppTextStyles.style13HintNormal,
                    )
                  ],
                ),
                SizedBox(
                  height: AppSizes.minPadding / 2,
                ),
              ],
              if (isActivatedServiceCard)
                Text(
                  (quantity ?? defaultCartQuantity).toString(),
                  style: AppTextStyles.style14DarkRedBold,
                )
              else
                Text(
                  "${quantity ?? defaultCartQuantity} x ${formatMoney(price ?? 0.0)}",
                  style: AppTextStyles.style14BlackNormal,
                )
            ],
          ),
          SizedBox(
            width: AppSizes.minPadding / 2,
          ),
          if (onDelete != null) ...[
            SizedBox(
              width: AppSizes.minPadding / 2,
            ),
            InkWell(
              child: CustomImageIcon(
                icon: Assets.iconTrash,
                color: AppColors.red500,
              ),
              onTap: onDelete,
            )
          ]
        ],
      ),
      onTap: onTap,
    );
  }
}

class ContainerTransportMethod extends StatelessWidget {
  final List<TransportMethodModel>? models;
  final TransportMethodModel? currentModel;
  final Function(TransportMethodModel)? onTap;

  const ContainerTransportMethod(
      {Key? key, this.models, this.currentModel, this.onTap})
      : super(key: key);

  Widget _buildBody(List<Widget> children) {
    return Wrap(
      spacing: AppSizes.minPadding,
      runSpacing: AppSizes.minPadding,
      children: children,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = getWidthPerRow(2);
    if (models == null) {
      return _buildBody([
        CustomTransportMethod(
          width: width,
        )
      ]);
    }
    return _buildBody(models!
        .map((e) => CustomTransportMethod(
              model: e,
              width: width,
              selected: currentModel!.typeShipping == e.typeShipping,
              onTap: () => onTap!(e),
            ))
        .toList());
  }
}

class CustomTransportMethod extends StatelessWidget {
  final TransportMethodModel? model;
  final double? width;
  final bool selected;
  final GestureTapCallback? onTap;

  const CustomTransportMethod(
      {Key? key, this.model, this.width, this.selected = false, this.onTap})
      : super(key: key);

  Widget _buildContainer(
      Widget child, Color backgroundColor, Color borderColor) {
    return Container(
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: borderColor),
          color: backgroundColor),
      padding: EdgeInsets.all(AppSizes.minPadding),
      child: child,
    );
  }

  Widget _buildSkeleton() {
    return _buildContainer(
        CustomShimmer(
          child: Column(
            children: [
              Row(
                children: [
                  CustomSkeleton(
                    width: 15.0,
                  ),
                  SizedBox(
                    width: AppSizes.minPadding,
                  ),
                  Expanded(child: CustomSkeleton())
                ],
              ),
              SizedBox(
                height: AppSizes.minPadding,
              ),
              CustomSkeleton()
            ],
          ),
        ),
        Colors.transparent,
        AppColors.hintColor);
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
      child: _buildContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CustomImageIcon(
                    icon: model!.typeShipping == 1
                        ? Assets.iconShippingExpress
                        : Assets.iconShippingSaving,
                    size: 20,
                  ),
                  SizedBox(
                    width: AppSizes.minPadding,
                  ),
                  Expanded(
                      child: AutoSizeText(
                    model!.text ?? "",
                    style: AppTextStyles.style14BlackBold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ))
                ],
              ),
              SizedBox(
                height: AppSizes.minPadding,
              ),
              Text(
                formatMoney(model!.transportCharge),
                style: AppTextStyles.style14PrimaryRegular,
              )
            ],
          ),
          selected
              ? AppColors.primaryColor.withOpacity(0.1)
              : Colors.transparent,
          selected ? AppColors.primaryColor : AppColors.greyC4Color),
      onTap: onTap,
    );
  }
}

class ContainerOrderDetail extends StatelessWidget {
  final List<BookingStaffModel>? staffModels;
  final double? quantity;
  final String? name;
  final double? discount;
  final String? type;
  final double? price;
  final double? amount;
  final String? note;
  final String? room;

  const ContainerOrderDetail(
      {super.key,
      this.staffModels,
      this.quantity,
      this.name,
      this.discount,
      this.type,
      this.price,
      this.amount,
      this.note,
      this.room});

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];
    if (staffModels != null) {
      for (var e in staffModels!) {
        children.add(CustomAvatar(
          url: e.staffAvatar,
          name: e.fullName,
          size: 26,
        ));
      }
    }
    if (room != null) {
      children.add(CustomChip(
        text: room,
        style: AppTextStyles.style14WhiteNormal,
      ));
    }
    return CustomListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        Row(
          children: [
            Expanded(
                child: Text.rich(TextSpan(
                    text: (quantity ?? 0.0).toString(),
                    style: AppTextStyles.style14BlackNormal,
                    children: [
                  TextSpan(text: " x ", style: AppTextStyles.style14HintNormal),
                  TextSpan(
                      text: name ?? "",
                      style: AppTextStyles.style14PrimaryRegular),
                ]))),
            if ((discount ?? 0) > 0) ...[
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Text(
                "(${hideMoney(discount, checkVisibilityKey(VisibilityWidgetName.OD000009))})",
                style: AppTextStyles.style12WhiteNormal
                    .copyWith(color: AppColors.orange500),
              )
            ]
          ],
        ),
        if (type != subjectTypeMemberCard)
          Row(
            children: [
              Text(
                hideMoney(
                    price, checkVisibilityKey(VisibilityWidgetName.OD000009)),
                style: AppTextStyles.style14HintNormal,
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Expanded(
                  child: Text(
                hideMoney(
                    amount, checkVisibilityKey(VisibilityWidgetName.OD000009)),
                style: AppTextStyles.style14BlackNormal,
                textAlign: TextAlign.right,
              ))
            ],
          ),
        Text(
          AppLocalizations.text(type == subjectTypeProduct
              ? LangKey.product
              : type == subjectTypeService
                  ? LangKey.service
                  : type == subjectTypeServiceCard
                      ? LangKey.service_card
                      : LangKey.service_card_activated)!,
          style: AppTextStyles.style14BlackNormal,
        ),
        if (children.isNotEmpty)
          Wrap(
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSizes.minPadding / 2,
            runSpacing: AppSizes.minPadding / 2,
            children: children,
          ),
        if ((note ?? "") != "")
          Text(
            note!,
            style: AppTextStyles.style14HintNormalItalic,
          )
      ],
    );
  }
}
