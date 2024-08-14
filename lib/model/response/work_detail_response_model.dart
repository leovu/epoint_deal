import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';

import 'work_list_status_response_model.dart';
import 'work_list_tags_response_model.dart';

class WorkDetailResponseModel {
  int? manageWorkId;
  String? manageWorkTitle;
  int? parentId;
  double? progress;
  String? parentName;
  int? processorId;
  String? processorName;
  String? processorAvatar;
  int? assignorId;
  String? assignorName;
  String? assignorAvatar;
  String? dateEnd;
  String? dateStart;
  String? description;
  List<WorkListStaffModel>? staffSupport;
  String? dateFinish;
  int? manageProjectId;
  String? manageProjectName;
  int? manageProjectPhaseId;
  String? manageProjectPhaseName;
  int? manageTypeWorkId;
  String? manageTypeWorkName;
  String? manageTypeWorkIcon;
  int? priority;
  String? priorityName;
  String? typeCardWork;
  String? typeCardWorkName;
  String? repeatType;
  String? repeatEnd;
  int? repeatEndTime;
  String? repeatEndType;
  String? repeatEndFullTime;
  String? repeatTime;
  List<WorkDetailRepeatModel>? listRepeat;
  int? approveId;
  String? approveName;
  String? approveAvatar;
  int? isApprove;
  int? manageStatusId;
  String? manageStatusName;
  String? manageStatusColor;
  List<WorkListTagsModel>? tags;
  int? time;
  String? timeType;
  int? customerId;
  String? customerName;
  List<WorkListStatusModel>? listStatus;
  int? isEdit;
  int? isDeleted;
  String? manageWorkCustomerType;
  String? manageWorkCustomerTypeTitle;
  int? totalChildJob;
  String? createObjectType;
  int? createObjectId;
  String? createObjectCode;
  String? createObjectName;
  int? daysOverdue;

  WorkDetailResponseModel(
      {this.manageWorkId,
        this.manageWorkTitle,
        this.parentId,
        this.progress,
        this.parentName,
        this.processorId,
        this.processorName,
        this.processorAvatar,
        this.assignorId,
        this.assignorName,
        this.assignorAvatar,
        this.dateEnd,
        this.dateStart,
        this.description,
        this.staffSupport,
        this.dateFinish,
        this.manageProjectId,
        this.manageProjectName,
        this.manageProjectPhaseId,
        this.manageProjectPhaseName,
        this.manageTypeWorkId,
        this.manageTypeWorkName,
        this.manageTypeWorkIcon,
        this.priority,
        this.priorityName,
        this.typeCardWork,
        this.typeCardWorkName,
        this.repeatType,
        this.repeatEnd,
        this.repeatEndTime,
        this.repeatEndType,
        this.repeatEndFullTime,
        this.repeatTime,
        this.listRepeat,
        this.approveId,
        this.approveName,
        this.approveAvatar,
        this.isApprove,
        this.manageStatusId,
        this.manageStatusName,
        this.manageStatusColor,
        this.tags,
        this.time,
        this.timeType,
        this.customerId,
        this.customerName,
        this.listStatus,
        this.isEdit,
        this.isDeleted,
        this.manageWorkCustomerType,
        this.manageWorkCustomerTypeTitle,
        this.totalChildJob,
        this.createObjectType,
        this.createObjectId,
        this.createObjectCode,
        this.createObjectName,
        this.daysOverdue});

  WorkDetailResponseModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    manageWorkTitle = json['manage_work_title'];
    parentId = json['parent_id'];
    progress = json['progress'] == null? null: double.tryParse(json['progress'].toString());
    parentName = json['parent_name'];
    processorId = json['processor_id'];
    processorName = json['processor_name'];
    processorAvatar = json['processor_avatar'];
    assignorId = json['assignor_id'];
    assignorName = json['assignor_name'];
    assignorAvatar = json['assignor_avatar'];
    dateEnd = json['date_end'];
    dateStart = json['date_start'];
    description = json['description'];
    if (json['staff_support'] != null) {
      staffSupport = <WorkListStaffModel>[];
      json['staff_support'].forEach((v) {
        staffSupport!.add(new WorkListStaffModel.fromJson(v));
      });
    }
    dateFinish = json['date_finish'];
    manageProjectId = json['manage_project_id'];
    manageProjectName = json['manage_project_name'];
    manageProjectPhaseId = json['manage_project_phase_id'];
    manageProjectPhaseName = json['manage_project_phase_name'];
    manageTypeWorkId = json['manage_type_work_id'];
    manageTypeWorkName = json['manage_type_work_name'];
    manageTypeWorkIcon = json['manage_type_work_icon'];
    priority = json['priority'];
    priorityName = json['priority_name'];
    typeCardWork = json['type_card_work'];
    typeCardWorkName = json['type_card_work_name'];
    repeatType = json['repeat_type'];
    repeatEnd = json['repeat_end'];
    repeatEndTime = json['repeat_end_time'];
    repeatEndType = json['repeat_end_type'];
    repeatEndFullTime = json['repeat_end_full_time'];
    repeatTime = json['repeat_time'];
    if (json['list_repeat'] != null) {
      listRepeat = <WorkDetailRepeatModel>[];
      json['list_repeat'].forEach((v) {
        listRepeat!.add(new WorkDetailRepeatModel.fromJson(v));
      });
    }
    approveId = json['approve_id'];
    approveName = json['approve_name'];
    approveAvatar = json['approve_avatar'];
    isApprove = json['is_approve'];
    manageStatusId = json['manage_status_id'];
    manageStatusName = json['manage_status_name'];
    manageStatusColor = json['manage_status_color'];
    if (json['tags'] != null) {
      tags = <WorkListTagsModel>[];
      json['tags'].forEach((v) {
        tags!.add(new WorkListTagsModel.fromJson(v));
      });
    }
    time = json['time'];
    timeType = json['time_type'];
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    if (json['list_status'] != null) {
      listStatus = <WorkListStatusModel>[];
      json['list_status'].forEach((v) {
        listStatus!.add(new WorkListStatusModel.fromJson(v));
      });
    }
    isEdit = json['is_edit'];
    isDeleted = json['is_deleted'];
    manageWorkCustomerType = json['manage_work_customer_type'];
    manageWorkCustomerTypeTitle = json['manage_work_customer_type_title'];
    totalChildJob = json['total_child_job'];
    createObjectType = json['create_object_type'];
    createObjectId = json['create_object_id'];
    createObjectCode = json['create_object_code'];
    createObjectName = json['create_object_name'];
    daysOverdue = json['days_overdue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['manage_work_title'] = this.manageWorkTitle;
    data['parent_id'] = this.parentId;
    data['progress'] = this.progress;
    data['parent_name'] = this.parentName;
    data['processor_id'] = this.processorId;
    data['processor_name'] = this.processorName;
    data['processor_avatar'] = this.processorAvatar;
    data['assignor_id'] = this.assignorId;
    data['assignor_name'] = this.assignorName;
    data['assignor_avatar'] = this.assignorAvatar;
    data['date_end'] = this.dateEnd;
    data['date_start'] = this.dateStart;
    data['description'] = this.description;
    if (this.staffSupport != null) {
      data['staff_support'] = this.staffSupport!.map((v) => v.toJson()).toList();
    }
    data['date_finish'] = this.dateFinish;
    data['manage_project_id'] = this.manageProjectId;
    data['manage_project_name'] = this.manageProjectName;
    data['manage_project_phase_id'] = this.manageProjectPhaseId;
    data['manage_project_phase_name'] = this.manageProjectPhaseName;
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['manage_type_work_name'] = this.manageTypeWorkName;
    data['manage_type_work_icon'] = this.manageTypeWorkIcon;
    data['priority'] = this.priority;
    data['priority_name'] = this.priorityName;
    data['type_card_work'] = this.typeCardWork;
    data['type_card_work_name'] = this.typeCardWorkName;
    data['repeat_type'] = this.repeatType;
    data['repeat_end'] = this.repeatEnd;
    data['repeat_end_time'] = this.repeatEndTime;
    data['repeat_end_type'] = this.repeatEndType;
    data['repeat_end_full_time'] = this.repeatEndFullTime;
    data['repeat_time'] = this.repeatTime;
    if (this.listRepeat != null) {
      data['list_repeat'] = this.listRepeat!.map((v) => v.toJson()).toList();
    }
    data['approve_id'] = this.approveId;
    data['approve_name'] = this.approveName;
    data['approve_avatar'] = this.approveAvatar;
    data['is_approve'] = this.isApprove;
    data['manage_status_id'] = this.manageStatusId;
    data['manage_status_name'] = this.manageStatusName;
    data['manage_status_color'] = this.manageStatusColor;
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    data['time'] = this.time;
    data['time_type'] = this.timeType;
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    if (this.listStatus != null) {
      data['list_status'] = this.listStatus!.map((v) => v.toJson()).toList();
    }
    data['is_edit'] = this.isEdit;
    data['is_deleted'] = this.isDeleted;
    data['manage_work_customer_type'] = this.manageWorkCustomerType;
    data['manage_work_customer_type_title'] = this.manageWorkCustomerTypeTitle;
    data['total_child_job'] = this.totalChildJob;
    data['create_object_type'] = this.createObjectType;
    data['create_object_id'] = this.createObjectId;
    data['create_object_code'] = this.createObjectCode;
    data['create_object_name'] = this.createObjectName;
    data['days_overdue'] = this.daysOverdue;
    return data;
  }
}

class WorkDetailRepeatModel {
  int? time;

  WorkDetailRepeatModel({this.time});

  WorkDetailRepeatModel.fromJson(Map<String, dynamic> json) {
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    return data;
  }
}