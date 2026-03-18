


import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/model/filter_model.dart';
import 'package:epoint_deal_plugin/model/response/config_response_model.dart';
import 'package:epoint_deal_plugin/model/response/login_response_model.dart';
import 'package:epoint_deal_plugin/model/response/order_config_response_model.dart';
import 'package:epoint_deal_plugin/model/response/permission_response_model.dart';
import 'package:epoint_deal_plugin/model/response/work_list_status_response_model.dart';
import 'package:epoint_deal_plugin/model/response/work_type_customer_response_model.dart';
import 'package:epoint_deal_plugin/utils/global_cart.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

class Globals {

  static late Config config;

  static GlobalCart? cart;

  static LoginResponseModel? model;
  static List<PermissionModel>? permissionModels;
  static List<ConfigModel>? configModels;

  static LocaleType? localeType;

  // static TicketHomeBloc? ticketBloc;
  // static WorkMainBloc? workBloc;
  // static MyJobBloc? myJobBloc;
  // static ProjectBloc? projectBloc;
  // static OverviewBloc? overviewBloc;
  // static JobListBloc? jobListBloc;
  // static JobDetailsFilterModel? jobListFilterModel;
  // static ProjectListDocumentRequestModel? requestDocumentProject;
  // static ProjectListMemberRequestModel? requestMemberProject;



  static List<WorkListStatusModel> workStatusModels = [];
  static List<WorkListStatusModel> workStatusFilterModels = [];
  static List<WorkTypeCustomerModel> workTypeCustomerModels = [];

  static List<FilterModel> orderStatusModels = [
    FilterModel(
      id: orderStatusNew,
      text: AppLocalizations.text(LangKey.newString),
      color: parseOrderStatusColor(orderStatusNew),
    ),
    FilterModel(
      id: orderStatusConfirmed,
      text: AppLocalizations.text(LangKey.confirmed),
      color: parseOrderStatusColor(orderStatusConfirmed),
    ),
    FilterModel(
      id: orderStatusPayHalf,
      text: AppLocalizations.text(LangKey.missing_payment),
      color: parseOrderStatusColor(orderStatusPayHalf),
    ),
    FilterModel(
      id: orderStatusPaySuccess,
      text: AppLocalizations.text(LangKey.paid),
      color: parseOrderStatusColor(orderStatusPaySuccess),
    ),
    FilterModel(
      id: orderStatusOrderCancle,
      text: AppLocalizations.text(LangKey.cancelled),
      color: parseOrderStatusColor(orderStatusOrderCancle),
    ),
  ];

  static List<FilterModel> ticketTypeModels = [
    FilterModel(
      text: AppLocalizations.text(LangKey.all),
    ),
    FilterModel(
      id: ticketTypeD,
      text: AppLocalizations.text(LangKey.deploy_contract),
    ),
    FilterModel(
      id: ticketTypeI,
      text: AppLocalizations.text(LangKey.resolve_problem),
    ),
  ];

  static List<FilterModel> levelModels = [
    FilterModel(text: AppLocalizations.text(LangKey.all)),
    FilterModel(id: 1, text: "${AppLocalizations.text(LangKey.level)} 1"),
    FilterModel(id: 2, text: "${AppLocalizations.text(LangKey.level)} 2"),
    FilterModel(id: 3, text: "${AppLocalizations.text(LangKey.level)} 3"),
    FilterModel(id: 4, text: "${AppLocalizations.text(LangKey.level)} 4"),
    FilterModel(id: 5, text: "${AppLocalizations.text(LangKey.level)} 5"),
  ];

  static List<FilterModel> priorityModels = [
    FilterModel(text: AppLocalizations.text(LangKey.all)),
    FilterModel(id: priorityH, text: AppLocalizations.text(LangKey.high)),
    FilterModel(id: priorityL, text: AppLocalizations.text(LangKey.normal)),
    FilterModel(id: priorityN, text: AppLocalizations.text(LangKey.low))
  ];

  static List<FilterModel> timeModels = [
    FilterModel(text: AppLocalizations.text(LangKey.all)),
    FilterModel(
        id: typeTimeLastMonth, text: AppLocalizations.text(LangKey.last_month)),
    FilterModel(
        id: typeTimeThisMonth, text: AppLocalizations.text(LangKey.this_month)),
    FilterModel(id: typeTimeCustom, text: AppLocalizations.text(LangKey.custom))
  ];

  static List<FilterModel> queueModels = [
    FilterModel(text: AppLocalizations.text(LangKey.all))
  ];

  static List<FilterModel> reportStatusModels = [
    FilterModel(id: statusNew, text: AppLocalizations.text(LangKey.newString)),
    FilterModel(id: statusCancel, text: AppLocalizations.text(LangKey.cancel)),
    FilterModel(id: statusApprove, text: AppLocalizations.text(LangKey.signed))
  ];

  static List<OrderConfigModel>? orderConfigModels;

  static bool isManager = false;

  // static late TtfFont pdfFont;
  // static late TtfFont pdfFontItalic;
  // static late TtfFont pdfFontBold;
  // static late TtfFont pdfFontBoldItalic;
}

class Config {
  String? appId;
  String? publicServer;
  String? server;
  String? serverChat;
  String? serverChatHub;
  String? serverDocument;
  String? clientKey;
  String? iconApp;
  String? backgroundSplash;
  bool? isSandbox;
  String? langDefault;
  bool? enableLang;
  String? releaseDate;
  bool? displayPrint;

  Config(
      {this.appId,
        this.publicServer,
        this.server,
        this.serverChat,
        this.serverChatHub,
        this.serverDocument,
        this.clientKey,
        this.iconApp,
        this.backgroundSplash,
        this.isSandbox,
        this.langDefault,
        this.enableLang,
        this.releaseDate,
        this.displayPrint});

  Config.fromJson(Map<String, dynamic> json) {
    appId = json['appId'];
    publicServer = json['publicServer'];
    if((publicServer ?? "").isNotEmpty){
      if (!publicServer!.endsWith("/")) {
        publicServer = "$publicServer/";
      }
    }
    server = json['server'];
    if (!server!.endsWith("/")) {
      server = "$server/";
    }
    serverChat = json['serverChat'];
    if (!serverChat!.endsWith("/")) {
      serverChat = "$serverChat/";
    }
    serverChatHub = json['serverChatHub'];
    if (!serverChatHub!.endsWith("/")) {
      serverChatHub = "$serverChatHub/";
    }
    serverDocument = json['serverDocument'];
    clientKey = json['clientKey'];
    iconApp = json['iconApp'];
    backgroundSplash = json['backgroundSplash'];
    isSandbox = json['isSandbox'];
    langDefault = json['langDefault'];
    enableLang = json['enableLang'] ?? false;
    releaseDate = json['releaseDate'];
    displayPrint = json['displayPrint'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appId'] = this.appId;
    data['publicServer'] = this.publicServer;
    data['server'] = this.server;
    data['serverChat'] = this.serverChat;
    data['serverDocument'] = this.serverDocument;
    data['clientKey'] = this.clientKey;
    data['iconApp'] = this.iconApp;
    data['backgroundSplash'] = this.backgroundSplash;
    data['isSandbox'] = this.isSandbox;
    data['langDefault'] = this.langDefault;
    data['enableLang'] = this.enableLang;
    data['releaseDate'] = this.releaseDate;
    data['displayPrint'] = this.displayPrint;
    return data;
  }
}

