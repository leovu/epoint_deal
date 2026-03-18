import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/work_list_tags_response_model.dart';

import 'work_edit_repeat_request_model.dart';

class WorkEditWorkRequestModel {
  int? manageWorkId;
  String? manageWorkTitle;
  int? manageTypeWorkId;
  String? fromDate;
  String? fromTime;
  String? toDate;
  String? toTime;
  int? time;
  String? timeType;
  int? processorId;
  int? approveId;
  double? progress;
  List<WorkListStaffModel>? staffSupport;
  int? parentId;
  String? description;
  int? manageProjectId;
  int? manageProjectPhaseId;
  int? customerId;
  List<WorkListTagsModel>? listTag;
  String? typeCardWork;
  int? priority;
  int? manageStatusId;
  WorkEditRepeatRequestModel? repeatWork;
  String? manageWorkCustomerType;

  WorkEditWorkRequestModel(
      {this.manageWorkId,
        this.manageWorkTitle,
        this.manageTypeWorkId,
        this.fromDate,
        this.fromTime,
        this.toDate,
        this.toTime,
        this.time,
        this.timeType,
        this.processorId,
        this.approveId,
        this.progress,
        this.staffSupport,
        this.parentId,
        this.description,
        this.manageProjectId,
        this.manageProjectPhaseId,
        this.customerId,
        this.listTag,
        this.typeCardWork,
        this.priority,
        this.manageStatusId,
        this.repeatWork,
        this.manageWorkCustomerType});

  WorkEditWorkRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    manageWorkTitle = json['manage_work_title'];
    manageTypeWorkId = json['manage_type_work_id'];
    fromDate = json['from_date'];
    fromTime = json['from_time'];
    toDate = json['to_date'];
    toTime = json['to_time'];
    time = json['time'];
    timeType = json['time_type'];
    processorId = json['processor_id'];
    approveId = json['approve_id'];
    progress = json['progress'];
    if (json['staff_support'] != null) {
      staffSupport = <WorkListStaffModel>[];
      json['staff_support'].forEach((v) {
        staffSupport!.add(new WorkListStaffModel.fromJson(v));
      });
    }
    parentId = json['parent_id'];
    description = json['description'];
    manageProjectId = json['manage_project_id'];
    manageProjectPhaseId = json['manage_project_phase_id'];
    customerId = json['customer_id'];
    if (json['list_tag'] != null) {
      listTag = <WorkListTagsModel>[];
      json['list_tag'].forEach((v) {
        listTag!.add(new WorkListTagsModel.fromJson(v));
      });
    }
    typeCardWork = json['type_card_work'];
    priority = json['priority'];
    manageStatusId = json['manage_status_id'];
    repeatWork = json['repeat_work'] != null
        ? new WorkEditRepeatRequestModel.fromJson(json['repeat_work'])
        : null;
    manageWorkCustomerType = json['manage_work_customer_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['manage_work_title'] = this.manageWorkTitle;
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['from_date'] = this.fromDate;
    data['from_time'] = this.fromTime;
    data['to_date'] = this.toDate;
    data['to_time'] = this.toTime;
    data['time'] = this.time;
    data['time_type'] = this.timeType;
    data['processor_id'] = this.processorId;
    data['approve_id'] = this.approveId;
    data['progress'] = this.progress;
    if (this.staffSupport != null) {
      data['staff_support'] = this.staffSupport!.map((v) => v.toJson()).toList();
    }
    data['parent_id'] = this.parentId;
    data['description'] = this.description;
    data['manage_project_id'] = this.manageProjectId;
    data['manage_project_phase_id'] = this.manageProjectPhaseId;
    data['customer_id'] = this.customerId;
    if (this.listTag != null) {
      data['list_tag'] = this.listTag!.map((v) => v.toJson()).toList();
    }
    data['type_card_work'] = this.typeCardWork;
    data['priority'] = this.priority;
    data['manage_status_id'] = this.manageStatusId;
    if (this.repeatWork != null) {
      data['repeat_work'] = this.repeatWork!.toJson();
    }
    data['manage_work_customer_type'] = this.manageWorkCustomerType;
    return data;
  }
}