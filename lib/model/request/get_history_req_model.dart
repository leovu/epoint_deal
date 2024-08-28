class GetHistoryReqModel {
  String? deal_code;

  GetHistoryReqModel({this.deal_code});

  GetHistoryReqModel.fromJson(Map<String, dynamic> json) {
    deal_code = json['deal_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_code'] = this.deal_code;
    return data;
  }
}

class GetCareDealModel {
  int? deal_id;

  GetCareDealModel({this.deal_id});

  GetCareDealModel.fromJson(Map<String, dynamic> json) {
    deal_id = json['deal_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_id'] = this.deal_id;
    return data;
  }
}

class GetListNoteModel {
  int? customer_deal_id;
  int? page;
  String? brandCode;
  GetListNoteModel({this.customer_deal_id, this.page, this.brandCode});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_deal_id'] = this.customer_deal_id;
    if (this.page != null) {
      data['page'] = this.page;
    }

    if (this.brandCode != null) {
      data['brand_code'] = this.brandCode;
    }
    return data;
  }
}

class CreateNoteReqModel {
  int? customer_deal_id;
  String? content;
  CreateNoteReqModel({this.customer_deal_id, this.content});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_deal_id'] = this.customer_deal_id;
    data['content'] = this.content;

    return data;
  }
}
