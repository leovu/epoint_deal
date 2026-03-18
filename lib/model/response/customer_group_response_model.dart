class CustomerGroupResponseModel {
  List<CustomerGroupModel>? data;

  CustomerGroupResponseModel({this.data});

  CustomerGroupResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerGroupModel>[];
      json.forEach((v) {
        data!.add(new CustomerGroupModel.fromJson(v));
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

class CustomerGroupModel {
  int? customerGroupId;
  String? groupName;
  int? isDefault;
  bool? selected;

  CustomerGroupModel({this.customerGroupId, this.groupName, this.isDefault});

  CustomerGroupModel.fromJson(Map<String, dynamic> json) {
    customerGroupId = json['customer_group_id'];
    groupName = json['group_name'];
    isDefault = int.tryParse((json['is_default'] ?? 0).toString());
    selected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_group_id'] = this.customerGroupId;
    data['group_name'] = this.groupName;
    data['is_default'] = this.isDefault;
    return data;
  }
}