class AssignRevokeDealModelRequest {
  String? type;
  String? dealCode;
  int? saleId;
  int? timeRevokeLead;

  AssignRevokeDealModelRequest(
      {this.type, this.dealCode, this.saleId, this.timeRevokeLead});

  AssignRevokeDealModelRequest.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    dealCode = json['deal_code'];
    saleId = json['sale_id'];
    timeRevokeLead = json['time_revoke_lead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['deal_code'] = this.dealCode;
    data['sale_id'] = this.saleId;
    data['time_revoke_lead'] = this.timeRevokeLead;
    return data;
  }
}