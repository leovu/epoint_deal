class CustomerTypeWorkResponseModel {
  List<CustomerTypeWorkModel>? data;

  CustomerTypeWorkResponseModel({this.data});

  CustomerTypeWorkResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerTypeWorkModel>[];
      json.forEach((v) {
        data!.add(new CustomerTypeWorkModel.fromJson(v));
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

class CustomerTypeWorkModel {
  int? manageTypeWorkId;
  String? manageTypeWorkKey;
  String? manageTypeWorkName;
  String? manageTypeWorkIcon;

  CustomerTypeWorkModel(
      {this.manageTypeWorkId,
        this.manageTypeWorkKey,
        this.manageTypeWorkName,
        this.manageTypeWorkIcon});

  CustomerTypeWorkModel.fromJson(Map<String, dynamic> json) {
    manageTypeWorkId = json['manage_type_work_id'];
    manageTypeWorkKey = json['manage_type_work_key'];
    manageTypeWorkName = json['manage_type_work_name'];
    manageTypeWorkIcon = json['manage_type_work_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['manage_type_work_key'] = this.manageTypeWorkKey;
    data['manage_type_work_name'] = this.manageTypeWorkName;
    data['manage_type_work_icon'] = this.manageTypeWorkIcon;
    return data;
  }
}
