part of widget;

class ContainerCustomer extends StatelessWidget {
  final CustomerResponseModel? model;
  final Function? onLoadmore;
  final Function(CustomerModel)? onTap;

  const ContainerCustomer({this.model, this.onLoadmore, this.onTap, Key? key})
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
      return _buildContainer(List.generate(
          1,
          (index) => CustomCustomer(
                index: index,
              )).toList());
    }

    return _buildContainer(
        List.generate(
            model!.items!.length,
            (index) => CustomCustomer(
                index: index,
                model: model!.items![index],
                onTap: onTap == null
                    ? null
                    : () => onTap!(model!.items![index]))).toList(),
        onLoadmore: onLoadmore,
        showLoadmore: model!.pageInfo?.enableLoadmore);
  }
}

class CustomCustomer extends StatelessWidget {
  final int? index;
  final CustomerModel? model;
  final GestureTapCallback? onTap;

  const CustomCustomer({this.index, this.model, this.onTap, Key? key})
      : super(key: key);

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
            List.generate(5, (index) => CustomRowWithoutTitleInformation())
                .toList()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }

    if (model!.customerId == customerGuestId) {
      return InkWell(
        child: CustomGuestCustomer(),
        onTap: onTap,
      );
    }

    return InkWell(
        child: CustomContainerList(
          child: _buildContainer([
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                    child: Text.rich(TextSpan(
                        text:
                            "${model!.customerType == customerTypePersonal ? AppLocalizations.text(LangKey.personal) : AppLocalizations.text(LangKey.enterprise)} - ",
                        style: AppTextStyles.style14HintNormal,
                        children: [
                      TextSpan(
                          text: model!.fullName,
                          style: AppTextStyles.style14PrimaryBold)
                    ]))),
                if (index != null) ...[
                  SizedBox(
                    width: AppSizes.minPadding,
                  ),
                  CustomIndex(index: index!)
                ]
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: CustomListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    CustomRowWithoutTitleInformation(
                        icon: Assets.iconUserGroup,
                        text: model!.groupName ?? ""),
                    CustomRowWithoutTitleInformation(
                        icon: Assets.iconPhone, text: hidePhone(model!.phone,
                        checkVisibilityKey(VisibilityWidgetName.CM000004))),
                    CustomRowWithoutTitleInformation(
                        icon: Assets.iconUserSetting,
                        text: parseAndFormatDate(model!.createdAt)),
                  ],
                )),
                if ((model!.zalo ?? "").isNotEmpty && checkVisibilityKey(VisibilityWidgetName.CM000004)) ...[
                  SizedBox(
                    width: AppSizes.minPadding,
                  ),
                  InkWell(
                    child: Image.asset(
                      Assets.imageZalo,
                      height: AppSizes.sizeOnTap,
                    ),
                    onTap: () => launch(model!.zalo),
                  )
                ],
                if ((model!.phone ?? "").isNotEmpty && checkVisibilityKey(VisibilityWidgetName.CM000004)) ...[
                  SizedBox(
                    width: AppSizes.minPadding,
                  ),
                  InkWell(
                    child: CustomImageIcon(
                      icon: Assets.iconCallRound,
                      color: AppColors.green300,
                      size: AppSizes.sizeOnTap,
                    ),
                    onTap: () => callPhone(model!.phone),
                  )
                ]
              ],
            ),
          ]),
        ),
        onTap: onTap);
  }
}

class CustomGuestCustomer extends StatelessWidget {
  const CustomGuestCustomer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ContainerBooking(Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
          horizontal: AppSizes.maxPadding, vertical: AppSizes.minPadding),
      alignment: Alignment.center,
      child: Text(
        AppLocalizations.text(LangKey.walk_in_guest)!,
        style: AppTextStyles.style14PrimaryBold,
        textAlign: TextAlign.center,
      ),
    ));
  }
}

class CustomNoteCustomer extends StatelessWidget {
  final CustomerNoteModel? model;
  final int? index;

