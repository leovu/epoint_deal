class ListDealModelRequest {
  String search;
  int page;
  String orderSourceName;
  List<int> branchId;
  String createdAt;
  String closingDate;
  List<int> staffId;
  String closingDueDate;
  List<int> pipelineId;
  List<int> journeyName;
  List<int> manageStatusId;
  String careHistory;

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
      this.journeyName,
      this.manageStatusId,
      this.careHistory});

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
    journeyName = json['journey_name'].cast<int>();
    manageStatusId = json['manage_status_id'].cast<int>();
    careHistory = json['care_history'];
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
    data['journey_name'] = this.journeyName;
    data['manage_status_id'] = this.manageStatusId;
    data['care_history'] = this.careHistory;
    return data;
  }
}
