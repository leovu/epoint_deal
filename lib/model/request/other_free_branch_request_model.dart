class OtherFreeBranchRequestModel {
  int? branchId;

  OtherFreeBranchRequestModel({this.branchId});

  OtherFreeBranchRequestModel.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    return data;
  }
}
