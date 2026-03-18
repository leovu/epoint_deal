class WarrantyPackageResponseModel {
  List<WarrantyPackageModel>? data;

  WarrantyPackageResponseModel({this.data});

  WarrantyPackageResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WarrantyPackageModel>[];
      json.forEach((v) {
        data!.add(new WarrantyPackageModel.fromJson(v));
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

class WarrantyPackageModel {
  int? warrantyPackedId;
  String? packedCode;
  String? packedName;

  WarrantyPackageModel({this.warrantyPackedId, this.packedCode, this.packedName});

  WarrantyPackageModel.fromJson(Map<String, dynamic> json) {
    warrantyPackedId = json['warranty_packed_id'];
    packedCode = json['packed_code'];
    packedName = json['packed_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['warranty_packed_id'] = this.warrantyPackedId;
    data['packed_code'] = this.packedCode;
    data['packed_name'] = this.packedName;
    return data;
  }
}
