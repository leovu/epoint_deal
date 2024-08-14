class WarrantyCardRequestModel {
  String? search;
  String? status;
  String? warrantyPackedCode;
  String? createdAt;
  String? customerCode;
  int? page;

  WarrantyCardRequestModel(
      {this.search,
        this.status,
        this.warrantyPackedCode,
        this.createdAt,
        this.customerCode,
        this.page});

  WarrantyCardRequestModel.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    status = json['status'];
    warrantyPackedCode = json['warranty_packed_code'];
    createdAt = json['created_at'];
    customerCode = json['customer_code'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['status'] = this.status;
    data['warranty_packed_code'] = this.warrantyPackedCode;
    data['created_at'] = this.createdAt;
    data['customer_code'] = this.customerCode;
    data['page'] = this.page;
    return data;
  }
}
