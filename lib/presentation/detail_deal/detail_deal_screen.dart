
import 'package:draggable_expandable_fab/draggable_expandable_fab.dart';
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/connection/deal_connection.dart';
import 'package:epoint_deal_plugin/connection/http_connection.dart';
import 'package:epoint_deal_plugin/model/request/work_create_comment_request_model.dart';
import 'package:epoint_deal_plugin/model/request/work_list_comment_request_model.dart';
import 'package:epoint_deal_plugin/model/response/description_model_response.dart';
import 'package:epoint_deal_plugin/model/response/detail_deal_model_response.dart';
import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/work_list_comment_model_response.dart';
import 'package:epoint_deal_plugin/presentation/detail_deal/bloc/comment_bloc.dart';
import 'package:epoint_deal_plugin/presentation/edit_deal/edit_deal_screen.dart';
import 'package:epoint_deal_plugin/utils/custom_image_picker.dart';
import 'package:epoint_deal_plugin/widget/container_data_builder.dart';
import 'package:epoint_deal_plugin/widget/custom_avatar_with_url.dart';
import 'package:epoint_deal_plugin/widget/custom_button.dart';
import 'package:epoint_deal_plugin/widget/custom_empty.dart';
import 'package:epoint_deal_plugin/widget/custom_file_view.dart';
import 'package:epoint_deal_plugin/widget/custom_html.dart';
import 'package:epoint_deal_plugin/widget/custom_image_icon.dart';
import 'package:epoint_deal_plugin/widget/custom_info_item.dart';
import 'package:epoint_deal_plugin/widget/custom_listview.dart';
import 'package:epoint_deal_plugin/widget/custom_shimer.dart';
import 'package:epoint_deal_plugin/widget/custom_skeleton.dart';
import 'package:epoint_deal_plugin/widget/custom_textfield_lead.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailDealScreen extends StatefulWidget {
  String deal_code;
  int indexTab;
  bool customerCare;
  int id;
  Function(int) onCallback;
  DetailDealScreen({Key key, this.deal_code, this.indexTab, this.customerCare,this.id,this.onCallback})
      : super(key: key);

  @override
  _DetailDealScreenState createState() => _DetailDealScreenState();
}

class _DetailDealScreenState extends State<DetailDealScreen> {
  final ScrollController _controller = ScrollController();
  List<WorkListStaffModel> models = [];
  DetailDealData detail;
  bool allowPop = false;
  CommentBloc _bloc;
   FocusNode _focusComment = FocusNode();
  TextEditingController _controllerComment = TextEditingController();
  String _file;
  WorkListCommentModel _callbackModel;

  final double _fileSize = AppSizes.maxWidth * 0.2;
  final double _imageRadius = 20.0;

  int index = 0;

  List<DetailPotentialTabModel> tabDeal = [
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.generalInfomation),
        typeID: 0,
        selected: true),
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.customerCare),
        typeID: 1,
        selected: false),
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.discuss),
        typeID: 2,
        selected: false),
    DetailPotentialTabModel(
        typeName: AppLocalizations.text(LangKey.order_history),
        typeID: 3,
        selected: false)
  ];

  final formatter = NumberFormat.currency(
    locale: 'vi_VN',
    decimalDigits: 0,
    symbol: '',
  );

  @override
  void initState() {
    super.initState();
    _bloc = CommentBloc(context);
    index = widget.indexTab;
    for (int i = 0; i < tabDeal.length; i++) {
      if (index == tabDeal[i].typeID) {
        tabDeal[i].selected = true;
      } else {
        tabDeal[i].selected = false;
      }
    }
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getData();
    });
  }

  void getData() async {
    var dataDetail =
        await DealConnection.getdetailDeal(context, widget.deal_code);
    if (dataDetail != null) {
      if (dataDetail.errorCode == 0) {
        detail = dataDetail.data;
        setState(() {});
      } else {
        await DealConnection.showMyDialog(context, dataDetail.errorDescription);
        Navigator.of(context).pop();
      }
    }

     _bloc.workListComment(WorkListCommentRequestModel(
      manageWorkId: widget.id
    ));
  }

      openFile(BuildContext context, String name, String path){
    Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => CustomFileView(path, name)));
  // CustomNavigator.push(context, CustomFileView(path, name));
}

