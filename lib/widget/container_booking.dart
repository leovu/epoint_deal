part of widget;

class ContainerBooking extends StatelessWidget {
  final Widget child;
  final GestureTapCallback? onTap;
  final bool isSelected;

  const ContainerBooking(this.child,
      {Key? key, this.onTap, this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.whiteColor,
            border: Border.all(
                color:
                    isSelected ? AppColors.primaryColor : AppColors.whiteColor),
            boxShadow: isSelected
                ? null
                : [
                    BoxShadow(
                      color: AppColors.blackColor.withOpacity(0.25),
                      blurRadius: 2.0,
                      offset: Offset.zero,
                    )
                  ]),
        child: child,
      ),
      onTap: onTap,
    );
  }
}

class CustomBookingCustomer extends StatelessWidget {
  final CustomerModel? model;
  final GestureTapCallback? onRemove;
  final GestureTapCallback? onTap;

  const CustomBookingCustomer({this.model, Key? key, this.onRemove, this.onTap})
      : super(key: key);

  Widget _buildRow(BuildContext context, String? text, {TextStyle? style}) {
    return InkWell(
      child: Row(
        children: [
          Flexible(
              child: Text(
            text ?? "",
            style: style ?? AppTextStyles.style14BlackNormal,
          )),
          if ((text ?? "").isNotEmpty)
            Padding(
              padding: EdgeInsets.only(left: AppSizes.minPadding / 2),
              child: CustomImageIcon(
                icon: Assets.iconCopy,
                size: 16,
                color: AppColors.hintColor,
              ),
            )
        ],
      ),
      onTap: (text ?? "").isEmpty ? null : () => copyText(context, text!),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return Text(
        AppLocalizations.text(LangKey.you_have_not_selected_a_customer)!,
        style: AppTextStyles.style14HintNormalItalic,
      );
    }

    if (model!.customerId == customerGuestId) {
      return CustomGuestCustomer();
    }

    return ContainerBooking(Padding(
      padding: EdgeInsets.all(AppSizes.minPadding),
      child: Row(
        children: [
          CustomAvatar(
            url: model!.customerAvatar,
            name: model!.fullName,
            size: 60.0,
          ),
          SizedBox(
            width: AppSizes.minPadding,
          ),
          Expanded(
              child: CustomListView(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            children: [
              _buildRow(context, model!.fullName,
                  style: AppTextStyles.style14PrimaryBold),
              if ((model!.customerTypeName ?? "").isNotEmpty)
                Text(
                  model!.customerTypeName ?? "",
                  style: AppTextStyles.style14HintNormal,
                ),
              if ((model!.phone ?? "").isNotEmpty)
                _buildRow(context, hidePhone(model!.phone,
                    checkVisibilityKey(VisibilityWidgetName.CM000004))),
            ],
          )),
          SizedBox(
            width: AppSizes.minPadding,
          ),
          if (onRemove != null)
            CustomIconButton(
              icon: Assets.iconTrash,
              color: AppColors.red500,
              onTap: onRemove,
            )
          else if ((model!.phone ?? "").isNotEmpty && checkVisibilityKey(VisibilityWidgetName.CM000004)) ...[
            CustomIconButton(
              icon: Assets.iconMessage,
              onTap: () => sendSMS(model!.phone),
            ),
            CustomIconButton(
              icon: Assets.iconPhone,
              onTap: () => callPhone(model!.phone),
            ),
          ],
          // if (checkVisibilityKey(VisibilityWidgetName.CM000002))
          //   CustomIconButton(
          //     icon: Assets.iconInfo,
          //     onTap: onTap ??
          //         (checkVisibilityKey(VisibilityWidgetName.CM000002)
          //             ? () {
          //                 CustomNavigator.push(
          //                     context, CustomerDetailScreen(model!.customerId));
          //               }
          //             : null),
          //   ),
        ],
      ),
    ));
  }
}

class ContainerServiceBooking extends StatelessWidget {
  final List<ServiceNewModel>? models;
  final Function(ServiceNewModel)? onDelete;
  final Function(ServiceNewModel)? onTap;
  final String? hint;

