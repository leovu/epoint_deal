class WorkListStaffResponseModel {
  List<WorkListStaffModel>? data;

  WorkListStaffResponseModel({this.data});

  WorkListStaffResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListStaffModel>[];
      json.forEach((v) {
        data!.add(new WorkListStaffModel.fromJson(v));
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

class WorkListStaffModel {
  int? staffId;
  String? staffName;
  String? staffAvatar;
  int? branchId;
  int? departmentId;
  String? departmentName;
  bool? isSelected;

  WorkListStaffModel({
    this.staffId,
    this.staffName,
    this.staffAvatar,
    this.branchId,
    this.departmentId,
    this.departmentName,
    this.isSelected = false
  });

  WorkListStaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    staffAvatar = json['staff_avatar'];
    branchId = json['branch_id'];
    departmentId = json['department_id'];
    departmentName = json['department_name'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['staff_avatar'] = this.staffAvatar;
    data['branch_id'] = this.branchId;
    data['department_id'] = this.departmentId;
    data['department_name'] = this.departmentName;
    return data;
  }
}