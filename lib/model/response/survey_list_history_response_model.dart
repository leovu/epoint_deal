

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class SurveyListHistoryResponseModel {
  PageInfoModel? pageInfo;
  List<SurveyListHistoryModel?>? items;

  SurveyListHistoryResponseModel({this.pageInfo, this.items});

  SurveyListHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <SurveyListHistoryModel?>[];
      json['Items'].forEach((v) {
        items!.add(new SurveyListHistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v!.toJson()).toList();
    }
    return data;
  }
}

class SurveyListHistoryModel {
  int? surveyAnswerId;
  int? surveyId;
  String? surveyName;
  String? surveyCode;
  String? surveyDescription;
  String? surveyBanner;
  int? accumulationPoint;
  String? finishedAt;
  String? totalPoint;

  SurveyListHistoryModel(
      {this.surveyAnswerId,
        this.surveyId,
        this.surveyName,
        this.surveyCode,
        this.surveyDescription,
        this.surveyBanner,
        this.accumulationPoint,
        this.finishedAt,
        this.totalPoint});

  SurveyListHistoryModel.fromJson(Map<String, dynamic> json) {
    surveyAnswerId = json['survey_answer_id'];
    surveyId = json['survey_id'];
    surveyName = json['survey_name'];
    surveyCode = json['survey_code'];
    surveyDescription = json['survey_description'];
    surveyBanner = json['survey_banner'];
    accumulationPoint = json['accumulation_point'];
    finishedAt = json['finished_at'];
    totalPoint = json['total_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_answer_id'] = this.surveyAnswerId;
    data['survey_id'] = this.surveyId;
    data['survey_name'] = this.surveyName;
    data['survey_code'] = this.surveyCode;
    data['survey_description'] = this.surveyDescription;
    data['survey_banner'] = this.surveyBanner;
    data['accumulation_point'] = this.accumulationPoint;
    data['finished_at'] = this.finishedAt;
    data['total_point'] = this.totalPoint;
    return data;
  }
}