  const CustomNoteCustomer({super.key, this.index, this.model});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
        child: _buildContainer([
      CustomSkeleton(),
      Row(
        children: [
          CustomSkeleton(
            width: AppSizes.maxWidth! / 2,
          )
        ],
      ),
      Row(
        children: [
          CustomSkeleton(
            width: AppSizes.maxWidth! / 2,
          )
        ],
      ),
    ]));
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }

    String name, date;

    if (model!.staffUpdatedName != null) {
      name = model!.staffUpdatedName ?? "";
      date = model!.updatedAt ?? "";
    } else {
      name = model!.staffCreatedName ?? "";
      date = model!.createdAt ?? "";
    }

    return _buildContainer(
      [
        Text(
          model!.note ?? "",
          style: AppTextStyles.style14BlackNormal,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: CustomListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              children: [
                Text(
                  name,
                  style: AppTextStyles.style14HintNormal,
                ),
                Text(
                  parseAndFormatDate(date, format: AppFormat.formatDateTime),
                  style: AppTextStyles.style14HintNormal,
                ),
              ],
            )),
            if (index != null) ...[
              SizedBox(
                width: AppSizes.minPadding,
              ),
              CustomIndex(index: index!)
            ]
          ],
        ),
      ],
    );
  }
}

class CustomOrderCustomer extends StatelessWidget {
  final OrderModel? model;
  final GestureTapCallback? onTap;

  const CustomOrderCustomer({super.key, this.model, this.onTap});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(4, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
        child: _buildContainer(
          [
            Row(
              children: [
                Expanded(
                  child: CustomRowWithoutTitleInformation(
                    icon: Assets.iconUser,
                    text: model!.orderCode ?? "",
                    textStyle: AppTextStyles.style14BlackBold,
                  ),
                ),
                CustomChip(
                  text: model!.processStatusName,
                  backgroundColor: HexColor(model!.processStatusColor),
                  style: AppTextStyles.style12WhiteBold,
                )
              ],
            ),
            CustomRowWithoutTitleInformation(
              icon: Assets.iconBranch,
              text: model!.branchName ?? "",
            ),
            CustomRowWithoutTitleInformation(
                icon: Assets.iconClockFill, text: model!.orderDate ?? ""),
            CustomRowWithoutTitleInformation(
              icon: Assets.iconMoney,
              child: Text.rich(TextSpan(
                  text: hideMoney(model!.amount, checkVisibilityKey(VisibilityWidgetName.CM000007)),
                  style: AppTextStyles.style14PrimaryRegular,
                  children: ((model!.owed ?? 0) > 0) ? [
                    TextSpan(
                        text: " (${hideMoney(model!.owed, checkVisibilityKey(VisibilityWidgetName.CM000007))})",
                        style: AppTextStyles.style14DarkRedNormal)
                  ] : null)),
            ),
            if ((model!.orderDetail?.length ?? 0) > 0)
              Column(
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
                          "${formatMoney(model!.orderDetail!.first.price)}${(model!.orderDetail!.first.unitName ?? "").isEmpty ? "" : " / ${model!.orderDetail!.first.unitName}"}",
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
          ],
        ),
        onTap: onTap);
  }
}

class CustomDebtCustomer extends StatelessWidget {
  final CustomerDebtModel? model;
  final GestureTapCallback? onTap;
  final GestureTapCallback? onOrderTap;

