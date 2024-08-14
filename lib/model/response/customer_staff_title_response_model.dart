class CustomerStaffTitleResponseModel {
  List<CustomerStaffTitleModel>? data;

  CustomerStaffTitleResponseModel({this.data});

  CustomerStaffTitleResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerStaffTitleModel>[];
      json.forEach((v) {
        data!.add(new CustomerStaffTitleModel.fromJson(v));
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

class CustomerStaffTitleModel {
  int? staffTitleId;
  String? staffTitleName;
  String? staffTitleCode;

  CustomerStaffTitleModel({this.staffTitleId, this.staffTitleName, this.staffTitleCode});

  CustomerStaffTitleModel.fromJson(Map<String, dynamic> json) {
    staffTitleId = json['staff_title_id'];
    staffTitleName = json['staff_title_name'];
    staffTitleCode = json['staff_title_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_title_id'] = this.staffTitleId;
    data['staff_title_name'] = this.staffTitleName;
    data['staff_title_code'] = this.staffTitleCode;
    return data;
  }
}
