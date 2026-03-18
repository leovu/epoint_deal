

import 'package:epoint_deal_plugin/model/response/project_list_issue_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_list_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_list_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_report_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_statistical_tab_response_model.dart';
import 'package:epoint_deal_plugin/model/response/project_tags_response_model.dart';

class ProjectInfoResponseModel {

  int? projectId;
  String? projectName;
  String? projectDescribe;
  int? projectStatusId;
  String? projectStatusName;
  String? projectStatusColor;
  int? createdBy;
  String? createdAt;
  String? fromDate;
  String? toDate;
  String? dateFinish;
  String? prefixCode;
  int? isImportant;
  int? budget;
  int? resource;
  int? progress;
  String? permission;
  int? departmentId;
  String? departmentName;
  int? resourceImplement;
  String? importantName;
  Condition? condition;
  int? dateLate;
  int? contractId;
  String? contractCode;
  List<ProjectInfoCustomer>? customer;
  ProjectStaffModel? manager;
  List<ProjectStaffModel>? creator;
  List<ProjectTagsModel>? tag;
  int? document;
  int? member;
  int? work;
  int? projectRiskId;
  String? projectRiskName;
  ProjectStatisticalTabResponseModel? statisticalProject;
  ProjectReportResponseModel? reportProject;
  ProjectListIssueResponseModel? issueProject;


  ProjectInfoResponseModel(
      {this.projectId,
        this.projectName,
        this.projectDescribe,
        this.projectStatusId,
        this.projectStatusName,
        this.projectStatusColor,
        this.createdBy,
        this.createdAt,
        this.fromDate,
        this.toDate,
        this.dateFinish,
        this.prefixCode,
        this.isImportant,
        this.budget,
        this.resource,
        this.progress,
        this.permission,
        this.departmentId,
        this.departmentName,
        this.contractId,
        this.contractCode,
        this.resourceImplement,
        this.importantName,
        this.condition,
        this.dateLate,
        this.customer,
        this.manager,
        this.creator,
        this.tag,
        this.document,
        this.member,
        this.work,
        this.projectRiskId,
        this.projectRiskName});

  ProjectInfoResponseModel.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    projectDescribe = json['project_describe'];
    projectStatusId = json['project_status_id'];
    projectStatusName = json['project_status_name'];
    projectStatusColor = json['project_status_color'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    dateFinish = json['date_finish'];
    prefixCode = json['prefix_code'];
    isImportant = json['is_important'];
    budget = json['budget'];
    resource = json['resource'];
    progress = json['progress'];
    permission = json['permission'];
    departmentId = json['department_id'];
    departmentName = json['department_name'];
    resourceImplement = json['resource_implement'];
    importantName = json['important_name'];
    contractId = json['contract_id'];
    contractCode = json['contract_code'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    dateLate = json['date_late'];
    if (json['customer'] != null) {
      customer = <ProjectInfoCustomer>[];
      json['customer'].forEach((v) {
        customer!.add(new ProjectInfoCustomer.fromJson(v));
      });
    }
    manager =
    json['manager_new'] != null ? new ProjectStaffModel.fromJson(json['manager_new']) : null;
    if (json['creator_new'] != null) {
      creator = <ProjectStaffModel>[];
      json['creator_new'].forEach((v) {
        creator!.add(new ProjectStaffModel.fromJson(v));
      });
    }
    if (json['tag'] != null) {
      tag = <ProjectTagsModel>[];
      json['tag'].forEach((v) {
        tag!.add(new ProjectTagsModel.fromJson(v));
      });
    }
    document = json['document'];
    member = json['member'];
    work = json['work'];
    projectRiskId = json['project_risk_id'];
    projectRiskName = json['project_risk_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['project_describe'] = this.projectDescribe;
    data['project_status_id'] = this.projectStatusId;
    data['project_status_name'] = this.projectStatusName;
    data['project_status_color'] = this.projectStatusColor;
    data['created_by'] = this.createdBy;
    data['created_at'] = this.createdAt;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['date_finish'] = this.dateFinish;
    data['prefix_code'] = this.prefixCode;
    data['is_important'] = this.isImportant;
    data['budget'] = this.budget;
    data['resource'] = this.resource;
    data['progress'] = this.progress;
    data['permission'] = this.permission;
    data['department_id'] = this.departmentId;
    data['department_name'] = this.departmentName;
    data['contract_id'] = this.contractId;
    data['contract_code'] = this.contractCode;
    data['resource_implement'] = this.resourceImplement;
    data['important_name'] = this.importantName;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    data['date_late'] = this.dateLate;
    if (this.customer != null) {
      data['customer'] = this.customer!.map((v) => v.toJson()).toList();
    }
    if (this.manager != null) {
      data['manager_new'] = this.manager!.toJson();
    }
    if (this.creator != null) {
      data['creator_new'] = this.creator!.map((v) => v.toJson()).toList();
    }
    if (this.tag != null) {
      data['tag'] = this.tag!.map((v) => v.toJson()).toList();
    }
    data['document'] = this.document;
    data['member'] = this.member;
    data['work'] = this.work;
    data['project_risk_id'] = this.projectRiskId;
    data['project_risk_name'] = this.projectRiskName;
    return data;
  }
}
class ProjectInfoCustomer {
  int? customerId;
  String? customerName;
  String? customerAvatar;
  String? gender;
  String? phone;
  String? email;
  String? customerType;

  ProjectInfoCustomer(
      {this.customerId,
        this.customerName,
        this.customerAvatar,
        this.gender,
        this.phone,
        this.email,
        this.customerType});

  ProjectInfoCustomer.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    customerName = json['customer_name'];
    customerAvatar = json['customer_avatar'];
    gender = json['gender'];
    phone = json['phone'];
    email = json['email'];
    customerType = json['customer_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['customer_name'] = this.customerName;
    data['customer_avatar'] = this.customerAvatar;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['customer_type'] = this.customerType;
    return data;
  }
}

