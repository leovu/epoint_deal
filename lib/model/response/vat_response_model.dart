class VATResponseModel {
  List<VATModel>? data;

  VATResponseModel({this.data});

  VATResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <VATModel>[];
      json.forEach((v) {
        data!.add(new VATModel.fromJson(v));
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

class VATModel {
  int? vatId;
  double? vat;
  String? description;

  VATModel({this.vatId, this.vat, this.description});

  VATModel.fromJson(Map<String, dynamic> json) {
    vatId = json['vat_id'];
    vat = double.tryParse((json['vat'] ?? "").toString());
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vat_id'] = this.vatId;
    data['vat'] = this.vat;
    data['description'] = this.description;
    return data;
  }
}
