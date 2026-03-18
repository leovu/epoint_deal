class TimekeepingHistoryRequestModel {
  int? page;
  int? branchId;
  int? departmentId;
  String? search;
  String? fromDate;
  String? toDate;

  TimekeepingHistoryRequestModel(
      {this.page,
        this.branchId,
        this.departmentId,
        this.search,
        this.fromDate,
        this.toDate});

  TimekeepingHistoryRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    branchId = json['branch_id'];
    departmentId = json['department_id'];
    search = json['search'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['branch_id'] = this.branchId;
    data['department_id'] = this.departmentId;
    data['search'] = this.search;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    return data;
  }
}