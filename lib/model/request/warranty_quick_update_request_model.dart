class WarrantyQuickUpdateRequestModel {
  String? warrantyCardCode;
  String? status;

  WarrantyQuickUpdateRequestModel({this.warrantyCardCode, this.status});

  WarrantyQuickUpdateRequestModel.fromJson(Map<String, dynamic> json) {
    warrantyCardCode = json['warranty_card_code'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_card_code'] = this.warrantyCardCode;
    data['status'] = this.status;
    return data;
  }
}
