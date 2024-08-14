part of widget;

class CustomSurveyConduct extends StatelessWidget {

  final int index;
  final SurveyProcessModel? model;
  final Function(SurveyProcessListChoiceModel)? onSingleChoice;
  final Function(SurveyProcessListChoiceModel)? onMultiChoice;
  final bool isHistory;

  const CustomSurveyConduct(
      this.index,
      this.model,
      {
        Key? key,
        this.onSingleChoice,
        this.onMultiChoice,
        this.isHistory = false
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(model == null){
      return Container();
    }

    Widget? child;

    if(model!.surveyQuestionType == surveyQuestionTypePageText){
      child = CustomSurveyConductPageText(model, index, isHistory);
    }
    else if(model!.surveyQuestionType == surveyQuestionTypeSingleChoice){
      child = CustomSurveyConductSingleChoice(model, index, onSingleChoice, isHistory);
    }
    else if(model!.surveyQuestionType == surveyQuestionTypeMultiChoice){
      child = CustomSurveyConductMultiChoice(model, index, onMultiChoice, isHistory);
    }
    else if(model!.surveyQuestionType == surveyQuestionTypeText){
      child = CustomSurveyConductInput(
        model,
        index,
        isHistory,
      );
    }
    else if(model!.surveyQuestionType == surveyQuestionTypePagePicture){
      child = CustomSurveyConductPagePicture(model, index);
    }

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        if(index == 0)
          Container(
            padding: EdgeInsets.all(AppSizes.maxPadding),
            margin: EdgeInsets.only(
              top: AppSizes.maxPadding,
              right: AppSizes.maxPadding,
              left: AppSizes.maxPadding,
            ),
            color: AppColors.green,
            child: RichText(
              text: TextSpan(
                text: AppLocalizations.text(LangKey.survey_conduct_note_start),
                style: AppTextStyles.style13BlackNormal,
                children: [
                  TextSpan(
                    text: " * ",
                    style: AppTextStyles.style13BlackNormal.copyWith(
                      color: AppColors.red500
                    ),
                  ),
                  TextSpan(
                    text: AppLocalizations.text(LangKey.survey_conduct_note_end),
                    style: AppTextStyles.style13BlackNormal,
                  ),
                ]
              )
            ),
          ),
        child ?? Container()
      ],
    );
  }
}

class CustomSurveyConductContainer extends StatelessWidget {

  final int index;
  final String? title;
  final bool isRequired;
  final Widget child;
  final double? padding;
  final int? point;
  final String? result;
  final bool isHistory;

  const CustomSurveyConductContainer(
      this.index,
      this.title,
      this.isHistory,
      this.child,
      {
        Key? key,
        this.isRequired = true,
        this.padding,
        this.point,
        this.result,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(AppSizes.maxPadding),
          child: RichText(
            text: TextSpan(
                text: "${AppLocalizations.text(LangKey.question)} ${index + 1}: ${title ?? ""}",
                style: AppTextStyles.style16BlackBold.copyWith(
                  color: isHistory
                      ? result == surveyResultAnswerSuccess
                      ? AppColors.surveySuccess
                      : AppColors.surveyWrong
                      : AppColors.blackColor
                ),
                children: [
                  if(isRequired)
                    TextSpan(
                      text: " *",
                      style: AppTextStyles.style16BlackBold.copyWith(
                          color: AppColors.red500
                      ),
                    ),
                  if(isHistory && (point ?? 0) > 0)
                    TextSpan(
                      text: " ($point)",
                      style: AppTextStyles.style16BlackBold.copyWith(
                          color: AppColors.red500
                      ),
                    ),
                ]
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: padding ?? AppSizes.maxPadding),
          child: child,
        ),
        Container(height: AppSizes.maxPadding,),
      ],
    );
  }
}

class CustomSurveyConductCorrect extends StatelessWidget {

  final Widget child;

  const CustomSurveyConductCorrect(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: AppSizes.maxPadding,),
        Text(
          AppLocalizations.text(LangKey.correct_answer)!,
          style: AppTextStyles.style16BlackBold,
        ),
        SizedBox(height: AppSizes.minPadding,),
        child
      ],
    );
  }
}


class CustomSurveyConductSingleChoice extends StatelessWidget {

  final SurveyProcessModel? model;
  final int index;
  final Function(SurveyProcessListChoiceModel)? onSingleChoice;
  final bool isHistory;

