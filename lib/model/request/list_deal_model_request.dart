class ListDealModelRequest {
  String search;
  int page;
  String orderSourceName;
  String branchName;
  String createdAt;
  String closingDate;
  String closingDueDate;
  String pipelineName;
  String journeyName;

  ListDealModelRequest(
      {this.search,
      this.page,
      this.orderSourceName,
      this.branchName,
      this.createdAt,
      this.closingDate,
      this.closingDueDate,
      this.pipelineName,
      this.journeyName});

  ListDealModelRequest.fromJson(Map<String, dynamic> json) {
    search = json['search'];
    page = json['page'];
    orderSourceName = json['order_source_name'];
    branchName = json['branch_name'];
    createdAt = json['created_at'];
    closingDate = json['closing_date'];
    closingDueDate = json['closing_due_date'];
    pipelineName = json['pipeline_name'];
    journeyName = json['journey_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['search'] = this.search;
    data['page'] = this.page;
    data['order_source_name'] = this.orderSourceName;
    data['branch_name'] = this.branchName;
    data['created_at'] = this.createdAt;
    data['closing_date'] = this.closingDate;
    data['closing_due_date'] = this.closingDueDate;
    data['pipeline_name'] = this.pipelineName;
    data['journey_name'] = this.journeyName;
    return data;
  }
}