  const ContainerServiceBooking(
      {Key? key, this.models, this.onDelete, this.hint, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerDataBuilder(
      data: models ?? [],
      emptyBuilder: Text(
        hint ??
            AppLocalizations.text(LangKey.you_have_not_selected_the_service)!,
        style: AppTextStyles.style14HintNormalItalic,
      ),
      emptyPhysics: NeverScrollableScrollPhysics(),
      emptyShinkWrap: true,
      bodyBuilder: () => CustomListView(
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
        children: models!.map((e) {
          List<Widget> children = [];
          double price = e.changePrice ?? e.newPrice ?? 0.0;
          if (e.staffModels != null) {
            for (var e in e.staffModels!) {
              children.add(CustomAvatar(
                url: e.staffAvatar,
                name: e.fullName,
                size: 26,
              ));
            }
          }
          if (e.roomModel != null) {
            children.add(CustomChip(
              text: e.roomModel!.text,
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
                      e.serviceName ?? "",
                      style: AppTextStyles.style14BlackNormal,
                    ),
                    Text(
                      e.serviceCode ?? "",
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
                    if ((e.note ?? "").isNotEmpty)
                      Text(
                        e.note!,
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
                    if (e.voucherModel != null) ...[
                      Row(
                        children: [
                          Image.asset(
                            getVoucherImage(e.voucherModel!),
                            width: 14.0,
                          ),
                          SizedBox(
                            width: AppSizes.minPadding / 2,
                          ),
                          Text(
                            formatMoney(e.discount),
                            style: AppTextStyles.style13HintNormal,
                          )
                        ],
                      ),
                      SizedBox(
                        height: AppSizes.minPadding / 2,
                      ),
                    ],
                    Text(
                      formatMoney(getBookingAmount(
                          price, (e.discount ?? 0.0), (e.surcharge ?? 0.0))),
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
                    onTap: () => onDelete!(e),
                  )
                ]
              ],
            ),
            onTap: onTap == null ? null : () => onTap!(e),
          );
        }).toList(),
      ),
    );
  }
}

class ContainerServiceCardBooking extends StatelessWidget {
  final List<ServiceCardModel>? models;
  final Function(ServiceCardModel)? onDelete;
  final Function(ServiceCardModel)? onTap;
  final String? hint;

  const ContainerServiceCardBooking(
      {Key? key, this.models, this.onDelete, this.hint, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerDataBuilder(
      data: models ?? [],
      emptyBuilder: Text(
        hint ??
            AppLocalizations.text(
                LangKey.you_have_not_selected_the_service_card)!,
        style: AppTextStyles.style14HintNormalItalic,
      ),
      emptyPhysics: NeverScrollableScrollPhysics(),
      emptyShinkWrap: true,
      bodyBuilder: () => CustomListView(
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
        children: models!.map((e) {
          List<Widget> children = [];
          double price = e.price ?? 0.0;
          if (e.staffModels != null) {
            for (var e in e.staffModels!) {
              children.add(CustomAvatar(
                url: e.staffAvatar,
                name: e.fullName,
                size: 26,
              ));
            }
          }
          if (e.roomModel != null) {
            children.add(CustomChip(
              text: e.roomModel!.text,
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
                      e.name ?? "",
                      style: AppTextStyles.style14BlackNormal,
                    ),
                    Text(
                      e.cardCode ?? "",
                      style: AppTextStyles.style13HintNormal,
                    ),
                    if (children.isNotEmpty)
                      Wrap(
                        spacing: AppSizes.minPadding / 2,
                        runSpacing: AppSizes.minPadding / 2,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: children,
                      ),
                    if ((e.note ?? "").isNotEmpty)
                      Text(
                        e.note!,
                        style: AppTextStyles.style14HintNormalItalic,
                      )
                  ],
                )),
                SizedBox(
                  width: AppSizes.minPadding / 2,
                ),
                Text(
                  formatMoney(price + (e.surcharge ?? 0.0)),
                  style: AppTextStyles.style14BlackNormal,
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
                    onTap: () => onDelete!(e),
                  )
                ]
              ],
            ),
            onTap: onTap == null ? null : () => onTap!(e),
          );
        }).toList(),
      ),
    );
  }
}

