class SurveyProcessFinishResponseModel {
  String? title;
  String? message;
  String? detailBackground;
  int? surveyAnswerId;
  String? totalPoint;

  SurveyProcessFinishResponseModel({
    this.title,
    this.message,
    this.detailBackground,
    this.surveyAnswerId,
    this.totalPoint
  });

  SurveyProcessFinishResponseModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    detailBackground = json['detail_background'];
    surveyAnswerId = json['survey_answer_id'];
    totalPoint = json['total_point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    data['detail_background'] = this.detailBackground;
    data['survey_answer_id'] = this.surveyAnswerId;
    data['total_point'] = this.totalPoint;
    return data;
  }
}