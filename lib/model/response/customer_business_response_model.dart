class CustomerBusinessResponseModel {
  List<CustomerBusinessModel>? data;

  CustomerBusinessResponseModel({this.data});

  CustomerBusinessResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerBusinessModel>[];
      json.forEach((v) {
        data!.add(new CustomerBusinessModel.fromJson(v));
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

class CustomerBusinessModel {
  int? id;
  String? name;

  CustomerBusinessModel({this.id, this.name});

  CustomerBusinessModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}
