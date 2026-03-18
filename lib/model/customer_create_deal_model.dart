class CustomerCreateDealModel {
  int? saleId;
  String? phone;
  String? fullName;
  String? customerType;
  String? customerLeadCode;
  List<CustomerCreateDealTagModel>? tag;

  CustomerCreateDealModel(
      {this.saleId,
      this.phone,
      this.fullName,
      this.customerType,
      this.customerLeadCode,
      this.tag});

  CustomerCreateDealModel.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    phone = json['phone'];
    fullName = json['full_name'];
    customerType = json['customer_type'];
    customerLeadCode = json['customer_lead_code'];
    if (json['tag'] != null) {
      tag = <CustomerCreateDealTagModel>[];
      json['tag'].forEach((v) {
        tag!.add(new CustomerCreateDealTagModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['customer_type'] = this.customerType;
    data['customer_lead_code'] = this.customerLeadCode;
    if (this.tag != null) {
      data['tag'] = this.tag!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerCreateDealTagModel {
  int? tagId;
  String? keyword;
  String? name;

  CustomerCreateDealTagModel({this.tagId, this.keyword, this.name});

  CustomerCreateDealTagModel.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    keyword = json['keyword'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['keyword'] = this.keyword;
    data['name'] = this.name;
    return data;
  }
}
