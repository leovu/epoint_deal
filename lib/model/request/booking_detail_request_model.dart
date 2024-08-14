class BookingDetailRequestModel {
  int? customerAppointmentId;

  BookingDetailRequestModel({this.customerAppointmentId});

  BookingDetailRequestModel.fromJson(Map<String, dynamic> json) {
    customerAppointmentId = json['customer_appointment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_appointment_id'] = this.customerAppointmentId;
    return data;
  }
}
