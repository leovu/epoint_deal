class BookingUpdateStatusRequestModel {
  int? customerAppointmentId;
  String? status;

  BookingUpdateStatusRequestModel({this.customerAppointmentId, this.status});

  BookingUpdateStatusRequestModel.fromJson(Map<String, dynamic> json) {
    customerAppointmentId = json['customer_appointment_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_appointment_id'] = this.customerAppointmentId;
    data['status'] = this.status;
    return data;
  }
}
