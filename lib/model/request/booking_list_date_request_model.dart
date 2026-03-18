class BookingListDateRequestModel {
  String? date;
  String? timeStart;
  String? timeEnd;
  int? branchId;
  List<int?>? staffId;

  BookingListDateRequestModel(
      {this.date, this.timeStart, this.timeEnd, this.branchId, this.staffId});

  BookingListDateRequestModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    timeStart = json['time_start'];
    timeEnd = json['time_end'];
    branchId = json['branch_id'];
    staffId = json['staff_id'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time_start'] = this.timeStart;
    data['time_end'] = this.timeEnd;
    data['branch_id'] = this.branchId;
    data['staff_id'] = this.staffId;
    return data;
  }
}
