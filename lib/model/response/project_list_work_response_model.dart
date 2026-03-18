

import 'package:epoint_deal_plugin/model/response/project_phase_list_response_model.dart';

class ProjectListWorkResponseModel {
  List<ProjectListWorkModel>? data;

  ProjectListWorkResponseModel({this.data});

  ProjectListWorkResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProjectListWorkModel>[];
      json.forEach((v) {
        data!.add(new ProjectListWorkModel.fromJson(v));
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

class ProjectListWorkModel {
  int? manageProjectPhaseId;
  int? manageProjectId;
  String? phaseName;
  String? phaseStart;
  String? phaseEnd;
  int? pic;
  String? phaseStatus;
  String? createdAt;
  int? createdBy;
  String? staffName;
  String? staffAvatar;
  List<WorkList>? workList;
  int? workLate;

  ProjectListWorkModel(
      {this.manageProjectPhaseId,
        this.manageProjectId,
        this.phaseName,
        this.phaseStart,
        this.phaseEnd,
        this.pic,
        this.phaseStatus,
        this.createdAt,
        this.createdBy,
        this.staffName,
        this.staffAvatar,
        this.workList, this.workLate});

  ProjectListWorkModel.fromJson(Map<String, dynamic> json) {
    manageProjectPhaseId = json['manage_project_phase_id'];
    manageProjectId = json['manage_project_id'];
    phaseName = json['phase_name'];
    phaseStart = json['phase_start'];
    phaseEnd = json['phase_end'];
    pic = json['pic'];
    phaseStatus = json['phase_status'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    staffName = json['staff_name'];
    staffAvatar = json['staff_avatar'];
    if (json['work_list'] != null) {
      workList = <WorkList>[];
      json['work_list'].forEach((v) {
        workList!.add(new WorkList.fromJson(v));
      });
    }
    workLate = json['work_late'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_project_phase_id'] = this.manageProjectPhaseId;
    data['manage_project_id'] = this.manageProjectId;
    data['phase_name'] = this.phaseName;
    data['phase_start'] = this.phaseStart;
    data['phase_end'] = this.phaseEnd;
    data['pic'] = this.pic;
    data['phase_status'] = this.phaseStatus;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['staff_name'] = this.staffName;
    data['staff_avatar'] = this.staffAvatar;
    if (this.workList != null) {
      data['work_list'] = this.workList!.map((v) => v.toJson()).toList();
    }
    data['work_late'] = this.workLate;
    return data;
  }
}

class WorkList {
  int?  workId;
  String?  customerType;
  int?  projectId;
  String?  workCode;
  String?  workTitle;
  int?  typeWorkId;
  String?  typeWorkKey;
  String?  typeWorkName;
  int?  statusId;
  String?  statusName;
  int?  phaseId;
  String?  phaseName;
  String?  phaseStart;
  String?  phaseEnd;
  int?  processorId;
  String?  dateStart;
  String?  dateEnd;
  String?  dateFinish;
  int?  progress;
  int?  time;
  String?  timeType;
  int?  departmentId;
  String?  departmentName;
  Staff?  staff;
  int?  comment;

  WorkList(
      {this.workId,
        this.customerType,
        this.projectId,
        this.workCode,
        this.workTitle,
        this.typeWorkId,
        this.typeWorkKey,
        this.typeWorkName,
        this.statusId,
        this.statusName,
        this.phaseId,
        this.phaseName,
        this.phaseStart,
        this.phaseEnd,
        this.processorId,
        this.dateStart,
        this.dateEnd,
        this.dateFinish,
        this.progress,
        this.time,
        this.timeType,
        this.departmentId,
        this.departmentName,
        this.staff,
        this.comment});

  WorkList.fromJson(Map<String, dynamic> json) {
    workId = json['work_id'];
    customerType = json['customer_type'];
    projectId = json['project_id'];
    workCode = json['work_code'];
    workTitle = json['work_title'];
    typeWorkId = json['type_work_id'];
    typeWorkKey = json['type_work_key'];
    typeWorkName = json['type_work_name'];
    statusId = json['status_id'];
    statusName = json['status_name'];
    phaseId = json['phase_id'];
    phaseName = json['phase_name'];
    phaseStart = json['phase_start'];
    phaseEnd = json['phase_end'];
    processorId = json['processor_id'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    dateFinish = json['date_finish'];
    progress = json['progress'];
    time = json['time_new'];
    timeType = json['time_type'];
    departmentId = json['department_id'];
    departmentName = json['department_name'];
    staff = json['staff'] != null ? new Staff.fromJson(json['staff']) : null;
    comment = json['comment'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['work_id'] = this.workId;
    data['customer_type'] = this.customerType;
    data['project_id'] = this.projectId;
    data['work_code'] = this.workCode;
    data['work_title'] = this.workTitle;
    data['type_work_id'] = this.typeWorkId;
    data['type_work_key'] = this.typeWorkKey;
    data['type_work_name'] = this.typeWorkName;
    data['status_id'] = this.statusId;
    data['status_name'] = this.statusName;
    data['phase_id'] = this.phaseId;
    data['phase_name'] = this.phaseName;
    data['phase_start'] = this.phaseStart;
    data['phase_end'] = this.phaseEnd;
    data['processor_id'] = this.processorId;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['date_finish'] = this.dateFinish;
    data['progress'] = this.progress;
    data['time_new'] = this.time;
    data['time_type'] = this.timeType;
    data['department_id'] = this.departmentId;
    data['department_name'] = this.departmentName;
    if (this.staff != null) {
      data['staff'] = this.staff!.toJson();
    }
    data['comment'] = this.comment;
    return data;
  }
}

class Staff {
  int? staffId;
  String? fullName;
  String? staffAvatar;
  String? phone1;
  String? email;
  String? staffType;

  Staff(
      {this.staffId,
        this.fullName,
        this.staffAvatar,
        this.phone1,
        this.email,
        this.staffType});

  Staff.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    fullName = json['full_name'];
    staffAvatar = json['staff_avatar'];
    phone1 = json['phone1'];
    email = json['email'];
    staffType = json['staff_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['full_name'] = this.fullName;
    data['staff_avatar'] = this.staffAvatar;
    data['phone1'] = this.phone1;
    data['email'] = this.email;
    data['staff_type'] = this.staffType;
    return data;
  }
}

class PhaseStatusModel {
  String? statusId;
  String? statusName;
  bool isSelected;

  PhaseStatusModel({this.statusId, this.statusName, this.isSelected = false});
}

class JobFilterModel {
  PhaseStatus?  status;
  String? dateFromStart;
  String? dateToEnd;
  String? dateFromEnd;
  String? dateToStart;

  JobFilterModel({this.status, this.dateFromStart, this.dateToEnd, this.dateFromEnd, this.dateToStart});
}