  const CustomDebtCustomer({super.key, this.model, this.onOrderTap, this.onTap});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(5, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
      child: _buildContainer(
        [
          Row(
            children: [
              Expanded(
                child: CustomRowWithoutTitleInformation(
                  icon: Assets.iconBarcode,
                  text: model!.debtCode ?? "",
                  textStyle: AppTextStyles.style14BlackBold,
                ),
              ),
              CustomChip(
                text: model!.statusName,
                backgroundColor: HexColor(model!.statusColor),
                style: AppTextStyles.style12WhiteBold,
              )
            ],
          ),
          InkWell(
            child: Text.rich(TextSpan(
                text: model!.debtTypeName ?? "",
                style: AppTextStyles.style14BlackNormal,
                children: (model!.orderCode ?? "").isNotEmpty
                    ? [
                  TextSpan(
                      text: " - ${model!.orderCode ?? ""}",
                      style: AppTextStyles.style14PrimaryRegular)
                ]
                    : null)),
            onTap: (model!.orderCode ?? "").isNotEmpty ? onOrderTap : null,
          ),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconMoney,
              child: Text.rich(TextSpan(
                  text: formatMoney(model!.paid),
                  style: AppTextStyles.style14PrimaryRegular,
                  children: ((model!.owed ?? 0) > 0) ? [
                    TextSpan(
                        text: " (${formatMoney(model!.owed)})",
                        style: AppTextStyles.style14DarkRedNormal)
                  ] : null))),
          CustomRowWithoutTitleInformation(
            icon: Assets.iconBranch,
            text: model!.branchName ?? "",
            textStyle: AppTextStyles.style14HintNormal,
          ),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconClockFill,
              text: parseAndFormatDate(model!.updatedAt ?? model!.createdAt,
                  format: AppFormat.formatDateTime)),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconUser,
              text: model!.staffUpdatedName ?? model!.staffCreatedName ?? ""),
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomPaymentCustomer extends StatelessWidget {
  final CustomerReceiptModel? model;
  const CustomPaymentCustomer({super.key, this.model});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(5, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return _buildContainer(
      [
        Row(
          children: [
            Expanded(
              child: CustomRowWithoutTitleInformation(
                icon: Assets.iconBarcode,
                text: model!.orderCode ?? "",
                textStyle: AppTextStyles.style14BlackBold,
              ),
            ),
            CustomChip(
              text: model!.statusName,
              backgroundColor: HexColor(model!.statusColor),
              style: AppTextStyles.style12WhiteBold,
            )
          ],
        ),
        Text.rich(TextSpan(
            text: model!.receiptTypeNameVi ?? "",
            style: AppTextStyles.style14BlackNormal,
            children: (model!.orderCode ?? "").isNotEmpty
                ? [
                    TextSpan(
                        text: " - ${model!.orderCode ?? ""}",
                        style: AppTextStyles.style14PrimaryRegular)
                  ]
                : null)),
        CustomRowWithoutTitleInformation(
            icon: Assets.iconMoney,
            child: Text.rich(TextSpan(
                text: formatMoney(model!.paid),
                style: AppTextStyles.style14PrimaryRegular,
                children: ((model!.owed ?? 0) > 0) ? [
                  TextSpan(
                      text: " (${formatMoney(model!.owed)})",
                      style: AppTextStyles.style14DarkRedNormal)
                ] : null))),
        CustomRowWithoutTitleInformation(
          icon: Assets.iconBranch,
          text: model!.branchName ?? "",
          textStyle: AppTextStyles.style14HintNormal,
        ),
        CustomRowWithoutTitleInformation(
            icon: Assets.iconClockFill,
            text: parseAndFormatDate(model!.updatedAt ?? model!.createdAt,
                format: AppFormat.formatDateTime)),
        CustomRowWithoutTitleInformation(
            icon: Assets.iconUser,
            text: model!.staffUpdatedName ?? model!.staffCreatedName ?? ""),
      ],
    );
  }
}

class CustomAppointmentCustomer extends StatelessWidget {
  final BookingListModel? model;
  final GestureTapCallback? onTap;

