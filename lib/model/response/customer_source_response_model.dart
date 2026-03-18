class CustomerSourceResponseModel {
  List<CustomerSourceModel>? data;

  CustomerSourceResponseModel({this.data});

  CustomerSourceResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerSourceModel>[];
      json.forEach((v) {
        data!.add(new CustomerSourceModel.fromJson(v));
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

class CustomerSourceModel {
  int? customerSourceId;
  String? customerSourceName;
  String? customerSourceType;
  String? slug;
  int? isDefault;

  CustomerSourceModel(
      {this.customerSourceId,
        this.customerSourceName,
        this.customerSourceType,
        this.slug,
        this.isDefault});

  CustomerSourceModel.fromJson(Map<String, dynamic> json) {
    customerSourceId = json['customer_source_id'];
    customerSourceName = json['customer_source_name'];
    customerSourceType = json['customer_source_type'];
    slug = json['slug'];
    isDefault = int.tryParse((json['is_default'] ?? 0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_source_id'] = this.customerSourceId;
    data['customer_source_name'] = this.customerSourceName;
    data['customer_source_type'] = this.customerSourceType;
    data['slug'] = this.slug;
    data['is_default'] = this.isDefault;
    return data;
  }
}
