class ListDealModelResponse {
  int errorCode;
  String errorDescription;
  ListDealData data;

  ListDealModelResponse({this.errorCode, this.errorDescription, this.data});

  ListDealModelResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    data = json['Data'] != null ? new ListDealData.fromJson(json['Data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data.toJson();
    }
    return data;
  }
}

class ListDealData {
  PageInfo pageInfo;
  List<DealItems> items;

  ListDealData({this.pageInfo, this.items});

  ListDealData.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfo.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <DealItems>[];
      json['Items'].forEach((v) {
        items.add(new DealItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PageInfo {
  int total;
  int itemPerPage;
  int from;
  int to;
  int currentPage;
  int firstPage;
  int lastPage;
  int previousPage;
  int nextPage;
  List<int> pageRange;

  PageInfo(
      {this.total,
      this.itemPerPage,
      this.from,
      this.to,
      this.currentPage,
      this.firstPage,
      this.lastPage,
      this.previousPage,
      this.nextPage,
      this.pageRange});

  PageInfo.fromJson(Map<String, dynamic> json) {
    total = json['total'] ?? 0 ;
    itemPerPage = json['itemPerPage'] ?? 10;
    from = json['from'] ?? 0;
    to = json['to'] ?? 0;
    currentPage = json['currentPage'] ?? 1;
    firstPage = json['firstPage'] ?? 1;
    lastPage = json['lastPage'] ?? 0;
    previousPage = json['previousPage'] ?? 0;
    nextPage = json['nextPage'] ?? 1;
    pageRange = json['pageRange']?.cast<int>() ?? [];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['itemPerPage'] = this.itemPerPage;
    data['from'] = this.from;
    data['to'] = this.to;
    data['currentPage'] = this.currentPage;
    data['firstPage'] = this.firstPage;
    data['lastPage'] = this.lastPage;
    data['previousPage'] = this.previousPage;
    data['nextPage'] = this.nextPage;
    data['pageRange'] = this.pageRange;
    return data;
  }
}

class DealItems {
  String dealName;
  String phone;
  String createdAt;
  String staffFullName;
  String typeCustomer;
  String customerCode;
  String dealCode;
  String pipelineCode;
  String journeyCode;
  String journeyName;
  String branchCode;
  String branchName;
  String orderSourceName;
  String pipelineName;
  String customerName;

  DealItems(
      {this.dealName,
      this.phone,
      this.createdAt,
      this.staffFullName,
      this.typeCustomer,
      this.customerCode,
      this.dealCode,
      this.pipelineCode,
      this.journeyCode,
      this.journeyName,
      this.branchCode,
      this.branchName,
      this.orderSourceName,
      this.pipelineName,
      this.customerName});

  DealItems.fromJson(Map<String, dynamic> json) {
    dealName = json['deal_name'];
    phone = json['phone'];
    createdAt = json['created_at'];
    staffFullName = json['staff_full_name'];
    typeCustomer = json['type_customer'];
    customerCode = json['customer_code'];
    dealCode = json['deal_code'];
    pipelineCode = json['pipeline_code'];
    journeyCode = json['journey_code'];
    journeyName = json['journey_name'];
    branchCode = json['branch_code'];
    branchName = json['branch_name'];
    orderSourceName = json['order_source_name'];
    pipelineName = json['pipeline_name'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_name'] = this.dealName;
    data['phone'] = this.phone;
    data['created_at'] = this.createdAt;
    data['staff_full_name'] = this.staffFullName;
    data['type_customer'] = this.typeCustomer;
    data['customer_code'] = this.customerCode;
    data['deal_code'] = this.dealCode;
    data['pipeline_code'] = this.pipelineCode;
    data['journey_code'] = this.journeyCode;
    data['journey_name'] = this.journeyName;
    data['branch_code'] = this.branchCode;
    data['branch_name'] = this.branchName;
    data['order_source_name'] = this.orderSourceName;
    data['pipeline_name'] = this.pipelineName;
    data['customer_name'] = this.customerName;
    return data;
  }
}