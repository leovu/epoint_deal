class SurveyListMissionRequestModel {
  int? branchId;
  String? dateStart;
  String? dateEnd;

  SurveyListMissionRequestModel({this.branchId, this.dateStart, this.dateEnd});

  SurveyListMissionRequestModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    return data;
  }
}