  const CustomSurveyConductSingleChoice(this.model, this.index, this.onSingleChoice, this.isHistory, {Key? key}) : super(key: key);

  Widget _buildBody(SurveyProcessListChoiceModel e, {bool isCorrect = false}){
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
                color: e.isSelected!
                    ? isHistory
                    ? model!.resultAnswer == surveyResultAnswerSuccess
                    ? AppColors.surveySuccess
                    : AppColors.surveyWrong
                    : AppColors.primaryColor
                    : AppColors.gray50
            ),
            color: e.isSelected!
                ? isHistory
                ? model!.resultAnswer == surveyResultAnswerSuccess
                ? AppColors.surveySuccess.withOpacity(0.2)
                : AppColors.surveyWrong.withOpacity(0.2)
                : AppColors.primaryColor.withOpacity(0.2)
                : Colors.transparent
        ),
        padding: EdgeInsets.all(AppSizes.minPadding),
        child: Row(
          children: [
            CustomSurveyRadioButton(
              e.isSelected!,
                  (event) {
                if(onSingleChoice != null){
                  onSingleChoice!(e);
                }
              },
              isHistory,
            ),
            Expanded(child: Text(
              e.surveyQuestionChoiceTitle ?? "",
              style: AppTextStyles.style14BlackNormal.copyWith(
                  fontWeight: e.isSelected!? FontWeight.bold: FontWeight.normal
              ),
            ),),
            if(e.isSelected! && isHistory && !isCorrect)
              Padding(
                padding: EdgeInsets.only(left: AppSizes.minPadding),
                child: model!.resultAnswer == surveyResultAnswerSuccess
                    ? Icon(
                  Icons.check,
                  color: AppColors.surveySuccess,
                ) : Icon(
                  Icons.close,
                  color: AppColors.surveyWrong,
                ),
              ),
          ],
        ),
      ),
      onTap: (){
        if(onSingleChoice != null && !isHistory){
          onSingleChoice!(e);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomSurveyConductContainer(
      index,
      model!.surveyQuestionDescription,
      isHistory,
      Column(
        children: [
          CustomListView(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            children: (model!.listChoice ?? <SurveyProcessListChoiceModel>[]).map(_buildBody).toList(),
          ),
          if(isHistory && model!.resultAnswer == surveyResultAnswerWrong)
            CustomSurveyConductCorrect(
                CustomListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  children: (model!.listAnswerSuccess ?? <SurveyProcessListChoiceModel>[]).map((e) => _buildBody(e, isCorrect: true)).toList(),
                )
            )
        ],
      ),
      isRequired: model!.isRequired == 1,
      point: model!.valuePoint,
      result: model!.resultAnswer,
    );
  }
}

class CustomSurveyConductMultiChoice extends StatelessWidget {

  final SurveyProcessModel? model;
  final int index;
  final Function(SurveyProcessListChoiceModel)? onMultiChoice;
  final bool isHistory;

  const CustomSurveyConductMultiChoice(this.model, this.index, this.onMultiChoice, this.isHistory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomSurveyConductContainer(
      index,
      model!.surveyQuestionDescription,
      isHistory,
      CustomListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: NeverScrollableScrollPhysics(),
        children: (model!.listChoice ?? <SurveyProcessListChoiceModel>[]).map((e) => InkWell(
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                    color: e.isSelected!? AppColors.primaryColor: AppColors.gray50
                ),
                color: e.isSelected!? AppColors.primaryColor.withOpacity(0.2): Colors.transparent
            ),
            padding: EdgeInsets.all(AppSizes.minPadding),
            child: Row(
              children: [
                CustomSurveyCheckbox(e.isSelected ?? false, (event) {
                  if(onMultiChoice != null){
                    onMultiChoice!(e);
                  }
                }, isHistory),
                Expanded(child: Text(
                  e.surveyQuestionChoiceTitle ?? "",
                  style: AppTextStyles.style14BlackNormal.copyWith(
                      fontWeight: e.isSelected!? FontWeight.bold: FontWeight.normal
                  ),
                ),)
              ],
            ),
          ),
          onTap: (){
            if(onMultiChoice != null && !isHistory){
              onMultiChoice!(e);
            }
          },
        )).toList(),
      ),
      isRequired: model!.isRequired == 1,
      point: model!.valuePoint,
      result: model!.resultAnswer,
    );
  }
}

class CustomSurveyConductInput extends StatelessWidget {

