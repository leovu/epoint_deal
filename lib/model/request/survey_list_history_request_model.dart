class SurveyListHistoryRequestModel {
  int? branchId;
  int? page;
  String? dateStart;
  String? dateEnd;

  SurveyListHistoryRequestModel({this.branchId, this.page, this.dateStart, this.dateEnd});

  SurveyListHistoryRequestModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    page = json['page'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['page'] = this.page;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    return data;
  }
}