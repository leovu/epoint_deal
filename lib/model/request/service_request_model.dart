class ServiceRequestModel {
  String? serviceName;
  int? page;
  String? brandCode;

  ServiceRequestModel({this.serviceName, this.page, this.brandCode});

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    page = json['page'];
    brandCode = json['brand_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    data['page'] = this.page;
    data['brand_code'] = this.brandCode;
    return data;
  }
}
