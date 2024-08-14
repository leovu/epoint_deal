part of widget;

class CustomProject extends StatelessWidget {
  final ProjectListModel? model;
  final GestureTapCallback? onTap;

  const CustomProject({Key? key, this.model, this.onTap}) : super(key: key);

  Widget _buildRow(String? title, String content, {Color? contentColor}) {
    return Row(
      children: [
        Text(
          title ?? "",
          style: AppTextStyles.style14BlackNormal,
        ),
        SizedBox(
          width: AppSizes.minPadding,
        ),
        Expanded(
          child: Text(
            content,
            style: AppTextStyles.style14BlackBold
                .copyWith(color: contentColor ?? AppColors.primaryColor),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if(model == null) {
      return CustomEmpty(
        title: AppLocalizations.text(LangKey.data_empty),
      );
    }
    return CustomContainerList(
      child: CustomListView(
        padding: EdgeInsets.symmetric(
            horizontal: AppSizes.minPadding, vertical: AppSizes.minPadding),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  model!.projectName ?? AppLocalizations.text(LangKey.data_empty)!,
                  style: AppTextStyles.style18BlackBold,
                ),
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              model!.projectStatusName == null ? Container() : CustomChip(
                  style: AppTextStyles.style14WhiteW500,
                  text: model!.projectStatusName ?? "",
                  backgroundColor: Color(
                      HexColor.getColorFromHex(model!.projectStatusColor))),
            ],
          ),
          Wrap(
              spacing: 6.0,
              runSpacing: 5.0,
              children: List<Widget>.generate(
                  model!.tag?.length ?? 0,
                  (i) => CustomTag(
                        padding: EdgeInsets.symmetric(
                            vertical: 6.0, horizontal: 10.0),
                        backgroundColor:
                            AppColors.functionFrequentlyAskedQuestions,
                        name: model!.tag![i].manageTagName,
                       )).toList()),
          (model?.manager != null || model!.manager!.isEmpty) ? Row(
            children: [
              Flexible(
                child: CustomTextSpanInformation(
                  title: AppLocalizations.text(LangKey.manager),
                  content: model!.manager!.length > 0  ? model!.manager!.first.managerName :
                      AppLocalizations.text(LangKey.data_empty),
                ),
              ),
              (model?.manager != null) ? model!.manager!.length > 1
                  ? Container(
                      margin: EdgeInsets.only(left: 3.0),
                      decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(2.0)),
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        "+ ${model!.manager!.length - 1}",
                        style: AppTextStyles.style14PrimaryRegular,
                      ),
                    )
                  : Container() : Container()
            ],
          ) : Container(),
          CustomTextSpanInformation(
            title: AppLocalizations.text(LangKey.customer),
            content:(model!.customer != null && model!.customer!.length > 0) ? model!.customer!.first.customerName : AppLocalizations.text(LangKey.data_empty),
          ),
          SizedBox(),
          Row(
            children: [
              Expanded(
                child: CustomColumnCenterInformation(
                  title: AppLocalizations.text(LangKey.start_date),
                  content: model!.fromDate != null
                      ? formatTextDateTime(model!.fromDate, true)
                      : AppLocalizations.text(LangKey.data_empty),
                  contentColor: AppColors.darkGreenColor,
                ),
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Expanded(
                child: CustomColumnCenterInformation(
                  title: AppLocalizations.text(LangKey.end_date),
                  content: model!.toDate != null
                      ? formatTextDateTime(model!.toDate, true)
                      : AppLocalizations.text(LangKey.data_empty),
                  contentColor: AppColors.darkRedColor,
                ),
              ),
            ],
          ),
          SizedBox(),
          Row(
            children: [
              Expanded(
                child: CustomColumnCenterInformation(
                  title: AppLocalizations.text(LangKey.condition),
                  content: model!.condition?.conditionName ??
                      AppLocalizations.text(LangKey.data_empty),
                  contentColor: Color(
                      HexColor.getColorFromHex(model!.condition?.conditionColor)),
                ),
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Expanded(
                child: CustomColumnCenterInformation(
                  title: AppLocalizations.text(LangKey.risk_level),
                  content: model!.projectRiskName ?? "",
                  contentColor: AppColors.darkRedColor,
                ),
              ),
            ],
          ),
          SizedBox(),
          CustomProjectProgress(progress: model!.progress ?? 0),
          CustomProjectResource(
              total: model!.resourceTotal ?? 0,
              current: model!.resourceImplement ?? 0),
          Row(
            children: [
              Expanded(
                child: _buildRow(AppLocalizations.text(LangKey.document),
                    model!.document.toString()),
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Expanded(
                child: _buildRow(AppLocalizations.text(LangKey.budget),
                    formatMoney(model!.budget?.toDouble() ?? 0.0),
                    contentColor: AppColors.darkGreenColor),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: _buildRow(AppLocalizations.text(LangKey.member),
                    model!.member.toString()),
              ),
              SizedBox(
                width: AppSizes.minPadding,
              ),
              Expanded(
                child: _buildRow(AppLocalizations.text(LangKey.work),
                    model!.work.toString()),
              ),
            ],
          ),
        ],
      ),
      onTap: onTap,
    );
  }
}

class CustomProjectProgress extends StatelessWidget {
  final int? progress;

