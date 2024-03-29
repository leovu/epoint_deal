class BranchModelResponse {
  int? errorCode;
  String? errorDescription;
  List<BranchData>? data;

  BranchModelResponse({this.errorCode, this.errorDescription, this.data});

  BranchModelResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    if (json['Data'] != null) {
      data = <BranchData>[];
      json['Data'].forEach((v) {
        data!.add(new BranchData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BranchData {
  int? branchId;
  String? branchName;
  String? address;
  String? branchCode;
  String? avatar;
  bool? selected;

  BranchData({this.branchId, this.branchName, this.address, this.branchCode,this.selected});

  BranchData.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    address = json['address'];
    branchCode = json['branch_code'];
    avatar = json['avatar'];
    selected = json['selected'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['address'] = this.address;
    data['branch_code'] = this.branchCode;
    data['avatar'] = this.avatar;
    data['selected'] = this.selected;
    return data;
  }
}