_send(){
    if(_controllerComment.text.isEmpty && _file == null){
      return;
    }
    _bloc.workCreatedComment(WorkCreateCommentRequestModel(
      manageWorkId: widget.id,
      manageParentCommentId: (_callbackModel?.manageParentCommentId) ?? (_callbackModel?.manageCommentId),
      message: _controllerComment.text,
      path: _file
    ), _controllerComment, widget.onCallback);
  }

    _showOption(){
    CustomImagePicker.showPicker(context, (file) {
      _bloc.workUploadFile(MultipartFileModel(
          name: "link",
          file: file
      ));
    });
  }

  @override
  void dispose() {
    _controller.removeListener(() {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (allowPop) {
          Navigator.of(context).pop(allowPop);
        } else {
          Navigator.of(context).pop();
        }
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          backgroundColor: AppColors.primaryColor,
          title: Text(
            AppLocalizations.text(LangKey.detail_deal),
            style: const TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          // leadingWidth: 20.0,
        ),
        body: Container(
            decoration: const BoxDecoration(color: AppColors.white),
            child: buildBody()),
        floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
        floatingActionButton: ExpandableDraggableFab(
          initialDraggableOffset:
              Offset(12, MediaQuery.of(context).size.height * 11 / 14),
          initialOpen: false,
          curveAnimation: Curves.easeOutSine,
          childrenBoxDecoration: BoxDecoration(
              color: Colors.black.withOpacity(0.45),
              borderRadius: BorderRadius.circular(10.0)),
          childrenCount: 3,
          distance: 10,
          childrenType: ChildrenType.columnChildren,
          childrenAlignment: Alignment.centerRight,
          childrenInnerMargin: EdgeInsets.all(20.0),
          openWidget: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.3),
                )
              ], shape: BoxShape.circle, color: AppColors.primaryColor),
              width: 60,
              height: 60,
              child: Image.asset(
                Assets.iconFABMenu,
                scale: 2.5,
              )),
          closeWidget: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                  offset: Offset(0, 1),
                  blurRadius: 2,
                  color: Colors.black.withOpacity(0.3),
                )
              ], shape: BoxShape.circle, color: Color(0xFF5F5F5F)),
              width: 60,
              height: 60,
              child: Icon(
                Icons.clear,
                size: 35,
                color: Colors.white,
              )),
          children: [
            Column(
              children: [
                FloatingActionButton(
                    backgroundColor: Color(0xFFCD6000),
                    heroTag: "btn2",
                    onPressed: () async {
                      if (Global.createJob != null) {
                        await Global.createJob();
                      }

                      print("iconTask");
                    },
                    child: Image.asset(
                      Assets.iconTask,
                      scale: 2.5,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Text(AppLocalizations.text(LangKey.createJobs),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400))
              ],
            ),
            Column(
              children: [
                FloatingActionButton(
                    backgroundColor: Color(0xFFDD2C00),
                    heroTag: "btn3",
                    onPressed: () async {
                      DealConnection.showMyDialogWithFunction(context,
                          AppLocalizations.text(LangKey.warningDeleteDeal),
                          ontap: () async {
                        DescriptionModelResponse result =
                            await DealConnection.deleteDeal(
                                context, detail.dealCode);

                        Navigator.of(context).pop();

                        if (result != null) {
                          if (result.errorCode == 0) {
                            print(result.errorDescription);

                            await DealConnection.showMyDialog(
                                context, result.errorDescription);
                            Navigator.of(context).pop(true);
                          } else {
                            DealConnection.showMyDialog(
                                context, result.errorDescription);
                          }
                        }
                      });

                      print("iconDelete");
                    },
                    child: Image.asset(
                      Assets.iconDelete,
                      scale: 2.5,
                    )),
                SizedBox(
                  height: 5.0,
                ),
                Text(AppLocalizations.text(LangKey.delete),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400))
              ],
            ),
            Column(
              children: [
                FloatingActionButton(
                  heroTag: "btn4",
                  onPressed: () async {
                    // if (detail.journeyCode != "PJD_DEAL_END") {
                      bool result = await Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) =>
                                  EditDealScreen(detail: detail)));

                      if (result != null) {
                        if (result) {
                          allowPop = true;
                          getData();
                          ;
                        }
                      }
                    // }

                    print("iconEdit");
                  },
                  backgroundColor: Color(0xFF00BE85),
                  child: Image.asset(
                    Assets.iconEdit,
                    scale: 2.5,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(AppLocalizations.text(LangKey.edit),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildBody() {
    return (detail == null)
        ? Container()
        : Column(
            children: [
              Expanded(
                  child: ListView(
                padding: EdgeInsets.zero,
                physics: const AlwaysScrollableScrollPhysics(),
                controller: _controller,
                children: buildInfomation(),
              )),

              (index == 2) ?  Positioned(
                  bottom: 0,
                  // left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white
                    ),
                    width: AppSizes.maxWidth,
                    child: _buildChatBox())) : Container(),

              Container(
                height: 20.0,
              )
            ],
          );
  }

    Widget buildListOption() {
    return Row(
      children: [
        option(AppLocalizations.text(LangKey.generalInfomation),
            tabDeal[0].selected, 100, () {
          index = 0;
          selectedTab(0);
        }),
        option(AppLocalizations.text(LangKey.customerCare), tabDeal[1].selected,
            120, () {
          index = 1;
          selectedTab(1);
        }),
        option(AppLocalizations.text(LangKey.discuss), tabDeal[2].selected, 80,
            () {
          index = 2;
          selectedTab(2);
        }),
        option(AppLocalizations.text(LangKey.order_history),
            tabDeal[3].selected, 120, () {
          index = 3;
          selectedTab(3);
        })
      ],
    );
  }

   selectedTab(int index) async {
    List<DetailPotentialTabModel> models = tabDeal;
    for (int i = 0; i < models.length; i++) {
      models[i].selected = false;
    }
    models[index].selected = true;

    setState(() {});
  }

    Widget option(String title, bool show, double width, Function ontap) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15.0 / 1.5),
          height: 40,
          child: InkWell(
            onTap: ontap,
            child: Center(
              child: Text(
                title,
                style: show
                    ? TextStyle(
                        fontSize: AppTextSizes.size16,
                        color: AppColors.blueColor,
                        fontWeight: FontWeight.bold)
                    : TextStyle(
                        fontSize: AppTextSizes.size16,
                        color: AppColors.colorTabUnselected,
                        fontWeight: FontWeight.bold),
                maxLines: 1,
              ),
            ),
          ),
        ),
        show
            ? Container(
                decoration: const BoxDecoration(color: AppColors.blueColor),
                width: width,
                height: 3.0,
              )
            : Container()
      ],
    );
  }


  List<Widget> buildInfomation() {
    return [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 70), child: _dealInformationV2()),

          Column(
      children: [
        SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          child: buildListOption(),
        ),
        Container(
          height: 20,
        ),
        (index == 0)
            ? detailInformation()
            : (index == 1)
                ? customerCare()
                : (index == 2)
                    ? Container(
                          width: AppSizes.maxWidth,
                          height: AppSizes.maxHeight,
                          child: _buildComments())
                    : orderHistory()
      ],
    ),
        ],
      )
    ];
  }

    Widget _buildEmpty(){
    return CustomEmpty(
      title: AppLocalizations.text(LangKey.comment_empty),
    );
  }


  Widget _buildContainer(List<WorkListCommentModel> models){
    // print(MediaQuery.of(context).padding.bottom);
    return Container(
      padding: EdgeInsets.only(bottom: 400 + MediaQuery.of(context).padding.bottom ),
      child: CustomListView(
        // physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(
            vertical: AppSizes.minPadding,
            horizontal: AppSizes.maxPadding
        ),
        children: models == null
            ? List.generate(4, (index) => _buildComment(null))
            : models.map((e) => _buildComment(e)).toList(),
      ),
    );
  }

    Widget _buildComment(WorkListCommentModel model){

    if(model == null){
      return CustomShimmer(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSkeleton(
              width: AppSizes.sizeOnTap,
              height: AppSizes.sizeOnTap,
              radius: AppSizes.sizeOnTap,
            ),
            Container(width: AppSizes.minPadding,),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 5.0,),
                CustomSkeleton(width: AppSizes.maxWidth / 3,),
                Container(
                  padding:  EdgeInsets.only(top: 5.0),
                  child: CustomSkeleton(),
                ),
              ],
            ))
          ],
        ),
      );
    }

    double avatarSize = model.isSubComment?AppSizes.sizeOnTap / 2:AppSizes.sizeOnTap;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAvatar(
          size: avatarSize,
          url: model.staffAvatar,
          name: model.staffName,
        ),
        Container(width: AppSizes.minPadding,),
        Expanded(child: CustomListView(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.zero,
          separatorPadding: 5.0,
          children: [
            Container(),
            Text(
              model.staffName ?? "",
              style: AppTextStyles.style12BlackBold,
            ),
            if((model.message ?? "").isNotEmpty)
              CustomHtml(
                model.message,
                physics: NeverScrollableScrollPhysics(),
              ),
            if((model.path ?? "").isNotEmpty)
              Container(
                constraints: BoxConstraints(
                  maxHeight: AppSizes.maxHeight * 0.2
                ),
                child: Row(
                  children: [
                    Flexible(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: AppColors.borderColor),
                              borderRadius: BorderRadius.circular(_imageRadius)
                          ),
                          child: InkWell(
                            child: CustomNetworkImage(
                                url: model.path,
                                fit: BoxFit.contain,
                                radius: _imageRadius
                            ),
                            onTap: () => openFile(context, AppLocalizations.text(LangKey.image), model.path),
                          ),
                        )
                    )
                  ],
                ),
              ),
            Row(
              children: [
                Text(
                  model.timeText ?? "",
                  style: AppTextStyles.style12grey500Normal,
                ),
                Container(width: AppSizes.maxPadding,),
                InkWell(
                  child: Text(
                    AppLocalizations.text(LangKey.callback),
                    style: AppTextStyles.style12grey500Bold,
                  ),
                  onTap: () => _bloc.setCallback(model),
                )
              ],
            ),
            if((model.listObject?.length ?? 0) != 0)
              CustomListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                separatorPadding: 5.0,
                children: model.listObject.map((e) => _buildComment(e)).toList(),
              )
          ],
        ))
      ],
    );
  }

   Widget _buildChatBox(){
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey)
        )
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.maxPadding,
        vertical: 5.0
      ),
      child: Column(
        children: [
          StreamBuilder(
            stream: _bloc.outputCallback,
            initialData: null,
            builder: (_, snapshot){
              _callbackModel = snapshot.data;
              if(_callbackModel == null){
                return Container();
              }
              return Container(
                padding: EdgeInsets.only(bottom: AppSizes.minPadding),
                child: InkWell(
                  child: Row(
                    children: [
                      Flexible(child: RichText(
                        text: TextSpan(
                            text: AppLocalizations.text(LangKey.answering) + " ",
                            style: AppTextStyles.style12grey200Normal,
                            children: [
                              TextSpan(
                                  text: _callbackModel.staffName ?? "",
                                  style: AppTextStyles.style12BlackBold
                              )
                            ]
                        ),
                      )),
                      Container(width: AppSizes.minPadding,),
                      Icon(
                        Icons.close,
                        color: AppColors.grey200Color,
                        size: 12.0,
                      )
                    ],
                  ),
                  onTap: () => _bloc.setCallback(null),
                ),
              );
            }
          ),
          StreamBuilder(
            stream: _bloc.outputFile,
            initialData: null,
            builder: (_, snapshot){
              _file = snapshot.data;

              if(_file == null){
                return Container();
              }

              return Container(
                padding: EdgeInsets.only(bottom: AppSizes.minPadding),
                child: Row(
                  children: [
                    InkWell(
                      child: CustomNetworkImage(
                        radius: 10.0,
                        width: _fileSize,
                        url: _file,
                      ),
                      onTap: () => openFile(context, AppLocalizations.text(LangKey.image), _file),
                    ),
                    Container(width: AppSizes.minPadding,),
                    CustomButton(
                      text: AppLocalizations.text(LangKey.delete),
                      backgroundColor: Colors.transparent,
                      borderColor: AppColors.primaryColor,
                      style: AppTextStyles.style14PrimaryBold,
                      isExpand: false,
                      onTap: () => _bloc.setFile(null),
                    )
                  ],
                ),
              );
            }
          ),
          Row(
            children: [
              InkWell(
                child: CustomImageIcon(
                  icon: Assets.iconCamera,
                  color: AppColors.primaryColor,
                  size: 30.0,
                ),
                onTap: _showOption,
              ),
              Container(width: AppSizes.minPadding,),
              Expanded(child: CustomTextField(
                focusNode: _focusComment,
                controller: _controllerComment,
                backgroundColor: Colors.transparent,
                borderColor: AppColors.borderColor,
                hintText: AppLocalizations.text(LangKey.enter_comment),
              )),
              Container(width: AppSizes.minPadding,),
              InkWell(
                child: Icon(
                  Icons.send,
                  color: AppColors.primaryColor,
                  size: 30.0,
                ),
                onTap: _send,
              ),
            ],
          ),
          Container(height: 15.0,)
        ],
      ),
    );
  }
  

    Widget _buildComments(){
    return StreamBuilder(
      stream: _bloc.outputModels,
      initialData: null,
      builder: (_, snapshot){
        List<WorkListCommentModel> models = snapshot.data;
        return ContainerDataBuilder(
          data: models,
          emptyBuilder: _buildEmpty(),
          skeletonBuilder: _buildContainer(null),
          bodyBuilder: () => _buildContainer(models),
          // onRefresh: () => _onRefresh(),
        );
      }
    );
  }


  // thông tin chi tiết
  Widget detailInformation() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Padding(
          //   padding: const EdgeInsets.all(8),
          //   child: Text(
          //     AppLocalizations.text(LangKey.picture),
          //     style: TextStyle(
          //         fontSize: AppTextSizes.size15,
          //         color: const Color(0xFF858080),
          //         fontWeight: FontWeight.normal),
          //   ),
          // ),
          Divider(),

          _infoDetailItem(
            AppLocalizations.text(LangKey.allottedPerson),
            detail?.staffName ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.product),
            detail?.productNameBuy ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.expectedEndingDate),
            detail?.closingDate ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.actualEndDate),
            detail?.closingDueDate ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.reasonForFailure),
            detail?.reasonLoseCode ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.agency),
            detail?.branchName ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.orderSource),
            detail?.orderSourceName ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.probability),
            detail?.probability != ""
                ? NumberFormat.currency(
                      locale: 'en_US',
                      decimalDigits: 1,
                      symbol: '',
                    ).format(num.parse(detail?.probability ?? "0")) +
                    "%"
                : "",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.dealDetail),
            detail?.dealDescription ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.dateCreated),
            detail?.createdAt ?? "N/A",
          ),
          Divider(),
          _infoDetailItem(
            AppLocalizations.text(LangKey.lastModifiedDate),
            detail?.updatedAt ?? "N/A",
          ),
          Divider(),
        ],
      ),
    );
  }

    Widget _infoDetailItem(String title, String content, {TextStyle style}) {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 1.9,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    title,
                    style: AppTextStyles.style15BlackNormal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Text(
            content,
            style: style ?? AppTextStyles.style15BlackNormal,
            // maxLines: 1,
          )),
        ],
      ),
    );
  }



  Widget _dealInformationV2() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          margin: EdgeInsets.all(11.0),
          // padding: EdgeInsets.only(bot),
          child: Container(
            padding: EdgeInsets.only(bottom: 10.0),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Color(0xFFC3C8D3))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    padding: EdgeInsets.only(right: 8.0, top: 8.0),
                    margin: EdgeInsets.only(top: 25.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 24,
                              width: 55,
                              margin: EdgeInsets.only(right: 12.0),
                              decoration: BoxDecoration(
                                  color: Color(0xFF3AEDB6),
                                  borderRadius: BorderRadius.circular(4.0)),
                              child: Center(
                                child: Text("Mới",
                                    style: TextStyle(
                                        color: Color(0xFF11B482),
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal)),
                              ),
                            ),
                            Text("80%",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700))
                          ],
                        ),
                        SizedBox(
                          height: 4.0,
                        ),
                        Text(detail?.dealName ?? "",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 4.0,
                        ),
                        RichText(
                            text: TextSpan(
                                text: "Zalo",
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal),
                                children: [
                              TextSpan(
                                  text: " - " + "Tinh Gia",
                                  style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold))
                            ])),
                        SizedBox(height: 5),
                        Text(detail?.phone ?? "",
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.normal)),
                        SizedBox(height: 5),
                        Text(
                          "DN- CTY TNHH MỘT THÀNH VIÊN",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontSize: 16.0,
                              color: Color(0xFF8E8E8E),
                              fontWeight: FontWeight.normal),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 8.0),
                  margin: EdgeInsets.only(right: 8.0, top: 16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          // width: MediaQuery.of(context).size.width / 2 - 50,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // infoItem(Assets.iconName, item?.staffFullName ?? "", true),
                              // infoItem(Assets.iconInteraction, item?.journeyName ?? "", true),

                              infoItem(Assets.iconDeal, detail?.dealCode),
                              infoItem(
                                  Assets.iconName, detail?.staffName ?? ""),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 3.0, bottom: 8.0),
                                margin: EdgeInsets.only(bottom: 8.0, left: 5.0),
                                child: Row(
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      height: 15.0,
                                      width: 15.0,
                                      child:
                                          Image.asset(Assets.iconInteraction),
                                    ),
                                    Expanded(
                                      child: RichText(
                                          text: TextSpan(
                                              text: "27/08/2022" + " ",
                                              style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.black,
                                                  fontWeight:
                                                      FontWeight.normal),
                                              children: [
                                            TextSpan(
                                                text: "(1 ngày)",
                                                style: TextStyle(
                                                    color:
                                                        AppColors.primaryColor,
                                                    fontSize: 14.0,
                                                    fontWeight:
                                                        FontWeight.normal))
                                          ])),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 3.0, bottom: 6.0),
                                margin: EdgeInsets.only(left: 5.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      margin:
                                          const EdgeInsets.only(right: 10.0),
                                      height: 15.0,
                                      width: 15.0,
                                      child: Image.asset(Assets.iconTag),
                                    ),
                                    Expanded(
                                      child: Text(
                                        "35.000 VND",
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontSize: 14.0,
                                            fontWeight: FontWeight.bold),
                                        // maxLines: 1,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () async {
                              print(detail.phone);
                              await callPhone(detail?.phone ?? "");
                            },
                            child: Container(
                              padding: EdgeInsets.all(20.0 / 2),
                              height: 45,
                              width: 45,
                              decoration: BoxDecoration(
                                color: Color(0xFF06A605),
                                borderRadius: BorderRadius.circular(50),
                                // border:  Border.all(color: AppColors.white,)
                              ),
                              child: Center(
                                  child: Image.asset(
                                Assets.iconCall,
                                color: AppColors.white,
                              )),
                            ),
                          ),
                          SizedBox(height: 15.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _actionItem(
                                  Assets.iconCalendar, Color(0xFF26A7AD),
                                  show: true, number: 30, ontap: () {
                                print("1");
                              }),
                              _actionItem(Assets.iconOutdate, Color(0xFFDD2C00),
                                  show: true, number: 30, ontap: () {
                                print("2");
                              }),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width / 2 - 44.5,
          top: -55,
          child: _buildAvatar(detail?.dealName ?? ""),
        ),
      ],
    );
  }

  Widget infoItem(String icon, String title) {
    return Container(
      padding: const EdgeInsets.only(left: 8, bottom: 8.0),
      margin: EdgeInsets.only(bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            height: 15.0,
            width: 15.0,
            child: Image.asset(icon),
          ),
          Expanded(
            child: Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                  fontWeight: FontWeight.normal),
              // maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

   Widget customerCare() {
    return Container(
      margin: EdgeInsets.only(bottom: 20.0),
      child: Column(
        children: [customerCareItem(), customerCareItem(), customerCareItem()],
      ),
    );
  }


  Widget customerCareItem() {
    return InkWell(
      onTap: () async {},
      child: Container(
        child: Container(
          margin: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          // height: 300,
          decoration: BoxDecoration(
              border: Border.all(
                  color: Colors.grey, width: 1, style: BorderStyle.solid),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Container(
                child: SizedBox(
                  //Cái này là bên trái
                  width: MediaQuery.of(context).size.width / 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        '09:45',
                        style: TextStyle(color: Colors.grey),
                      ),
                      Text(
                        '22,\ntháng 12,\nnăm 2022',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                //Cai này là bên phải
                child: Container(
                  padding: EdgeInsets.only(top: 10, bottom: 10, left: 10.0),
                  decoration: BoxDecoration(
                      border: Border(
                    left: BorderSide(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Cái này là dòng tiêu đề
                      Container(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Row(
                          children: const [
                            Expanded(
                              child: Text.rich(
                                TextSpan(
                                  text:
                                      '[012345678] Tên công việc này dài quá trời dài',
                                  style: TextStyle(
                                    color: Color(0xFF0067AC),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  children: <InlineSpan>[
                                    TextSpan(
                                      text: ' ',
                                    ),
                                    WidgetSpan(
                                        child: Icon(
                                      Icons.check_circle_outline_sharp,
                                      color: Colors.green,
                                      size: 16,
                                    )),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),

                      InkWell(
                        child: Container(
                          height: 30,
                          width: 100,
                          margin: EdgeInsets.only(top: 10.0),
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          decoration: BoxDecoration(boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 2,
                              color: Colors.black.withOpacity(0.3),
                            )
                          ], color: Colors.white),
                          child: Row(
                            children: [
                              Image.asset(
                                Assets.iconCall,
                                scale: 3.0,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Text(
                                AppLocalizations.text(LangKey.call),
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: AppColors.primaryColor,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500),
                                // maxLines: 1,
                              )
                            ],
                          ),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            Row(
                              children: [
                                Text(
                                  "15",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconFiles,
                                  scale: 3.0,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "12",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconComment,
                                  scale: 3.0,
                                )
                              ],
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Row(
                              children: [
                                Text(
                                  "12",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500),
                                  // maxLines: 1,
                                ),
                                SizedBox(
                                  width: 5.0,
                                ),
                                Image.asset(
                                  Assets.iconTimeDetail,
                                  scale: 3.0,
                                )
                              ],
                            )
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            CustomAvatarWithURL(
                              name: "NV.Trixie Miami",
                              size: 50.0,
                            ),
                            Container(
                              width: 10.0,
                            ),
                            Expanded(
                                child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "NV.Trixie Miami",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppColors.primaryColor,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )),
                          ],
                        ),
                      ),

                      Container(
                        child: Wrap(
                          children: List.generate(5, (index) => _tagItem()),
                          spacing: 10,
                          runSpacing: 10,
                        ),
                      )

                      //cái này là button gọi điện
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

    Widget _tagItem() {
    return Container(
      height: 30,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.only(left: 5.0, right: 5.0),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          offset: Offset(0, 1),
          blurRadius: 2,
          color: Colors.black.withOpacity(0.3),
        )
      ], color: Colors.white),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            Assets.iconTag,
            scale: 3.0,
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            "Tag1",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColors.primaryColor,
                fontSize: 14.0,
                fontWeight: FontWeight.w500),
            // maxLines: 1,
          )
        ],
      ),
    );
  }


  Widget _actionItem(String icon, Color color,
      {num number, bool show = false, Function ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
          margin: EdgeInsets.only(left: 17),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: color, borderRadius: BorderRadius.circular(1000.0)),
                child: Center(
                  child: Image.asset(
                    icon,
                    scale: 2.5,
                  ),
                ),
              ),
              show
                  ? Positioned(
                      left: 30,
                      bottom: 30,
                      child: Container(
                        width: (number > 99)
                            ? 30
                            : (number > 9)
                                ? 25
                                : 22,
                        height: 20,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Color(0xFFF45E38)),
                        child: Center(
                            child: Text("${number ?? 0}",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w600))),
                      ))
                  : Container()
            ],
          )),
    );
  }

   Widget orderHistory() {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          orderHistoryItem(),
          orderHistoryItem(),
          orderHistoryItem(),
        ],
      ),
    );
  }

  Widget orderHistoryItem() {
    return Container(
      padding: EdgeInsets.all(8.0),
      margin: EdgeInsets.only(bottom: 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 2,
              color: Colors.black.withOpacity(0.3),
            )
          ]),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: CustomInfoItem(
                      icon: Assets.iconDeal, title: "DH_140720222900")),
              Container(
                height: 24,
                // width: 55,
                padding: EdgeInsets.only(left: 10.0, right: 10.0),
                // margin: EdgeInsets.only(right: 8.0),
                decoration: BoxDecoration(
                    color: Color(0xFF11B482),
                    borderRadius: BorderRadius.circular(50.0)),
                child: Center(
                  child: Text("Đã thanh toán",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500)),
                ),
              )
            ],
          ),
          CustomInfoItem(icon: Assets.iconTime, title: "15:00 14 tháng 7,2022"),
          CustomInfoItem(icon: Assets.iconBranch, title: "Chi nhánh 1"),
          CustomInfoItem(icon: Assets.iconShipper, title: "Giao hàng - 2022-12-24 13:30"),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(child: CustomInfoItem(icon: Assets.iconDeal, title: "1 sản phẩm")),
              Row(
                children: [
                  Image.asset(Assets.iconTag,scale: 2.5,),
                  SizedBox(width: 10.0,),
                  Text("35.000 VND",style: TextStyle(
                          color: AppColors.primaryColor,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _phoneNumberItem() {
    return Container(
      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
      margin: EdgeInsets.only(left: 15.0 / 2),
      child: Row(
        children: [
          Container(
            width: (MediaQuery.of(context).size.width) / 2.1,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    AppLocalizations.text(LangKey.phoneNumber),
                    style: AppTextStyles.style15BlackNormal,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Text(detail?.phone ?? "",
                style: AppTextStyles.style16BlueWeight500),
          ),
          InkWell(
            onTap: () {
              callPhone(detail?.phone ?? "");
            },
            child: Container(
              padding: EdgeInsets.all(8.0),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                color: Color(0xFF06A605),
                borderRadius: BorderRadius.circular(50),
                // border:  Border.all(color: AppColors.white,)
              ),
              child: Center(
                  child: Image.asset(
                Assets.iconCall,
                color: AppColors.white,
              )),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> callPhone(String phone) async {
    final regSpace = RegExp(r"\s+");
    // return await launchUrl(Uri.parse("tel:" + phone.replaceAll(regSpace, "")));
    return await launch("tel:" + phone.replaceAll(regSpace, ""));
  }

  Future<bool> _openChathub(String link) async {
    return await launch(link);
  }

Widget _buildAvatar(String name) {
    return Container(
      width: 87.0,
      height: 87.0,
      decoration: BoxDecoration(
        border: Border.all(
          width: 2.0,
          color: AppColors.primaryColor,
        ),
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10000.0),
        child: CustomAvatarDetail(
          color: Color(0xFFEEB132),
          name: name,
          textSize: 36.0,
        ),
      ),
    );
  }

  Widget _buildFunction(String name, String icon, Color color, Function ontap) {
    return InkWell(
      onTap: ontap,
      child: Column(
        children: [
          Container(
            width: 50.0,
            height: 50.0,
            padding: (name == AppLocalizations.text(LangKey.recall))
                ? EdgeInsets.all(8.0)
                : EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
            child: Image.asset(
              icon,
            ),
          ),
          Container(height: 8.0),
          Text(name)
        ],
      ),
    );
  }
}

class DetailPotentialTabModel {
  String typeName;
  int typeID;
  bool selected;

  DetailPotentialTabModel({this.typeName, this.typeID, this.selected});

  factory DetailPotentialTabModel.fromJson(Map<String, dynamic> parsedJson) {
    return DetailPotentialTabModel(
        typeName: parsedJson['typeName'],
        typeID: parsedJson['typeID'],
        selected: parsedJson['selected']);
  }
}
