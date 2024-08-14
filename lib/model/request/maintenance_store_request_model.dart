class MaintenanceStoreRequestModel {
  int? maintenanceId;
  String? maintenanceCode;
  String? customerCode;
  String? warrantyCode;
  double? warrantyValue;
  double? maintenanceCost;
  double? insurancePay;
  double? amountPay;
  double? totalAmountPay;
  int? staffId;
  String? objectType;
  int? objectTypeId;
  String? objectCode;
  String? objectSerial;
  String? objectStatus;
  String? maintenanceContent;
  String? dateEstimateDelivery;
  String? status;
  List<MaintenanceStoreCostModel>? costType;
  List<MaintenanceStoreImageModel>? listImage;

  MaintenanceStoreRequestModel(
      {this.maintenanceId,
        this.maintenanceCode,
        this.customerCode,
        this.warrantyCode,
        this.warrantyValue,
        this.maintenanceCost,
        this.insurancePay,
        this.amountPay,
        this.totalAmountPay,
        this.staffId,
        this.objectType,
        this.objectTypeId,
        this.objectCode,
        this.objectSerial,
        this.objectStatus,
        this.maintenanceContent,
        this.dateEstimateDelivery,
        this.status,
        this.costType,
        this.listImage});

  MaintenanceStoreRequestModel.fromJson(Map<String, dynamic> json) {
    maintenanceId = json['maintenance_id'];
    maintenanceCode = json['maintenance_code'];
    customerCode = json['customer_code'];
    warrantyCode = json['warranty_code'];
    warrantyValue = json['warranty_value'];
    maintenanceCost = json['maintenance_cost'];
    insurancePay = json['insurance_pay'];
    amountPay = json['amount_pay'];
    totalAmountPay = json['total_amount_pay'];
    staffId = json['staff_id'];
    objectType = json['object_type'];
    objectTypeId = json['object_type_id'];
    objectCode = json['object_code'];
    objectSerial = json['object_serial'];
    objectStatus = json['object_status'];
    maintenanceContent = json['maintenance_content'];
    dateEstimateDelivery = json['date_estimate_delivery'];
    status = json['status'];
    if (json['cost_type'] != null) {
      costType = <MaintenanceStoreCostModel>[];
      json['cost_type'].forEach((v) {
        costType!.add(new MaintenanceStoreCostModel.fromJson(v));
      });
    }
    if (json['list_image'] != null) {
      listImage = <MaintenanceStoreImageModel>[];
      json['list_image'].forEach((v) {
        listImage!.add(new MaintenanceStoreImageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_id'] = this.maintenanceId;
    data['maintenance_code'] = this.maintenanceCode;
    data['customer_code'] = this.customerCode;
    data['warranty_code'] = this.warrantyCode;
    data['warranty_value'] = this.warrantyValue;
    data['maintenance_cost'] = this.maintenanceCost;
    data['insurance_pay'] = this.insurancePay;
    data['amount_pay'] = this.amountPay;
    data['total_amount_pay'] = this.totalAmountPay;
    data['staff_id'] = this.staffId;
    data['object_type'] = this.objectType;
    data['object_type_id'] = this.objectTypeId;
    data['object_code'] = this.objectCode;
    data['object_serial'] = this.objectSerial;
    data['object_status'] = this.objectStatus;
    data['maintenance_content'] = this.maintenanceContent;
    data['date_estimate_delivery'] = this.dateEstimateDelivery;
    data['status'] = this.status;
    if (this.costType != null) {
      data['cost_type'] = this.costType!.map((v) => v.toJson()).toList();
    }
    if (this.listImage != null) {
      data['list_image'] = this.listImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MaintenanceStoreCostModel {
  int? maintenanceCostTypeId;
  double? cost;

  MaintenanceStoreCostModel({this.maintenanceCostTypeId, this.cost});

  MaintenanceStoreCostModel.fromJson(Map<String, dynamic> json) {
    maintenanceCostTypeId = json['maintenance_cost_type_id'];
    cost = json['cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['maintenance_cost_type_id'] = this.maintenanceCostTypeId;
    data['cost'] = this.cost;
    return data;
  }
}

class MaintenanceStoreImageModel {
  String? type;
  String? link;

  MaintenanceStoreImageModel({this.type, this.link});

  MaintenanceStoreImageModel.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['link'] = this.link;
    return data;
  }
}
