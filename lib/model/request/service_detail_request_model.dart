class ServiceDetailRequestModel {
  int? serviceId;

  ServiceDetailRequestModel({this.serviceId});

  ServiceDetailRequestModel.fromJson(Map<String, dynamic> json) {
    serviceId = json['service_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_id'] = this.serviceId;
    return data;
  }
}