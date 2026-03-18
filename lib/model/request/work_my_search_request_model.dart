class WorkMySearchRequestModel {
  String? startDate;
  String? endDate;
  int? manageStatusId;
  List<WorkMySearchStaffModel>? processorId;
  List<WorkMySearchStaffModel>? assignorId;
  List<WorkMySearchStaffModel>? supportId;
  int? manageProjectId;
  int? manageTypeWorkId;
  int? branchId;
  int? departmentId;
  String? manageWorkTitle;
  int? dateOverdue;
  String? tracker;
  int? page;

  WorkMySearchRequestModel(
      {this.startDate,
        this.endDate,
        this.manageStatusId,
        this.processorId,
        this.assignorId,
        this.supportId,
        this.manageProjectId,
        this.manageTypeWorkId,
        this.branchId,
        this.departmentId,
      this.manageWorkTitle,
      this.dateOverdue,
      this.tracker,
      this.page});

  WorkMySearchRequestModel.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    manageStatusId = json['manage_status_id'];
    if (json['processor_id'] != null) {
      processorId = <WorkMySearchStaffModel>[];
      json['processor_id'].forEach((v) {
        processorId!.add(new WorkMySearchStaffModel.fromJson(v));
      });
    }
    if (json['assignor_id'] != null) {
      assignorId = <WorkMySearchStaffModel>[];
      json['assignor_id'].forEach((v) {
        assignorId!.add(new WorkMySearchStaffModel.fromJson(v));
      });
    }
    if (json['support_id'] != null) {
      supportId = <WorkMySearchStaffModel>[];
      json['support_id'].forEach((v) {
        supportId!.add(new WorkMySearchStaffModel.fromJson(v));
      });
    }
    manageProjectId = json['manage_project_id'];
    manageTypeWorkId = json['manage_type_work_id'];
    branchId = json['branch_id'];
    departmentId = json['department_id'];
    manageWorkTitle = json['manage_work_title'];
    dateOverdue = json['date_overdue'];
    tracker = json['tracker'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['manage_status_id'] = this.manageStatusId;
    if (this.processorId != null) {
      data['processor_id'] = this.processorId!.map((v) => v.toJson()).toList();
    }
    if (this.assignorId != null) {
      data['assignor_id'] = this.assignorId!.map((v) => v.toJson()).toList();
    }
    if (this.supportId != null) {
      data['support_id'] = this.supportId!.map((v) => v.toJson()).toList();
    }
    data['manage_project_id'] = this.manageProjectId;
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['branch_id'] = this.branchId;
    data['department_id'] = this.departmentId;
    data['manage_work_title'] = this.manageWorkTitle;
    data['date_overdue'] = this.dateOverdue;
    data['tracker'] = this.tracker;
    data['page'] = this.page;
    return data;
  }
}

class WorkMySearchStaffModel {
  int? staffId;

  WorkMySearchStaffModel({this.staffId});

  WorkMySearchStaffModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    return data;
  }
}