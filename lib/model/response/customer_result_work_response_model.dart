class CustomerResultWorkResponseModel {
  List<CustomerResultWorkModel>? data;

  CustomerResultWorkResponseModel({this.data});

  CustomerResultWorkResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <CustomerResultWorkModel>[];
      json.forEach((v) {
        data!.add(new CustomerResultWorkModel.fromJson(v));
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

class CustomerResultWorkModel {
  int? manageResultId;
  String? manageResultName;

  CustomerResultWorkModel({this.manageResultId, this.manageResultName});

  CustomerResultWorkModel.fromJson(Map<String, dynamic> json) {
    manageResultId = json['manage_result_id'];
    manageResultName = json['manage_result_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_result_id'] = this.manageResultId;
    data['manage_result_name'] = this.manageResultName;
    return data;
  }
}
