class BookingListRequestModel {
  String? viewType;
  String? dateStart;
  String? dateEnd;
  int? branchId;
  List<int?>? staffId;

  BookingListRequestModel(
      {this.viewType,
        this.dateStart,
        this.dateEnd,
        this.branchId,
        this.staffId});

  BookingListRequestModel.fromJson(Map<String, dynamic> json) {
    viewType = json['view_type'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    branchId = json['branch_id'];
    staffId = json['staff_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['view_type'] = this.viewType;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['branch_id'] = this.branchId;
    data['staff_id'] = this.staffId;
    return data;
  }
}
