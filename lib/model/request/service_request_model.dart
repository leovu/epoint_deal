class ServiceRequestModel {
  String? serviceName;
  int? page;
  int? serviceCategoryId;

  ServiceRequestModel({this.serviceName, this.page, this.serviceCategoryId});

  ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    page = json['page'];
    serviceCategoryId = json['service_category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    data['page'] = this.page;
    data['service_category_id'] = this.serviceCategoryId;
    return data;
  }
}
