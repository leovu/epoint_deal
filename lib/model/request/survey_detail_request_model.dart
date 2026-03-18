class SurveyDetailRequestModel {
  int? branchId;
  int? surveyId;

  SurveyDetailRequestModel({this.branchId, this.surveyId});

  SurveyDetailRequestModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    surveyId = json['survey_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['survey_id'] = this.surveyId;
    return data;
  }
}