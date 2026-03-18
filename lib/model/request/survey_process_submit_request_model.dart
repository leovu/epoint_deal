class SurveyProcessSubmitRequestModel {
  int? branchId;
  int? surveyId;
  int? surveyQuestionId;
  List<SurveyProcessSubmitAnswerModel>? submitAnswer;

  SurveyProcessSubmitRequestModel(
      {this.branchId, this.surveyId, this.surveyQuestionId, this.submitAnswer});

  SurveyProcessSubmitRequestModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    surveyId = json['survey_id'];
    surveyQuestionId = json['survey_question_id'];
    if (json['submit_answer'] != null) {
      submitAnswer = <SurveyProcessSubmitAnswerModel>[];
      json['submit_answer'].forEach((v) {
        submitAnswer!.add(new SurveyProcessSubmitAnswerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['survey_id'] = this.surveyId;
    data['survey_question_id'] = this.surveyQuestionId;
    if (this.submitAnswer != null) {
      data['submit_answer'] =
          this.submitAnswer!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SurveyProcessSubmitAnswerModel {
  int? surveyQuestionChoiceId;
  String? text;

  SurveyProcessSubmitAnswerModel({this.surveyQuestionChoiceId, this.text});

  SurveyProcessSubmitAnswerModel.fromJson(Map<String, dynamic> json) {
    surveyQuestionChoiceId = json['survey_question_choice_id'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_question_choice_id'] = this.surveyQuestionChoiceId;
    data['text'] = this.text;
    return data;
  }
}