class MaintenanceDetailRequestModel {
  String? maintenanceCode;

  MaintenanceDetailRequestModel({this.maintenanceCode});

  MaintenanceDetailRequestModel.fromJson(Map<String, dynamic> json) {
    maintenanceCode = json['maintenance_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_code'] = this.maintenanceCode;
    return data;
  }
}
