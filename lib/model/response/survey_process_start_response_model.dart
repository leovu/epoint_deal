
import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:flutter/material.dart';

class SurveyProcessStartResponseModel {
  PageInfoModel? pageInfo;
  SurveyProcessModel? items;

  SurveyProcessStartResponseModel({this.pageInfo, this.items});

  SurveyProcessStartResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    items = json['Items'] != null ? new SurveyProcessModel.fromJson(json['Items']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.toJson();
    }
    return data;
  }
}

class SurveyProcessModel {
  int? surveyQuestionId;
  int? surveyId;
  String? surveyQuestionTitle;
  String? surveyQuestionDescription;
  String? surveyQuestionType;
  SurveyProcessQuestionConfigModel? surveyQuestionConfig;
  int? isRequired;
  int? isCombineQuestion;
  int? displayPos;
  List<SurveyProcessListChoiceModel>? listChoice;
  List<SurveyProcessListChoiceModel>? listAnswerSuccess;
  String? answerValue;
  int? valuePoint;
  String? resultAnswer;
  FocusNode? focusNode;
  TextEditingController? controller;

  SurveyProcessModel(
      {this.surveyQuestionId,
        this.surveyId,
        this.surveyQuestionTitle,
        this.surveyQuestionDescription,
        this.surveyQuestionConfig,
        this.surveyQuestionType,
        this.isRequired,
        this.isCombineQuestion,
        this.displayPos,
        this.listChoice,
        this.listAnswerSuccess,
        this.answerValue,
        this.valuePoint,
        this.resultAnswer});

  SurveyProcessModel.fromJson(Map<String, dynamic> json) {
    surveyQuestionId = json['survey_question_id'];
    surveyId = json['survey_id'];
    surveyQuestionTitle = json['survey_question_title'];
    surveyQuestionDescription = json['survey_question_description'];
    surveyQuestionType = json['survey_question_type'];
    surveyQuestionConfig = json['survey_question_config'] != null
        ? new SurveyProcessQuestionConfigModel.fromJson(json['survey_question_config'])
        : null;
    isRequired = json['is_required'];
    isCombineQuestion = json['is_combine_question'];
    displayPos = json['display_pos'];
    if (json['list_choice'] != null) {
      listChoice = <SurveyProcessListChoiceModel>[];
      json['list_choice'].forEach((v) {
        listChoice!.add(new SurveyProcessListChoiceModel.fromJson(v));
      });
    }
    if (json['list_answer_success'] != null) {
      listAnswerSuccess = <SurveyProcessListChoiceModel>[];
      json['list_answer_success'].forEach((v) {
        listAnswerSuccess!.add(new SurveyProcessListChoiceModel.fromJson(v));
      });
    }
    answerValue = json['answer_value'];
    valuePoint = json['value_point'];
    resultAnswer = json['result_answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_question_id'] = this.surveyQuestionId;
    data['survey_id'] = this.surveyId;
    data['survey_question_title'] = this.surveyQuestionTitle;
    data['survey_question_description'] = this.surveyQuestionDescription;
    data['survey_question_type'] = this.surveyQuestionType;
    if (this.surveyQuestionConfig != null) {
      data['survey_question_config'] = this.surveyQuestionConfig!.toJson();
    }
    data['is_required'] = this.isRequired;
    data['is_combine_question'] = this.isCombineQuestion;
    data['display_pos'] = this.displayPos;
    if (this.listChoice != null) {
      data['list_choice'] = this.listChoice!.map((v) => v.toJson()).toList();
    }
    if (this.listAnswerSuccess != null) {
      data['list_answer_success'] = this.listAnswerSuccess!.map((v) => v.toJson()).toList();
    }
    data['answer_value'] = this.answerValue;
    data['value_point'] = this.valuePoint;
    data['result_answer'] = this.resultAnswer;
    return data;
  }
}

class SurveyProcessListChoiceModel {
  int? surveyQuestionChoiceId;
  String? surveyQuestionChoiceTitle;
  bool? isSelected;

  SurveyProcessListChoiceModel(
      {this.surveyQuestionChoiceId,
        this.surveyQuestionChoiceTitle,
        this.isSelected});

  SurveyProcessListChoiceModel.fromJson(Map<String, dynamic> json) {
    surveyQuestionChoiceId = json['survey_question_choice_id'];
    surveyQuestionChoiceTitle = json['survey_question_choice_title'];
    isSelected = json['is_selected'] == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_question_choice_id'] = this.surveyQuestionChoiceId;
    data['survey_question_choice_title'] = this.surveyQuestionChoiceTitle;
    data['is_selected'] = this.isSelected;
    return data;
  }
}

class SurveyProcessQuestionConfigModel {
  int? numImage;
  List<String>? image;
  String? validType;
  SurveyProcessValidOptionModel? validOption;

  SurveyProcessQuestionConfigModel({this.numImage, this.image, this.validType, this.validOption});

  SurveyProcessQuestionConfigModel.fromJson(Map<String, dynamic> json) {
    numImage = json['num_image'];
    image = json['image']?.cast<String>();
    validType = json['valid_type'];
    validOption = json['valid_option'] != null
        ? new SurveyProcessValidOptionModel.fromJson(json['valid_option'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['num_image'] = this.numImage;
    data['image'] = this.image;
    data['valid_type'] = this.validType;
    if (this.validOption != null) {
      data['valid_option'] = this.validOption!.toJson();
    }
    return data;
  }
}

class SurveyProcessValidOptionModel {
  String? inputType;
  int? min;
  int? max;

  SurveyProcessValidOptionModel({this.inputType, this.min, this.max});

  SurveyProcessValidOptionModel.fromJson(Map<String, dynamic> json) {
    inputType = json['input_type'];
    min = json['min'];
    max = json['max'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['input_type'] = this.inputType;
    data['min'] = this.min;
    data['max'] = this.max;
    return data;
  }
}