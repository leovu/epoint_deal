import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';
import 'package:epoint_deal_plugin/model/request/booking_store_request_model.dart';
import 'package:epoint_deal_plugin/model/response/other_free_branch_response_model.dart';

class UpdateDealModelRequest {
  String? dealCode;
  int? dealId;
  String? dealName;
  String? phone;
  int? saleId;
  String? typeCustomer;
  String? pipelineCode;
  String? journeyCode;
  String? closingDate;
  List<int?>? tag;
  int? orderSourceId;
  num? probability;
  String? dealDescription;
  String? customerCode;
  String? branchCode;
  num? amount;
  num? discount;
  List<Product>? product;

  num? total;
  num? discountMember;
  String? discountType;
  num? discountValue;
  String? voucherCode;
  num? totalOtherFee;
  num? amountBeforeVat;
  num? vatValue;
  num? vatDeal;
  num? expectedRevenue;
  List<OrderFeeModel>? otherFee;

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
      this.product,
      this.discount,
      this.amountBeforeVat,
      this.discountMember,
      this.discountType,
      this.discountValue,
      this.voucherCode,
      this.total,
      this.totalOtherFee,
      this.vatValue,
      this.vatDeal,
      this.expectedRevenue,
      this.otherFee,
      this.customerCode,
      this.branchCode,
      this.dealId});
      

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
        product!.add(new Product.fromJson(v));
      });
    }
    discount = json['discount'];
    
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
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    data["deal_id"] = dealId;
    data["discount"] = discount;
    data["amount"] = amount;
    data['total'] = this.total;
    data['discount_member'] = this.discountMember;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['voucher_code'] = this.voucherCode;
    data['total_other_fee'] = this.totalOtherFee;
    data['amount_before_vat'] = this.amountBeforeVat;
    data['vat_value'] = this.vatValue;
    data['vat_deal'] = this.vatDeal;
    data['expected_revenue'] = this.expectedRevenue;
    if (this.otherFee != null) {
      data['other_fee'] = this.otherFee!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

