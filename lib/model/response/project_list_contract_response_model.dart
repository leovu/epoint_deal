class ProjectListContractResponseModel {  List<ProjectContractModel>? data;  ProjectListContractResponseModel({this.data});  ProjectListContractResponseModel.fromJson(List<dynamic>? json) {    if (json != null) {      data = <ProjectContractModel>[];      json.forEach((v) {        data!.add(new ProjectContractModel.fromJson(v));      });    }  }  Map<String, dynamic> toJson() {    final Map<String, dynamic> data = new Map<String, dynamic>();    if (this.data != null) {      data['Data'] = this.data!.map((v) => v.toJson()).toList();    }    return data;  }}class ProjectContractModel {  int?  contractId;  int?  contractCategoryId;  String?  contractName;  String?  contractCode;  String?  contractNo;  String?  contractForm;  String?  signDate;  int?  performerBy;  String?  effectiveDate;  String?  expiredDate;  int?  isRenew;  int?  numberDayRenew;  int?  isCreatedTicket;  String?  statusCodeCreatedTicket;  String?  warrantyStartDate;  String?  warrantyEndDate;  String?  content;  String?  note;  String?  statusCode;  int?  isValueGoods;  String?  ticketCode;  String?  reasonRemove;  int?  createdBy;  String?  createdAt;  bool? isSelected;  ProjectContractModel(      {this.contractId,        this.contractCategoryId,        this.contractName,        this.contractCode,        this.contractNo,        this.contractForm,        this.signDate,        this.performerBy,        this.effectiveDate,        this.expiredDate,        this.isRenew,        this.numberDayRenew,        this.isCreatedTicket,        this.statusCodeCreatedTicket,        this.warrantyStartDate,        this.warrantyEndDate,        this.content,        this.note,        this.statusCode,        this.isValueGoods,        this.ticketCode,        this.reasonRemove,        this.createdBy,        this.createdAt, this.isSelected = false});  ProjectContractModel.fromJson(Map<String, dynamic> json) {    contractId = json['contract_id'];    contractCategoryId = json['contract_category_id'];    contractName = json['contract_name'];    contractCode = json['contract_code'];    contractNo = json['contract_no'];    contractForm = json['contract_form'];    signDate = json['sign_date'];    performerBy = json['performer_by'];    effectiveDate = json['effective_date'];    expiredDate = json['expired_date'];    isRenew = json['is_renew'];    numberDayRenew = json['number_day_renew'];    isCreatedTicket = json['is_created_ticket'];    statusCodeCreatedTicket = json['status_code_created_ticket'];    warrantyStartDate = json['warranty_start_date'];    warrantyEndDate = json['warranty_end_date'];    content = json['content'];    note = json['note'];    statusCode = json['status_code'];    isValueGoods = json['is_value_goods'];    ticketCode = json['ticket_code'];    reasonRemove = json['reason_remove'];    createdBy = json['created_by'];    createdAt = json['created_at'];    isSelected = false;  }  Map<String, dynamic> toJson() {    final Map<String, dynamic> data = new Map<String, dynamic>();    data['contract_id'] = this.contractId;    data['contract_category_id'] = this.contractCategoryId;    data['contract_name'] = this.contractName;    data['contract_code'] = this.contractCode;    data['contract_no'] = this.contractNo;    data['contract_form'] = this.contractForm;    data['sign_date'] = this.signDate;    data['performer_by'] = this.performerBy;    data['effective_date'] = this.effectiveDate;    data['expired_date'] = this.expiredDate;    data['is_renew'] = this.isRenew;    data['number_day_renew'] = this.numberDayRenew;    data['is_created_ticket'] = this.isCreatedTicket;    data['status_code_created_ticket'] = this.statusCodeCreatedTicket;    data['warranty_start_date'] = this.warrantyStartDate;    data['warranty_end_date'] = this.warrantyEndDate;    data['content'] = this.content;    data['note'] = this.note;    data['status_code'] = this.statusCode;    data['is_value_goods'] = this.isValueGoods;    data['ticket_code'] = this.ticketCode;    data['reason_remove'] = this.reasonRemove;    data['created_by'] = this.createdBy;    data['created_at'] = this.createdAt;    return data;  }}