class CheckAppointmentResponseModel {
  int? rule;
  int? number;
  List<CheckAppointmentModel>? detail;

  CheckAppointmentResponseModel({this.rule, this.number, this.detail});

  CheckAppointmentResponseModel.fromJson(Map<String, dynamic> json) {
    rule = json['rule'];
    number = json['number'];
    if (json['detail'] != null) {
      detail = <CheckAppointmentModel>[];
      json['detail'].forEach((v) {
        detail!.add(new CheckAppointmentModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rule'] = this.rule;
    data['number'] = this.number;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CheckAppointmentModel {
  int? customerAppointmentId;
  String? status;

  CheckAppointmentModel({this.customerAppointmentId, this.status});

  CheckAppointmentModel.fromJson(Map<String, dynamic> json) {
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