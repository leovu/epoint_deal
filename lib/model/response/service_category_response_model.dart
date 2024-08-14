class ServiceCategoryResponseModel {
  List<ServiceCategoryModel>? data;

  ServiceCategoryResponseModel({this.data});

  ServiceCategoryResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ServiceCategoryModel>[];
      json.forEach((v) {
        data!.add(new ServiceCategoryModel.fromJson(v));
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

class ServiceCategoryModel {
  int? serviceCategoryId;
  String? name;

  ServiceCategoryModel({this.serviceCategoryId, this.name});

  ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    serviceCategoryId = json['service_category_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_category_id'] = this.serviceCategoryId;
    data['name'] = this.name;
    return data;
  }
}