  const CustomProjectProgress({Key? key, this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomColumnCenterInformation(
      titleContentRight: '100%',
      isContentRight: true,
      title: AppLocalizations.text(LangKey.work_completion_progress),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.grey500Color,
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            Expanded(
              flex: (progress == 0)
                  ? progress!
                  : (progress! > 9 || progress! < 15)
                      ? progress! + 10
                      : progress!,
              child: Container(
                decoration: BoxDecoration(
                    color: progress! > 79
                        ? AppColors.green300
                        : (progress! > 39
                            ? AppColors.yellow
                            : AppColors.darkRedColor),
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(5.0))),
                alignment: Alignment.center,
                padding: EdgeInsets.all(AppSizes.minPadding / 2),
                child: Text(
                  "$progress%",
                  style: AppTextStyles.style16WhiteBold,
                ),
              ),
            ),
            Expanded(
              flex: 100 - progress!,
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}

class CustomProjectResource extends StatelessWidget {

   final int? total;
   final int? current;

   CustomProjectResource({this.total, this.current});

  @override
  Widget build(BuildContext context) {
    // int _total = total ?? 1;
    // int _current = current ?? 1;
    // if (_current > _total) {
    //   _current = _total;
    // }
    // return CustomColumnCenterInformation(
    //   title: AppLocalizations.text(LangKey.resource),
    //   isContentRight: true,
    //   titleContentRight: "số ngày",
    //   isBold: true,
    //   child: Container(
    //     decoration: BoxDecoration(
    //         color: AppColors.darkRedColor,
    //         borderRadius: BorderRadius.circular(5.0)),
    //     child: Row(
    //       children: [
    //         Expanded(
    //           flex: _current,
    //           child: Container(
    //             decoration: BoxDecoration(
    //                 color: AppColors.primaryColor,
    //                 borderRadius:
    //                     BorderRadius.horizontal(left: Radius.circular(5.0))),
    //             alignment: Alignment.centerRight,
    //             padding: EdgeInsets.all(AppSizes.minPadding),
    //             child: Text(
    //               (current ?? 0).toString(),
    //               style: AppTextStyles.style14WhiteNormal,
    //             ),
    //           ),
    //         ),
    //         Expanded(
    //           flex: _total - _current,
    //           child: Container(
    //             alignment: Alignment.centerRight,
    //             padding: EdgeInsets.all(AppSizes.minPadding),
    //             child: Text(
    //               (total ?? 0).toString(),
    //               style: AppTextStyles.style14WhiteNormal,
    //             ),
    //           ),
    //         )
    //       ],
    //     ),
    //   ),
    // );
    int _current = current!;
    if (_current > total!) {
      _current = total!;
    }
    return CustomColumnCenterInformation(
      titleContentRight: "$total ngày",
      isContentRight: true,
      title: AppLocalizations.text(LangKey.resource),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.grey500Color,
            borderRadius: BorderRadius.circular(5.0)),
        child: Row(
          children: [
            Expanded(
              flex: _current,
              child: Container(
                decoration: BoxDecoration(
                    color: AppColors.blueColor,
                    borderRadius:
                        BorderRadius.horizontal(left: Radius.circular(5.0))),
                alignment: Alignment.center,
                padding: EdgeInsets.all(AppSizes.minPadding / 2),
                child: Text(
                  "$_current ngày",
                  style: AppTextStyles.style16WhiteBold,
                ),
              ),
            ),
            Expanded(
              flex: (total ?? 0) - _current,
              child: SizedBox(),
            )
          ],
        ),
      ),
    );
  }
}
