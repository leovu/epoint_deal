class BrandRequestModel {
  String? clientKey;

  BrandRequestModel({this.clientKey});

  BrandRequestModel.fromJson(Map<String, dynamic> json) {
    clientKey = json['client_key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['client_key'] = this.clientKey;
    return data;
  }
}