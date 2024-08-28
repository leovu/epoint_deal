class ListDealModelRequest {
  String? search;
  int? page;
  String? orderSourceName;
  List<int?>? branchId;
  String? createdAt;
  String? closingDate;
  List<int?>? staffId;
  String? closingDueDate;
  List<int?>? pipelineId;
  List<int?>? journey_id;
  List<int?>? manageStatusId;
  String? careHistory;
  int? isConvert;


  ListDealModelRequest(
      {this.search,
      this.page,
      this.orderSourceName,
      this.branchId,
      this.createdAt,
      this.closingDate,
      this.staffId,
      this.closingDueDate,
      this.pipelineId,
      this.journey_id,
      this.manageStatusId,
      this.careHistory,
      this.isConvert});

  ListDealModelRequest.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    page = json['page'];
    orderSourceName = json['order_source_name'];
    branchId = json['branch_id'].cast<int>();
    createdAt = json['created_at'];
    closingDate = json['closing_date'];
    staffId = json['staff_id'].cast<int>();
    closingDueDate = json['closing_due_date'];
    pipelineId = json['pipeline_id'].cast<int>();
    journey_id = json['journey_id'].cast<int>();
    manageStatusId = json['manage_status_id'].cast<int>();
    careHistory = json['care_history'];
    isConvert = json['is_convert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['page'] = this.page;
    data['order_source_name'] = this.orderSourceName;
    data['branch_id'] = this.branchId;
    data['created_at'] = this.createdAt;
    data['closing_date'] = this.closingDate;
    data['staff_id'] = this.staffId;
    data['closing_due_date'] = this.closingDueDate;
    data['pipeline_id'] = this.pipelineId;
    data['journey_id'] = this.journey_id;
    data['manage_status_id'] = this.manageStatusId;
    data['care_history'] = this.careHistory;
    data['is_convert'] = this.isConvert;
    return data;
  }
}