class CustomBookingStatus extends StatelessWidget {
  final String? status;
  final String? statusName;
  final Color? statusColor;
  final String? subTitle;
  final List<BookingStatusUpdateModel>? models;
  final Function(BookingStatusUpdateModel)? onChanged;
  final GestureTapCallback? onTap;

  const CustomBookingStatus(
      {Key? key,
      this.status,
      this.statusName,
      this.statusColor,
      this.subTitle,
      this.models,
      this.onChanged,
      this.onTap})
      : super(key: key);

  _showOptions(BuildContext context) {
    List<CustomBottomOptionModel> options = models!
        .map((e) => CustomBottomOptionModel(
            text: e.statusName,
            textColor: e.colorPrimary,
            isSelected: status == e.status,
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
    return InkWell(
      child: ContainerBooking(Padding(
        padding: EdgeInsets.all(AppSizes.minPadding),
        child: Row(
          children: [
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: statusColor),
              child: Center(
                child: Icon(
                  Icons.star_border_rounded,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            SizedBox(
              width: AppSizes.minPadding,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    statusName ?? "",
                    style: AppTextStyles.style15BlackBold,
                    textAlign: TextAlign.center,
                  ),
                  if ((subTitle ?? "").isNotEmpty) ...[
                    SizedBox(
                      height: AppSizes.minPadding,
                    ),
                    Text(
                      subTitle!,
                      style: AppTextStyles.style13HintNormal,
                    )
                  ]
                ],
              ),
            ),
            if (isEdit)
              Padding(
                padding: EdgeInsets.only(left: AppSizes.minPadding),
                child: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.blackColor,
                ),
              )
          ],
        ),
      )),
      onTap: onTap ?? (isEdit ? () => _showOptions(context) : null),
    );
  }
}

class CustomBookingStaff extends StatelessWidget {
  final BookingStaffModel? model;
  final bool isPadding;
  final GestureTapCallback? onTap;

  const CustomBookingStaff(
      {Key? key, this.model, this.isPadding = true, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: isPadding ? AppSizes.maxPadding : 0.0,
            vertical: AppSizes.minPadding),
        alignment: Alignment.centerLeft,
        child: model == null
            ? CustomShimmer(
                child: CustomSkeleton(
                  width: AppSizes.maxWidth! / 2,
                ),
              )
            : Row(
                children: [
                  CustomAvatar(
                    url: model!.staffAvatar,
                    name: model!.fullName,
                    size: 60.0,
                  ),
                  Container(
                    width: AppSizes.minPadding,
                  ),
                  Expanded(
                      child: Text(
                    model!.fullName ?? "",
                    style: AppTextStyles.style15BlackNormal,
                  )),
                ],
              ),
      ),
      onTap: model == null ? null : onTap,
    );
  }
}

final _maxItemOnCell = 4;

class CustomBookingWeek extends StatelessWidget {
  final List<BookingListModel>? models;
  final int? index;

  const CustomBookingWeek({Key? key, this.models, this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (index == _maxItemOnCell - 1) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            color: AppColors.hintColor),
        alignment: Alignment.center,
        child: AutoSizeText(
          (models!.length - index!).toString(),
          style: AppTextStyles.style12WhiteNormal,
          minFontSize: 1,
        ),
      );
    }

    BookingListModel model = models![index!];
    DateTime date = parseDate(model.time, parse: AppFormat.formatTime)!;

    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(
          top: date.minute % AppSizes.totalMinuteOfTimeline != 0
              ? AppSizes.timelineHeight / 2
              : 0,
          right: 1.0,
          left: 1.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: model.colorPrimary,
                borderRadius: BorderRadius.vertical(top: Radius.circular(5.0))),
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 2.0),
            child: AutoSizeText(
              model.time ?? "",
              style: AppTextStyles.style12WhiteNormal
                  .copyWith(color: model.colorText),
              maxLines: 1,
              minFontSize: 1,
            ),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: model.colorSub,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(5.0))),
            alignment: Alignment.center,
            child: AutoSizeText(
              model.customerName ?? "",
              style: AppTextStyles.style12BlackNormal
                  .copyWith(color: model.colorPrimary),
              maxLines: 1,
              minFontSize: 1,
            ),
          ))
        ],
      ),
    );
  }
}