  final SurveyProcessModel? model;
  final int index;
  final bool isHistory;

  const CustomSurveyConductInput(this.model, this.index, this.isHistory, {Key? key}) : super(key: key);

  _showDate(BuildContext context){
    DateTime? currentTime;
    if(model!.controller!.text.isNotEmpty){
      currentTime = parseDate(model!.controller!.text, parse: AppFormat.formatDate);
    }
    DateTime now = DateTime.now();
    DatePicker.showDatePicker(context,
        minTime: minDateTime,
        maxTime: now.add(Duration(days: 365)),
        currentTime: currentTime??now,
        locale: Globals.localeType,
        onConfirm: (event) {
          model!.controller!.text = formatDate(event);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    if(model!.focusNode == null){
      model!.focusNode = FocusNode();
      String? text;
      if(model!.surveyQuestionConfig?.validType == surveyValidateTypeDateFormat){
        try{
          text = parseAndFormatDate(
              model!.answerValue,
              parse: AppFormat.formatDateCreate,
              format: AppFormat.formatDate
          );
        }
        catch(_){}
      }
      model!.controller = TextEditingController(
        text: text ?? (model!.answerValue ?? "")
      );
    }

    String? hintText;
    TextInputType? keyboardType;
    List<TextInputFormatter>? inputFormatters;
    bool? readOnly;
    GestureTapCallback? onTap;
    String? suffixIcon;
    int? maxLines;

    if((model!.surveyQuestionConfig?.validType ?? "").isNotEmpty){
      if(model!.surveyQuestionConfig!.validType == surveyValidateTypeNumeric){
        keyboardType = TextInputType.number;
        inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
        ];
      }
      else if(model!.surveyQuestionConfig!.validType == surveyValidateTypeDateFormat){
        readOnly = true;
        suffixIcon = Assets.iconCalendar;
        hintText = AppLocalizations.text(LangKey.choose_a_date);
        onTap = () => _showDate(context);
      }
      else if(model!.surveyQuestionConfig!.validType == surveyValidateTypePhone){
        keyboardType = TextInputType.phone;
        inputFormatters = [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(maxLengthPhone)
        ];
      }
      else{
        maxLines = 5;
      }
    }

    return CustomSurveyConductContainer(
        index,
        model!.surveyQuestionDescription,
        isHistory,
        CustomTextField(
          focusNode: model!.focusNode,
          controller: model!.controller,
          maxLines: maxLines,
          borderColor: AppColors.borderColor,
          hintText: isHistory ? null : (hintText ?? AppLocalizations.text(LangKey.enter_your_answer_here)),
          readOnly: readOnly ?? isHistory,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          suffixIcon: isHistory ? null : suffixIcon,
          onTap: isHistory ? null : onTap,
        ),
      isRequired: model!.isRequired == 1,
      point: model!.valuePoint,
      result: model!.resultAnswer,
    );
  }
}

class CustomSurveyConductDatePicker extends StatelessWidget {

  final FocusNode focusNode;
  final TextEditingController controller;
  final Function(DateTime) onChanged;

  const CustomSurveyConductDatePicker(this.focusNode, this.controller, this.onChanged, {Key? key}) : super(key: key);

