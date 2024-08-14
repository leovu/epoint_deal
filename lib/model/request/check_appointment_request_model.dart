class CheckAppointmentRequestModel {
  String? date;
  int? branchId;
  int? customerId;

  CheckAppointmentRequestModel({this.date, this.branchId, this.customerId});

  CheckAppointmentRequestModel.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    branchId = json['branch_id'];
    customerId = json['customer_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['branch_id'] = this.branchId;
    data['customer_id'] = this.customerId;
    return data;
  }
}
