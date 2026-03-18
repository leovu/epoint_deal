class AppointmentResourceResponseModel {
  List<AppointmentResourceModel>? data;

  AppointmentResourceResponseModel({this.data});

  AppointmentResourceResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <AppointmentResourceModel>[];
      json.forEach((v) {
        data!.add(new AppointmentResourceModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AppointmentResourceModel {
  int? appointmentSourceId;
  String? appointmentSourceName;
  int? isDefault;

  AppointmentResourceModel({this.appointmentSourceId, this.appointmentSourceName, this.isDefault});

  AppointmentResourceModel.fromJson(Map<String, dynamic> json) {
    appointmentSourceId = json['appointment_source_id'];
    appointmentSourceName = json['appointment_source_name'];
    isDefault = json['default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointment_source_id'] = this.appointmentSourceId;
    data['appointment_source_name'] = this.appointmentSourceName;
    data['default'] = this.isDefault;
    return data;
  }
}