  _showFromDate(BuildContext context){
    DateTime? currentTime;
    if(controller.text.isNotEmpty){
      currentTime = parseDate(controller.text, parse: AppFormat.formatDate);
    }
    DateTime now = DateTime.now();
    DatePicker.showDatePicker(context,
        minTime: minDateTime,
        maxTime: now.add(Duration(days: 365)),
        currentTime: currentTime??now,
        locale: Globals.localeType,
        onConfirm: (event) {
          onChanged(event);
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomSurveyConductContainer(
        0,
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry?",
        true,
        CustomTextField(
          focusNode: focusNode,
          controller: controller,
          backgroundColor: Colors.transparent,
          borderColor: AppColors.borderColor,
          hintText: AppLocalizations.text(LangKey.choose_a_date),
          readOnly: true,
          suffixIcon: Assets.iconCalendar,
          onTap: () => _showFromDate(context),
        )
    );
  }
}

final double _height = 32.0 + AppSizes.maxPadding;

Widget _buildTitle(String title){
  return Container(
    height: _height,
    color: AppColors.surveyProgress,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: AppSizes.minPadding),
    child: AutoSizeText(
      title,
      style: AppTextStyles.style13BlackNormal,
      maxLines: 2,
      minFontSize: 1.0,
    ),
  );
}

Widget _buildCell(Widget child, {bool isError = false}){
  return Container(
    height: _height,
    decoration: BoxDecoration(
      border: isError ? Border.all(color: AppColors.red500): null,
      color: isError ? AppColors.red500: Colors.transparent
    ),
    alignment: Alignment.center,
    child: child,
  );
}

Widget _buildLeft(List<Widget> children){
  return CustomListView(
    padding: EdgeInsets.symmetric(horizontal: AppSizes.maxPadding),
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    separator: CustomLine(size: 1.0,),
    children: [
      _buildTitle(""),
      ...children,
    ],
  );
}

Widget _buildRight(List<Widget> children){
  return CustomListView(
    scrollDirection: Axis.horizontal,
    padding: EdgeInsets.zero,
    separator: CustomLine(size: 1.0, isVertical: false,),
    children: children,
  );
}

Widget _buildMatrix(Widget left, Widget right){
  return Container(
    decoration: BoxDecoration(
      border: Border.all(color: AppColors.borderColor)
    ),
    height: _height * 6,
    child: Row(
      children: [
        Expanded(
          child: left,
        ),
        CustomLine(size: 1.0, isVertical: false),
        Expanded(
          flex: 2,
          child: right,
        )
      ],
    ),
  );
}

class CustomSurveyConductSingleMatrix extends StatelessWidget {

  final bool isHistory;

  CustomSurveyConductSingleMatrix(this.isHistory, {Key? key}) : super(key: key);

  final double _width = AppSizes.maxWidth! / 3 * 2 * 0.4;

  Widget _buildBody(){
    return _buildMatrix(_buildLeft(List.generate(5, (index) => _buildTitle(
      "Grape juice with calcium less sugar",),
    ).toList()), _buildRight(List.generate(5, (index) => SizedBox(
      width: _width,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildTitle("Option answer ${index + 1}"),
          CustomLine(size: 1.0,),
          CustomListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            separator: CustomLine(size: 1.0,),
            children: List.generate(5, (index) => _buildCell(
              CustomSurveyRadioButton(index == 0, (event){}, isHistory),
            )).toList(),
          ),
        ],
      ),
    )).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return CustomSurveyConductContainer(
        0,
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry?",
        true,
        _buildBody(),
        padding: 0.0,
    );
  }
}

class CustomSurveyConductMultiMatrix extends StatelessWidget {

  final bool isHistory;

  CustomSurveyConductMultiMatrix(this.isHistory, {Key? key}) : super(key: key);

  final double _width = AppSizes.maxWidth! / 3 * 2 * 0.4;

  Widget _buildBody(){
    return _buildMatrix(_buildLeft(List.generate(5, (index) => _buildCell(_buildTitle(
        "Grape juice with calcium less sugar",)),
    ).toList()), _buildRight(List.generate(5, (index) => SizedBox(
      width: _width,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildTitle("Option answer ${index + 1}"),
          CustomLine(size: 1.0,),
          CustomListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            separator: CustomLine(size: 1.0,),
            children: List.generate(5, (index) => _buildCell(
              CustomSurveyCheckbox(index == 0, (event) {

              }, isHistory),
            )).toList(),
          ),
        ],
      ),
    )).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return CustomSurveyConductContainer(
      0,
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry?",
      true,
      _buildBody(),
      padding: 0.0,
    );
  }
}

class CustomSurveyConductPhoto extends StatelessWidget {
  const CustomSurveyConductPhoto({Key? key}) : super(key: key);

  static final double _height = AppSizes.maxWidth! * 0.6;

  _capture(BuildContext context){
    CustomImagePicker.showPicker(context, (file) {
      
    });
  }

  Widget _buildTitle(String? title){
    return Text(
      title ?? "",
      style: AppTextStyles.style14BlackBold,
    );
  }

