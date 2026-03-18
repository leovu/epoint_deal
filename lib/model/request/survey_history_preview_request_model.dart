class SurveyHistoryPreviewRequestModel {
  int? surveyAnswerId;
  int? branchId;
  int? questionNo;

  SurveyHistoryPreviewRequestModel({this.surveyAnswerId, this.branchId, this.questionNo});

  SurveyHistoryPreviewRequestModel.fromJson(Map<String, dynamic> json) {
    surveyAnswerId = json['survey_answer_id'];
    branchId = json['branch_id'];
    questionNo = json['question_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_answer_id'] = this.surveyAnswerId;
    data['branch_id'] = this.branchId;
    data['question_no'] = this.questionNo;
    return data;
  }
}