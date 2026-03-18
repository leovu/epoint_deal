class SurveyProcessStartRequestModel {
  int? branchId;
  int? surveyId;
  int? questionNo;

  SurveyProcessStartRequestModel({this.branchId, this.surveyId, this.questionNo});

  SurveyProcessStartRequestModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    surveyId = json['survey_id'];
    questionNo = json['question_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['survey_id'] = this.surveyId;
    data['question_no'] = this.questionNo;
    return data;
  }
}