  Widget _buildImage(){
    return ClipRRect(
      borderRadius: BorderRadius.circular(4.0),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: _height,
          ),
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.0),
                color: AppColors.blueColor,
              ),
              padding: EdgeInsets.all(AppSizes.minPadding),
              child: Row(
                children: [
                  Icon(
                    Icons.check,
                    color: AppColors.white,
                    size: 10.0,
                  ),
                  Container(width: AppSizes.minPadding,),
                  Text(
                    "Tọa độ",
                    style: AppTextStyles.style12WhiteNormal,
                  )
                ],
              ),
            ),
          ),
          Positioned(
            right: AppSizes.maxPadding,
            top: AppSizes.maxPadding,
            child: InkWell(
              child: Container(
                width: AppSizes.sizeOnTap,
                height: AppSizes.sizeOnTap,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.black.withOpacity(0.6),
                ),
                alignment: Alignment.center,
                child: CustomImageIcon(
                  icon: Assets.iconDelete,
                  color: AppColors.white,
                ),
              ),
              onTap: null,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCapture(BuildContext context){
    return InkWell(
      child: DottedBorder(
        radius: Radius.circular(4.0),
        color: AppColors.black,
        child: SizedBox(
          width: double.infinity,
          height: _height,
          child: Column(
            children: [
              Icon(
                Icons.add,
                color: AppColors.black,
                size: AppSizes.sizeOnTap,
              ),
              Container(height: AppSizes.minPadding,),
              Text(
                AppLocalizations.text(LangKey.image)!,
                style: AppTextStyles.style13BlackNormal,
              )
            ],
          ),
        ),
      ),
      onTap: () => _capture(context),
    );
  }

  Widget _buildContent(BuildContext context, int index){
    return CustomListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _buildTitle("${AppLocalizations.text(LangKey.image)} ${index + 1}/2"),
        CustomNetworkImage(
          radius: 4.0,
        ),
        _buildTitle(AppLocalizations.text(LangKey.actual_photo)),
        index == 0?_buildImage():_buildCapture(context),
      ],
    );
  }

  Widget _buildBody(BuildContext context){
    return CustomListView(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      separatorPadding: AppSizes.maxPadding,
      children: List.generate(2, (index) => _buildContent(context, index)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomSurveyConductContainer(
      0,
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry?",
      true,
      _buildBody(context),
    );
  }
}

class CustomSurveyConductPagePicture extends StatelessWidget {

  final int index;
  final SurveyProcessModel? model;

  const CustomSurveyConductPagePicture(this.model, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.surveyProgress,
          width: double.infinity,
          padding: EdgeInsets.all(AppSizes.maxPadding),
          child: Text(
            model!.surveyQuestionDescription ?? "",
            style: AppTextStyles.style13HintNormal,
          ),
        ),
        CustomListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          children: (model!.surveyQuestionConfig?.image ?? <String>[]).map((e) => CustomNetworkImage(url: e,),).toList(),
        )
      ],
    );
  }
}

class CustomSurveyConductPageText extends StatelessWidget {

  final SurveyProcessModel? model;
  final int index;
  final bool isHistory;

  const CustomSurveyConductPageText(this.model, this.index, this.isHistory, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.surveyProgress,
          padding: EdgeInsets.all(AppSizes.maxPadding),
          margin: EdgeInsets.only(
            top: AppSizes.maxPadding,
            right: AppSizes.maxPadding,
            left: AppSizes.maxPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.text(LangKey.read_the_follow_description_to_answer_questions)!,
                style: AppTextStyles.style13HintNormal,
              ),
              Container(height: AppSizes.minPadding,),
              Text(
                model!.surveyQuestionDescription ?? "",
                style: AppTextStyles.style16BlackNormal,
              )
            ],
          ),
        ),
        // CustomSurveyConductSingleChoice(),
        // CustomSurveyConductMultiChoice(),
      ],
    );
  }
}

class CustomSurveyConductInputMatrix extends StatelessWidget {
  CustomSurveyConductInputMatrix({Key? key}) : super(key: key);

  final double _width = AppSizes.maxWidth! / 3 * 2 * 0.66;

  Widget _buildBody(){
    return _buildMatrix(_buildLeft(List.generate(5, (index) => _buildCell(_buildTitle(
      "Grape juice with calcium less sugar",)),
    ).toList()), _buildRight(List.generate(5, (index) => SizedBox(
      width: _width,
      child: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _buildTitle("Option answer ${index + 1}"),
          CustomLine(size: 1.0,),
          CustomListView(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            separator: CustomLine(size: 1.0,),
            children: List.generate(5, (index) => _buildCell(
              CustomTextField(
                backgroundColor: Colors.transparent,
                textAlign: TextAlign.center,
              ),
            )).toList(),
          ),
        ],
      ),
    )).toList()));
  }

  @override
  Widget build(BuildContext context) {
    return CustomSurveyConductContainer(
      0,
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry?",
      true,
      _buildBody(),
      padding: 0.0,
    );
  }
}
