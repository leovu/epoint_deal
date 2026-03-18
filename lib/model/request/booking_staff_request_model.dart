class BookingStaffRequestModel {
  int? branchId;
  String? fullName;

  BookingStaffRequestModel({this.branchId, this.fullName});

  BookingStaffRequestModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['full_name'] = this.fullName;
    return data;
  }
}
