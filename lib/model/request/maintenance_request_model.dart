class MaintenanceRequestModel {
  String? search;
  String? packedCode;
  String? warrantyCardCode;
  String? createdAt;
  String? customerCode;
  String? status;
  int? page;

  MaintenanceRequestModel(
      {this.search,
        this.packedCode,
        this.warrantyCardCode,
        this.createdAt,
        this.customerCode,
        this.status,
        this.page});

  MaintenanceRequestModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    packedCode = json['packed_code'];
    warrantyCardCode = json['warranty_card_code'];
    createdAt = json['created_at'];
    customerCode = json['customer_code'];
    status = json['status'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['packed_code'] = this.packedCode;
    data['warranty_card_code'] = this.warrantyCardCode;
    data['created_at'] = this.createdAt;
    data['customer_code'] = this.customerCode;
    data['status'] = this.status;
    data['page'] = this.page;
    return data;
  }
}
