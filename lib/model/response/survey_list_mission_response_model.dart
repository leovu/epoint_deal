class SurveyListMissionResponseModel {
  List<SurveyListMissionModel>? data;

  SurveyListMissionResponseModel({this.data});

  SurveyListMissionResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <SurveyListMissionModel>[];
      json.forEach((v) {
        data!.add(new SurveyListMissionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SurveyListMissionModel {
  int? surveyId;
  String? surveyName;
  String? surveyCode;
  String? countPoint;
  String? surveyDescription;
  String? surveyBanner;
  int? isExecTime;
  String? startDate;
  String? endDate;
  int? maxTimes;
  int? numCompletedTimes;
  String? surveyStatus;
  String? surveyStatusName;
  int? isInProcess;
  int? totalQuestions;
  int? numQuestionsCompleted;
  int? accumulationPoint;
  int? totalPoint;
  String? isStart;

  SurveyListMissionModel(
      {this.surveyId,
        this.surveyName,
        this.surveyCode,
        this.countPoint,
        this.surveyDescription,
        this.surveyBanner,
        this.isExecTime,
        this.startDate,
        this.endDate,
        this.maxTimes,
        this.numCompletedTimes,
        this.surveyStatus,
        this.surveyStatusName,
        this.isInProcess,
        this.totalQuestions,
        this.numQuestionsCompleted,
        this.accumulationPoint,
        this.totalPoint,
        this.isStart});

  SurveyListMissionModel.fromJson(Map<String, dynamic> json) {
    surveyId = json['survey_id'];
    surveyName = json['survey_name'];
    surveyCode = json['survey_code'];
    countPoint = json['count_point'];
    surveyDescription = json['survey_description'];
    surveyBanner = json['survey_banner'];
    isExecTime = json['is_exec_time'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    maxTimes = json['max_times'];
    numCompletedTimes = json['num_completed_times'];
    surveyStatus = json['survey_status'];
    surveyStatusName = json['survey_status_name'];
    isInProcess = json['is_in_process'];
    totalQuestions = json['total_questions'];
    numQuestionsCompleted = json['num_questions_completed'];
    accumulationPoint = json['accumulation_point'];
    totalPoint = json['total_point'];
    isStart = json['is_start'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['survey_id'] = this.surveyId;
    data['survey_name'] = this.surveyName;
    data['survey_code'] = this.surveyCode;
    data['count_point'] = this.countPoint;
    data['survey_description'] = this.surveyDescription;
    data['survey_banner'] = this.surveyBanner;
    data['is_exec_time'] = this.isExecTime;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['max_times'] = this.maxTimes;
    data['num_completed_times'] = this.numCompletedTimes;
    data['survey_status'] = this.surveyStatus;
    data['survey_status_name'] = this.surveyStatusName;
    data['is_in_process'] = this.isInProcess;
    data['total_questions'] = this.totalQuestions;
    data['num_questions_completed'] = this.numQuestionsCompleted;
    data['accumulation_point'] = this.accumulationPoint;
    data['total_point'] = this.totalPoint;
    data['is_start'] = this.isStart;
    return data;
  }
}