  const CustomAppointmentCustomer({super.key, this.model, this.onTap});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(4, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
      child: _buildContainer(
        [
          Row(
            children: [
              Expanded(
                  child: Text(
                    model!.customerAppointmentCode ?? "",
                    style: AppTextStyles.style14PrimaryBold,
                  )),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              CustomChip(
                text: model!.statusName,
                style: AppTextStyles.style12WhiteBold,
                backgroundColor: model!.colorPrimary,
              )
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                    model!.branchName ?? "",
                    style: AppTextStyles.style14BlackNormal,
                  )),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Text(
                parseAndFormatDate(model!.date,
                    parse: AppFormat.formatDateCreate),
                style: AppTextStyles.style14BlackBold,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: Text(
                    hidePhone(model!.phone,
                        checkVisibilityKey(VisibilityWidgetName.CM000004)),
                    style: AppTextStyles.style14BlackNormal,
                  )),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Text(
                model!.time ?? "",
                style: AppTextStyles.style14BlackBold,
              )
            ],
          ),
          if ((model!.description ?? "").isNotEmpty)
            Text(
              model!.description!,
              style: AppTextStyles.style14HintNormalItalic,
            ),
          if ((model!.appointmentDetail?.length ?? 0) > 0) ...[
            CustomLine(),
            Text(
              "[${model!.appointmentDetail!.first.objectCode ?? ""}] ${model!.appointmentDetail!.first.serviceName}",
              style: AppTextStyles.style14BlackNormal,
            ),
            Row(
              children: [
                Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      spacing: AppSizes.minPadding / 2,
                      runSpacing: AppSizes.minPadding / 2,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        if (model!.appointmentDetail!.first.staffName != null)
                          CustomAvatar(
                            url: model!.appointmentDetail!.first.staffAvatar,
                            name: model!.appointmentDetail!.first.staffName,
                            size: 26,
                          ),
                        if (model!.appointmentDetail!.first.roomName != null)
                          CustomChip(
                            text: model!.appointmentDetail!.first.roomName,
                            style: AppTextStyles.style12WhiteBold,
                          )
                      ],
                    )),
                SizedBox(
                  width: AppSizes.minPadding,
                ),
                Text(
                  formatMoney(model!.appointmentDetail!.first.price),
                  style: AppTextStyles.style14BlackNormal,
                )
              ],
            ),
            CustomLine()
          ],
          Row(
            children: [
              Expanded(
                  child: CustomRowWithoutTitleInformation(
                    icon: Assets.iconMoney,
                    text: formatMoney(model!.total),
                    textStyle: AppTextStyles.style14BlackBold,
                  )),
              if ((model!.appointmentDetail?.length ?? 0) > 1) ...[
                SizedBox(
                  width: AppSizes.minPadding,
                ),
                Text.rich(
                  TextSpan(
                      text: AppLocalizations.text(LangKey.and)!.toLowerCase(),
                      style: AppTextStyles.style13HintNormal,
                      children: [
                        TextSpan(
                            text: " ${model!.appointmentDetail!.length - 1} ",
                            style: AppTextStyles.style14PrimaryBold),
                        TextSpan(
                          text: AppLocalizations.text(LangKey.other_services)!
                              .toLowerCase(),
                          style: AppTextStyles.style13HintNormal,
                        )
                      ]),
                )
              ]
            ],
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomServiceCardCustomer extends StatelessWidget {
  final CustomerServiceCardModel? model;
  final GestureTapCallback? onTap;

  const CustomServiceCardCustomer({super.key, this.model, this.onTap});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(4, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
      child: _buildContainer(
        [
          Row(
            children: [
              Expanded(
                child: CustomRowWithoutTitleInformation(
                  icon: Assets.iconCard,
                  text: model!.name ?? "",
                  textStyle: AppTextStyles.style14PrimaryBold,
                ),
              ),
              CustomChip(
                text: model!.statusName,
                backgroundColor: model!.status == 1
                    ? AppColors.primaryColor
                    : AppColors.darkRedColor,
                style: AppTextStyles.style12WhiteBold,
              )
            ],
          ),
          Row(
            children: [
              Expanded(
                  child: CustomRowWithoutTitleInformation(
                      icon: Assets.iconBarcode, text: model!.cardCode ?? "")),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Text.rich(TextSpan(
                  text: "${model!.numberUsing ?? 0}(",
                  style: AppTextStyles.style14HintNormal,
                  children: [
                    TextSpan(
                        text: "${model!.countUsing ?? 0}",
                        style: AppTextStyles.style14DarkRedNormal),
                    TextSpan(
                      text: ")",
                      style: AppTextStyles.style14HintNormal,
                    )
                  ]))
            ],
          ),
          CustomRowWithoutTitleInformation(
            icon: Assets.iconMoney,
            text: formatMoney(model!.price),
          ),
          CustomRowWithoutTitleInformation(
            icon: Assets.iconClockFill,
            text: parseAndFormatDate(model!.expiredDate),
            textStyle: AppTextStyles.style14BlackBold,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomCareCustomer extends StatelessWidget {
  final CustomerWorkModel? model;
  final GestureTapCallback? onTap;

  const CustomCareCustomer({super.key, this.model, this.onTap});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(4, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
      child: _buildContainer(
        [
          Row(
            children: [
              Expanded(
                child: Text.rich(TextSpan(
                    text: model!.manageWorkCode ?? "",
                    style: AppTextStyles.style14PrimaryBold,
                    children: [
                      TextSpan(
                          text: " ${model!.manageWorkTitle ?? ""}",
                          style: AppTextStyles.style14PrimaryRegular)
                    ])),
              ),
              CustomChip(
                text: model!.manageStatusName,
                backgroundColor: HexColor(model!.manageStatusColor),
                style: AppTextStyles.style12WhiteBold,
              )
            ],
          ),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconBag, text: model!.manageTypeWorkName ?? ""),
          CustomRowWithoutTitleInformation(
            icon: Assets.iconClockFill,
            text: parseAndFormatDate(model!.dateEnd),
            textStyle: AppTextStyles.style14BlackBold,
          ),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconUser, text: model!.staffCreatedName ?? ""),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconBranch, text: model!.branchName ?? ""),
          CustomHtml(
            model!.description ?? "",
            physics: NeverScrollableScrollPhysics(),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomDealCustomer extends StatelessWidget {
  final CustomerDealModel? model;
  final GestureTapCallback? onTap;

  const CustomDealCustomer({super.key, this.model, this.onTap});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(5, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return InkWell(
      child: _buildContainer(
        [
          Row(
            children: [
              Expanded(
                child: CustomRowWithoutTitleInformation(
                  icon: Assets.iconBarcode,
                  text: model!.dealName ?? "",
                  textStyle: AppTextStyles.style14PrimaryBold,
                ),
              ),
              CustomChip(
                text: model!.journeyName,
                backgroundColor: HexColor(model!.statusColor),
                style: AppTextStyles.style12WhiteBold,
              )
            ],
          ),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconUser, text: model!.ownerName ?? ""),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconPhone, text: model!.phone ?? ""),
          CustomRowWithoutTitleInformation(
            icon: Assets.iconClockFill,
            text: parseAndFormatDate(model!.dateAssign,
                format: AppFormat.formatDateTime),
            textStyle: AppTextStyles.style14BlackBold,
          ),
          CustomRowWithoutTitleInformation(
              icon: Assets.iconUserConnect, text: model!.saleName ?? ""),
          CustomRowWithoutTitleInformation(
            icon: Assets.iconClockUpdate,
            child: Text.rich(TextSpan(
                text: parseAndFormatDate(model!.closingDate,
                    parse: AppFormat.formatDateCreate),
                style: AppTextStyles.style14BlackNormal,
                children: [
                  TextSpan(
                      text:
                      " (${model!.distanceDays ?? 0} ${AppLocalizations.text(LangKey.day)!.toLowerCase()})",
                      style: AppTextStyles.style14PrimaryRegular)
                ])),
          ),
          CustomRowWithoutTitleInformation(
            icon: Assets.iconMoney,
            text: formatMoney(model!.amount),
            textStyle: AppTextStyles.style14PrimaryBold,
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomStaffCustomer extends StatelessWidget {
  final CustomerStaffModel? model;

  const CustomStaffCustomer({super.key, this.model});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(5, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return _buildContainer(
      [
        Row(
          children: [
            Expanded(
                child: CustomRowWithoutTitleInformation(
                    icon: Assets.iconUser, text: model!.staffName ?? "")),
            if(model!.primaryName != null)
              ...[
                SizedBox(
                  width: AppSizes.minPadding,
                ),
                CustomChip(
                  text: model!.primaryName,
                  backgroundColor: HexColor(model!.statusColor),
                  style: AppTextStyles.style12WhiteBold,
                )
              ]
          ],
        ),
        CustomRowWithoutTitleInformation(
            icon: Assets.iconBag, text: model!.staffTitleName ?? ""),
        CustomRowWithoutTitleInformation(
            icon: Assets.iconPhone, text: model!.phone ?? ""),
        CustomRowWithoutTitleInformation(
          icon: Assets.iconClockFill,
          text: parseAndFormatDate(model!.updatedAt ?? model!.createdAt,
              format: AppFormat.formatDateTime),
        ),
        CustomRowWithoutTitleInformation(
            icon: Assets.iconBranch, text: model!.branchName ?? ""),
      ],
    );
  }
}

class CustomContactCustomer extends StatelessWidget {
  final CustomerContactModel? model;

  const CustomContactCustomer({super.key, this.model});

  Widget _buildContainer(List<Widget> children) {
    return CustomListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: _buildContainer(
          List.generate(5, (index) => CustomRowWithoutTitleInformation())
              .toList()),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }
    return _buildContainer(
      [
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                CustomRowWithoutTitleInformation(
                  icon: Assets.iconUser,
                  text: model!.contactName ?? "",
                  textStyle: AppTextStyles.style14BlackBold,
                ),
                SizedBox(
                  height: AppSizes.minPadding,
                ),
                CustomRowWithoutTitleInformation(
                    icon: Assets.iconPhone, text: model!.contactPhone ?? ""),
              ],
            )),
            if ((model!.contactPhone ?? "").isNotEmpty) ...[
              SizedBox(
                width: AppSizes.minPadding,
              ),
              InkWell(
                child: CustomImageIcon(
                  icon: Assets.iconCallRound,
                  color: AppColors.green300,
                  size: AppSizes.sizeOnTap,
                ),
                onTap: () => callPhone(model!.contactPhone),
              )
            ]
          ],
        ),
        CustomRowWithoutTitleInformation(
            icon: Assets.iconUserStand, text: model!.staffTitleName ?? ""),
        CustomRowWithoutTitleInformation(
            icon: Assets.iconMail, text: model!.contactEmail ?? ""),
        CustomRowWithoutTitleInformation(
          icon: Assets.iconClockFill,
          text: parseAndFormatDate(model!.updatedAt ?? model!.createdAt,
              format: AppFormat.formatDateTime),
        ),
        CustomRowWithoutTitleInformation(
          icon: Assets.iconUserSetting,
          text: model!.staffCreatedName ?? "",
          textStyle: AppTextStyles.style14PrimaryBold,
        ),
      ],
    );
  }
}

class CustomFileCustomer extends StatelessWidget {
  final CustomerFileModel? model;

  const CustomFileCustomer({super.key, this.model});

  Widget _buildSkeleton() {
    return CustomShimmer(
      child: Container(
        padding: EdgeInsets.all(AppSizes.maxPadding),
        child: Row(
          children: [
            CustomSkeleton(
              width: AppSizes.sizeOnTap,
              height: AppSizes.sizeOnTap,
              radius: 0.0,
            ),
            Container(
              width: AppSizes.minPadding,
            ),
            Expanded(child: CustomSkeleton()),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (model == null) {
      return _buildSkeleton();
    }

    if ((model!.link ?? "") == "") {
      return Container();
    }

    String path = model!.link!.split(".").last;

    String? image = pathToImage(path);
    bool isImage = false;

    if (image == null) {
      image = model!.link;
      isImage = true;
    }

    String name, date;

    if (model!.staffUpdatedName != null) {
      name = model!.staffUpdatedName ?? "";
      date = model!.updatedAt ?? "";
    } else {
      name = model!.staffCreatedName ?? "";
      date = model!.createdAt ?? "";
    }

    return InkWell(
      child: CustomListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              isImage
                  ? CustomNetworkImage(
                width: AppSizes.sizeOnTap,
                height: AppSizes.sizeOnTap,
                url: image,
              )
                  : Image.asset(
                image!,
                width: AppSizes.sizeOnTap,
              ),
              Container(
                width: AppSizes.minPadding,
              ),
              Expanded(
                  child: Text(
                    model!.fileName ?? "",
                    style: AppTextStyles.style13BlackNormal,
                  )),
            ],
          ),
          Text(
            name,
            style: AppTextStyles.style14HintNormal,
          ),
          Text(
            parseAndFormatDate(date, format: AppFormat.formatDateTime),
            style: AppTextStyles.style14HintNormal,
          ),
        ],
      ),
      onTap: () => openFile(context, model!.fileName, model!.link),
    );
  }
}

class CustomHeaderCustomer extends StatelessWidget {
  final CustomerDetailResponseModel model;
  const CustomHeaderCustomer({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
            child: Text.rich(TextSpan(
                text:
                    "${model.customerType == customerTypePersonal ? AppLocalizations.text(LangKey.personal) : AppLocalizations.text(LangKey.enterprise)} - ",
                style: AppTextStyles.style14HintNormal,
                children: [
              TextSpan(
                  text: model.fullName ?? "",
                  style: AppTextStyles.style14PrimaryRegular)
            ])))
      ],
    );
  }
}
