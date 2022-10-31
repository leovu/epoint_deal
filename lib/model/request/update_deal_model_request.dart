import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';

class UpdateDealModelRequest {
  String dealCode;
  String dealName;
  String phone;
  int saleId;
  String typeCustomer;
  String pipelineCode;
  String journeyCode;
  String closingDate;
  List<int> tag;
  int orderSourceId;
  num probability;
  String dealDescription;
  String customerCode;
  String branchCode;
  num amount;


  List<Product> product;

  UpdateDealModelRequest(
      {this.dealCode,
      this.dealName,
      this.phone,
      this.saleId,
      this.typeCustomer,
      this.pipelineCode,
      this.journeyCode,
      this.closingDate,
      this.tag,
      this.orderSourceId,
      this.probability,
      this.dealDescription,
      this.amount,
      this.customerCode,
      this.branchCode,
      this.product});

  UpdateDealModelRequest.fromJson(Map<String, dynamic> json) {
    dealCode = json['deal_code'];
    dealName = json['deal_name'];
    phone = json['phone'];
    saleId = json['sale_id'];
    typeCustomer = json['type_customer'];
    pipelineCode = json['pipeline_code'];
    journeyCode = json['journey_code'];
    closingDate = json['closing_date'];
    tag = json['tag'].cast<int>();
    orderSourceId = json['order_source_id'];
    probability = json['probability'];
    dealDescription = json['deal_description'];
    amount = json['amount'];
    customerCode = json['customer_code'];
    branchCode = json['branch_code'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_code'] = this.dealCode;
    data['deal_name'] = this.dealName;
    data['phone'] = this.phone;
    data['sale_id'] = this.saleId;
    data['type_customer'] = this.typeCustomer;
    data['pipeline_code'] = this.pipelineCode;
    data['journey_code'] = this.journeyCode;
    data['closing_date'] = this.closingDate;
    data['tag'] = this.tag;
    data['order_source_id'] = this.orderSourceId;
    data['probability'] = this.probability;
    data['deal_description'] = this.dealDescription;
    data['customer_code'] = this.customerCode;
    data['branch_code'] = this.branchCode;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

