class WorkQuickUpdateRequestModel {
  int? manageWorkId;
  int? manageStatusId;
  String? manageStatusName;
  String? manageStatusColor;
  String? dateEnd;
  double? progress;

  WorkQuickUpdateRequestModel({
    this.manageWorkId,
    this.manageStatusId,
    this.manageStatusName,
    this.manageStatusColor,
    this.dateEnd,
    this.progress,
  });

  WorkQuickUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    manageStatusId = json['manage_status_id'];
    dateEnd = json['date_end'];
    progress = json['progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['manage_status_id'] = this.manageStatusId;
    data['date_end'] = this.dateEnd;
    data['progress'] = this.progress;
    return data;
  }
}