class CustomBookingCell extends StatelessWidget {
  final bool selected;
  final List<BookingListModel>? models;
  final double? positioned;
  final GestureTapCallback? onTap;

  const CustomBookingCell(
      {Key? key,
      this.selected = false,
      this.models,
      this.positioned,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        width: double.infinity,
        height: AppSizes.timelineHeight,
        decoration: BoxDecoration(
            border: Border.all(
                color:
                    selected ? AppColors.primaryColor : AppColors.borderColor),
            color: selected
                ? AppColors.primaryColor.withAlpha(50)
                : Colors.transparent),
        child: Stack(
          children: [
            if (models!.isNotEmpty)
              Positioned(
                top: 0.0,
                right: 0.0,
                left: 0.0,
                bottom: 0.0,
                child: Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Row(
                    children: List.generate(
                        models!.length > _maxItemOnCell
                            ? _maxItemOnCell
                            : models!.length,
                        (index) => Expanded(
                              child: CustomBookingWeek(
                                models: models,
                                index: index,
                              ),
                            )).toList(),
                  ),
                ),
              ),
            if (positioned != null)
              Positioned(
                top: positioned,
                left: 0.0,
                right: 0.0,
                child: CustomLine(
                  color: AppColors.red500,
                  size: 2.0,
                ),
              )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}

class CustomBookingTimeTitle extends StatelessWidget {
  final int? index;

  const CustomBookingTimeTitle({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.timeWidth,
      height: AppSizes.timelineHeight,
      alignment: Alignment.topRight,
      padding: EdgeInsets.symmetric(horizontal: 2.0),
      child: index! % 2 == 0
          ? AutoSizeText(
              (index! ~/ 2).toString(),
              style: AppTextStyles.style12BlackNormal,
              minFontSize: 1,
              maxLines: 1,
              textAlign: TextAlign.right,
            )
          : SizedBox(),
    );
  }
}

class CustomTypeBooking extends StatelessWidget {
  final bool value;
  final Function(bool) onChanged;
  final String? text1;
  final String? text2;

  const CustomTypeBooking(
      {super.key,
      required this.onChanged,
      required this.value,
      this.text1,
      this.text2});

  Widget _buildBody(String text, bool selected) {
    return Expanded(
        child: InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: selected ? AppColors.primaryColor : null),
        padding: EdgeInsets.all(AppSizes.maxPadding),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.style13HintNormal.copyWith(
                color: selected ? AppColors.whiteColor : AppColors.hintColor),
          ),
        ),
      ),
      onTap: () {
        if (!selected) {
          onChanged(!value);
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.maxPadding * 2),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: AppColors.whiteColor,
          boxShadow: [
            BoxShadow(
                offset: Offset(0, 0),
                blurRadius: 4.0,
                color: AppColors.blackColor.withOpacity(0.25))
          ],
        ),
        child: Row(
          children: [
            _buildBody(
                text1 ?? AppLocalizations.text(LangKey.directly)!, value),
            _buildBody(
                text2 ?? AppLocalizations.text(LangKey.appointment)!, !value),
          ],
        ),
      ),
    );
  }
}

class CustomBookingDiscount extends StatelessWidget {
  final DiscountCartModel? model;
  final FocusNode focusNode;
  final TextEditingController controller;
  final GestureTapCallback onChoose;
  final GestureTapCallback onRemove;

  const CustomBookingDiscount(
      {super.key,
      this.model,
      required this.focusNode,
      required this.controller,
      required this.onChoose,
      required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return CustomRowInformation(
      icon: Assets.iconTagPercent,
      title: AppLocalizations.text(LangKey.discount),
      child: CustomTextField(
        focusNode: focusNode,
        controller: controller,
        titleImage: model == null ? null : getVoucherImage(model!),
        hintText: AppLocalizations.text(LangKey.apply_promotion),
        readOnly: true,
        backgroundColor: Colors.transparent,
        borderColor: AppColors.borderColor,
        suffixIcon: model == null ? Assets.iconPlus : Assets.iconTrash,
        colorIcons:
            model == null ? AppColors.primaryColor : AppColors.darkRedColor,
        onSuffixTap: model == null ? onChoose : onRemove,
      ),
    );
  }
}
