class SendRatingRequestModel {
  int? customerId;
  int? appointmentId;

  SendRatingRequestModel({this.customerId, this.appointmentId});

  SendRatingRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    appointmentId = json['appointment_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['appointment_id'] = this.appointmentId;
    return data;
  }
}
