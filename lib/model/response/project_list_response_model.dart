

import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:epoint_deal_plugin/model/response/project_tags_response_model.dart';

class ProjectListResponseModel {
  PageInfoModel? pageInfo;
  List<ProjectListModel>? items;

  ProjectListResponseModel({this.pageInfo, this.items});

  ProjectListResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <ProjectListModel>[];
      json['Items'].forEach((v) {
        items!.add(new ProjectListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProjectListModel {
  int?  projectId;
  String?  projectName;
  int?  projectStatusId;
  String?  projectStatusName;
  String?  projectStatusColor;
  String?  fromDate;
  String?  toDate;
  String?  dateFinish;
  int?  isActive;
  int?  isImportant;
  int?  budget;
  int?  resourceTotal;
  int?  progress;
  String?  importantName;
  int?  resourceImplement;
  Condition?  condition;
  List<ProjectTagsModel>?  tag;
  List<ManagerProject>?  manager;
  List<CustomerProject>?  customer;
  int?  work;
  int?  document;
  int?  member;
  int?  projectRiskId;
  String?  projectRiskName;

  ProjectListModel(
      {this.projectId,
        this.projectName,
        this.projectStatusId,
        this.projectStatusName,
        this.projectStatusColor,
        this.fromDate,
        this.toDate,
        this.dateFinish,
        this.isActive,
        this.isImportant,
        this.budget,
        this.resourceTotal,
        this.progress,
        this.importantName,
        this.resourceImplement,
        this.condition,
        this.tag,
        this.manager,
        this.customer,
        this.work,
        this.document,
        this.member,
        this.projectRiskId,
        this.projectRiskName});

  ProjectListModel.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    projectName = json['project_name'];
    projectStatusId = json['project_status_id'];
    projectStatusName = json['project_status_name'];
    projectStatusColor = json['project_status_color'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    dateFinish = json['date_finish'];
    isActive = json['is_active'];
    isImportant = json['is_important'];
    budget = json['budget'];
    resourceTotal = json['resource_total'];
    progress = json['progress'];
    importantName = json['important_name'];
    resourceImplement = json['resource_implement'];
    condition = json['condition'] != null
        ? new Condition.fromJson(json['condition'])
        : null;
    if (json['tag'] != null) {
      tag = <ProjectTagsModel>[];
      json['tag'].forEach((v) {
        tag!.add(new ProjectTagsModel.fromJson(v));
      });
    }
    if (json['manager'] != null) {
      manager = <ManagerProject>[];
      json['manager'].forEach((v) {
        manager!.add(new ManagerProject.fromJson(v));
      });
    }
    if (json['customer'] != null) {
      customer = <CustomerProject>[];
      json['customer'].forEach((v) {
        customer!.add(new CustomerProject.fromJson(v));
      });
    }
    work = json['work'];
    document = json['document'];
    member = json['member'];
    projectRiskId = json['project_risk_id'];
    projectRiskName = json['project_risk_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['project_name'] = this.projectName;
    data['project_status_id'] = this.projectStatusId;
    data['project_status_name'] = this.projectStatusName;
    data['project_status_color'] = this.projectStatusColor;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['date_finish'] = this.dateFinish;
    data['is_active'] = this.isActive;
    data['is_important'] = this.isImportant;
    data['budget'] = this.budget;
    data['resource_total'] = this.resourceTotal;
    data['progress'] = this.progress;
    data['important_name'] = this.importantName;
    data['resource_implement'] = this.resourceImplement;
    if (this.condition != null) {
      data['condition'] = this.condition!.toJson();
    }
    if (this.tag != null) {
      data['tag'] = this.tag!.map((v) => v.toJson()).toList();
    }
    if (this.manager != null) {
      data['manager'] = this.manager!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.map((v) => v.toJson()).toList();
    }
    data['work'] = this.work;
    data['document'] = this.document;
    data['member'] = this.member;
    data['project_risk_id'] = this.projectRiskId;
    data['project_risk_name'] = this.projectRiskName;
    return data;
  }
}

class ManagerProject {
  int? managerId;
  String? managerName;
  String? managerAvatar;
  String? phone;
  String? email;
  String? staffType;

  ManagerProject(
      {this.managerId,
        this.managerName,
        this.managerAvatar,
        this.phone,
        this.email,
        this.staffType});

  ManagerProject.fromJson(Map<String, dynamic> json) {
    managerId = json['manager_id'];
    managerName = json['manager_name'];
    managerAvatar = json['manager_avatar'];
    phone = json['phone'];
    email = json['email'];
    staffType = json['staff_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manager_id'] = this.managerId;
    data['manager_name'] = this.managerName;
    data['manager_avatar'] = this.managerAvatar;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['staff_type'] = this.staffType;
    return data;
  }
}

class CustomerProject {
  int? customerId;
  String? customerName;
  String? customerAvatar;
  String? gender;
  String? phone;
  String? email;
  String? customerType;

  CustomerProject(
      {this.customerId,
        this.customerName,
        this.customerAvatar,
        this.gender,
        this.phone,
        this.email,
        this.customerType});

  CustomerProject.fromJson(Map<String, dynamic> json) {
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

class Condition {
  String? conditionColor;
  String? conditionName;

  Condition({this.conditionColor, this.conditionName});

  Condition.fromJson(Map<String, dynamic> json) {
    conditionColor = json['condition_color'];
    conditionName = json['condition_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['condition_color'] = this.conditionColor;
    data['condition_name'] = this.conditionName;
    return data;
  }
}
