class CustomerWorkStoreRequestModel {
  int? manageWorkId;
  String? manageWorkTitle;
  String? manageWorkCustomerType;
  int? manageTypeWorkId;
  int? manageResultId;
  int? processorId;
  int? approveId;
  int? progress;
  String? description;
  int? customerId;
  int? objId;
  int? branchId;
  int? priority;
  int? manageStatusId;
  int? isApproveId;
  String? fromDate;
  String? toDate;
  String? dateFinish;
  List<String>? listDocument;
  CustomerWorkStoreRemindModel? remindWork;

  CustomerWorkStoreRequestModel(
      {this.manageWorkId,
        this.manageWorkTitle,
        this.manageWorkCustomerType,
        this.manageTypeWorkId,
        this.manageResultId,
        this.processorId,
        this.approveId,
        this.progress,
        this.description,
        this.customerId,
        this.objId,
        this.branchId,
        this.priority,
        this.manageStatusId,
        this.isApproveId,
        this.fromDate,
        this.toDate,
        this.dateFinish,
        this.listDocument,
        this.remindWork});

  CustomerWorkStoreRequestModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    manageWorkTitle = json['manage_work_title'];
    manageWorkCustomerType = json['manage_work_customer_type'];
    manageTypeWorkId = json['manage_type_work_id'];
    manageResultId = json['manage_result_id'];
    processorId = json['processor_id'];
    approveId = json['approve_id'];
    progress = json['progress'];
    description = json['description'];
    customerId = json['customer_id'];
    objId = json['obj_id'];
    branchId = json['branch_id'];
    priority = json['priority'];
    manageStatusId = json['manage_status_id'];
    isApproveId = json['is_approve_id'];
    fromDate = json['from_date'];
    toDate = json['to_date'];
    dateFinish = json['date_finish'];
    listDocument = json['list_document'].cast<String>();
    remindWork = json['remind_work'] != null
        ? new CustomerWorkStoreRemindModel.fromJson(json['remind_work'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['manage_work_title'] = this.manageWorkTitle;
    data['manage_work_customer_type'] = this.manageWorkCustomerType;
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['manage_result_id'] = this.manageResultId;
    data['processor_id'] = this.processorId;
    data['approve_id'] = this.approveId;
    data['progress'] = this.progress;
    data['description'] = this.description;
    data['customer_id'] = this.customerId;
    data['obj_id'] = this.objId;
    data['branch_id'] = this.branchId;
    data['priority'] = this.priority;
    data['manage_status_id'] = this.manageStatusId;
    data['is_approve_id'] = this.isApproveId;
    data['from_date'] = this.fromDate;
    data['to_date'] = this.toDate;
    data['date_finish'] = this.dateFinish;
    data['list_document'] = this.listDocument;
    if (this.remindWork != null) {
      data['remind_work'] = this.remindWork!.toJson();
    }
    return data;
  }
}

class CustomerWorkStoreRemindModel {
  String? dateRemind;
  int? time;
  String? timeType;
  String? description;

  CustomerWorkStoreRemindModel({this.dateRemind, this.time, this.timeType, this.description});

  CustomerWorkStoreRemindModel.fromJson(Map<String, dynamic> json) {
    dateRemind = json['date_remind'];
    time = json['time'];
    timeType = json['time_type'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_remind'] = this.dateRemind;
    data['time'] = this.time;
    data['time_type'] = this.timeType;
    data['description'] = this.description;
    return data;
  }
}