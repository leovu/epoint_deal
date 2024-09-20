import 'package:epoint_deal_plugin/model/request/booking_store_request_model.dart';
import 'package:epoint_deal_plugin/model/response/other_free_branch_response_model.dart';

class AddDealModelRequest {
  String? dealName;
  int? saleId;
  String? typeCustomer;
  String? customerCode;
  String? phone;
  String? pipelineCode;
  String? journeyCode;
  String? closingDate;
  String? branchCode;
  List<int?>? tag;
  int? orderSourceId;
  num? probability;
  String? dealDescription;
  num? amount;
  List<Product>? product;
  num? discount;

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


  AddDealModelRequest(
      {this.dealName,
      this.saleId,
      this.typeCustomer,
      this.customerCode,
      this.phone,
      this.pipelineCode,
      this.journeyCode,
      this.closingDate,
      this.branchCode,
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
      this.otherFee

       });

  AddDealModelRequest.fromJson(Map<String, dynamic> json) {
    dealName = json['deal_name'];
    saleId = json['sale_id'];
    typeCustomer = json['type_customer'];
    customerCode = json['customer_code'];
    phone = json['phone'];
    pipelineCode = json['pipeline_code'];
    journeyCode = json['journey_code'];
    closingDate = json['closing_date'];
    branchCode = json['branch_code'];
    tag = json['tag'].cast<int>();
    orderSourceId = json['order_source_id'];
    probability = json['probability'];
    dealDescription = json['deal_description'];
    amount = json['amount'];
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
    data['deal_name'] = this.dealName;
    data['sale_id'] = this.saleId;
    data['type_customer'] = this.typeCustomer;
    data['customer_code'] = this.customerCode;
    data['phone'] = this.phone;
    data['pipeline_code'] = this.pipelineCode;
    data['journey_code'] = this.journeyCode;
    data['closing_date'] = this.closingDate;
    data['branch_code'] = this.branchCode;
    data['tag'] = this.tag;
    data['order_source_id'] = this.orderSourceId;
    data['probability'] = this.probability;
    data['deal_description'] = this.dealDescription;
    data['amount'] = this.amount;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    data["discount"] = discount;
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

class Product {
  String? objectType;
  String? objectName;
  String? objectCode;
  int? objectId;
  num? quantity;
  num? price;
  num? amount;
  String? note;
  double? discountValue;
  String? discountType;
  double? discount;
  String? voucherCode;
  String? description;
  int? position;
  

  Product(
      {this.objectType,
      this.objectName,
      this.objectCode,
      this.objectId,
      this.quantity,
      this.price,
      this.discountValue,
      this.discountType,
      this.discount,
      this.voucherCode,
      this.amount,
      this.description,
      this.position,
      this.note});

  Product.fromJson(Map<String, dynamic> json) {
   objectType = json['object_type'];
    objectName = json['object_name'];
    objectCode = json['object_code'];
    objectId = json['object_id'];
    quantity = json['quantity'];
    price = json['price'];
    discountValue = json['discount_value'];
    discountType = json['discount_type'];
    discount = json['discount'];
    voucherCode = json['voucher_code'];
    amount = json['amount'];
    description = json['description'];
    position = json['position'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = this.objectType;
    data['object_name'] = this.objectName;
    data['object_code'] = this.objectCode;
    data['object_id'] = this.objectId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount_value'] = this.discountValue;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['voucher_code'] = this.voucherCode;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['position'] = this.position;
    data['note'] = this.note;
    return data;
  }
}
