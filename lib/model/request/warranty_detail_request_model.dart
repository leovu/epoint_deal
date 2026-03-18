class WarrantyDetailRequestModel {
  String? warrantyCardCode;

  WarrantyDetailRequestModel({this.warrantyCardCode});

  WarrantyDetailRequestModel.fromJson(Map<String, dynamic> json) {
    warrantyCardCode = json['warranty_card_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_card_code'] = this.warrantyCardCode;
    return data;
  }
}
