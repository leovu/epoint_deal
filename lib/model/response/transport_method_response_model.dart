class TransportMethodResponseModel {
  List<TransportMethodModel>? data;

  TransportMethodResponseModel({this.data});

  TransportMethodResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TransportMethodModel>[];
      json.forEach((v) {
        data!.add(new TransportMethodModel.fromJson(v));
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

class TransportMethodModel {
  int? typeShipping;
  String? text;
  double? transportCharge;
  int? deliveryCostId;
  int? isDefault;
  late bool selected;

  TransportMethodModel(
      {this.typeShipping,
        this.text,
        this.transportCharge,
        this.deliveryCostId,
        this.isDefault});

  TransportMethodModel.fromJson(Map<String, dynamic> json) {
    typeShipping = json['type_shipping'];
    text = json['text'];
    transportCharge = json['transport_charge'] == null? null: double.tryParse(json['transport_charge'].toString());
    deliveryCostId = json['delivery_cost_id'];
    isDefault = json['default'];
    selected = isDefault == 1;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_shipping'] = this.typeShipping;
    data['text'] = this.text;
    data['transport_charge'] = this.transportCharge;
    data['delivery_cost_id'] = this.deliveryCostId;
    data['default'] = this.isDefault;
    return data;
  }
}