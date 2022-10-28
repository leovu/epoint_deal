import 'package:epoint_deal_plugin/model/request/add_deal_model_request.dart';

class DetailDealModelResponse {
  int errorCode;
  String errorDescription;
  DetailDealData data;

  DetailDealModelResponse({this.errorCode, this.errorDescription, this.data});

  DetailDealModelResponse.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    data = json['Data'] != null ? new DetailDealData.fromJson(json['Data']) : null;
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

class DetailDealData {
  int dealId;
  String dealCode;
  String dealName;
  String phone;
  String amount;
  String typeCustomer;
  String customerCode;
  String journeyName;
  String journeyCode;
  String pipelineCode;
  String closingDate;
  String closingDueDate;
  String reasonLoseCode;
  String branchName;
  String orderSourceName;
  List<int> tag;
  String probability;
  String dealDescription;
  int saleId;
  String staffName;
  int timeRevokeLead;
  String createdAt;
  String updatedAt;
  String customerName;
  String customerAvatar;
  String customerEmail;
  String customerGender;
  String province;
  String district;
  String address;
  String backgroundColorJourney;
  String productNameBuy;
  List<JourneyTracking> journeyTracking;
  List<ProductBuy> productBuy;

  DetailDealData(
      {this.dealId,
      this.dealCode,
      this.dealName,
      this.phone,
      this.amount,
      this.typeCustomer,
      this.customerCode,
      this.journeyName,
      this.journeyCode,
      this.pipelineCode,
      this.closingDate,
      this.closingDueDate,
      this.reasonLoseCode,
      this.branchName,
      this.orderSourceName,
      this.tag,
      this.probability,
      this.dealDescription,
      this.saleId,
      this.staffName,
      this.timeRevokeLead,
      this.createdAt,
      this.updatedAt,
      this.customerName,
      this.customerAvatar,
      this.customerEmail,
      this.customerGender,
      this.province,
      this.district,
      this.address,
      this.backgroundColorJourney,
      this.productNameBuy,
      this.journeyTracking,
      this.productBuy});

  DetailDealData.fromJson(Map<String, dynamic> json) {
    dealId = json['deal_id'];
    dealCode = json['deal_code'];
    dealName = json['deal_name'];
    phone = json['phone'];
    amount = json['amount'];
    typeCustomer = json['type_customer'];
    customerCode = json['customer_code'];
    journeyName = json['journey_name'];
    journeyCode = json['journey_code'];
    pipelineCode = json['pipeline_code'];
    closingDate = json['closing_date'];
    closingDueDate = json['closing_due_date'];
    reasonLoseCode = json['reason_lose_code'];
    branchName = json['branch_name'];
    orderSourceName = json['order_source_name'];
    tag = json['tag']?.cast<int>() ?? [];
    probability = json['probability'];
    dealDescription = json['deal_description'];
    saleId = json['sale_id'];
    staffName = json['staff_name'];
    timeRevokeLead = json['time_revoke_lead'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerName = json['customer_name'];
    customerAvatar = json['customer_avatar'];
    customerEmail = json['customer_email'];
    customerGender = json['customer_gender'];
    province = json['province'];
    district = json['district'];
    backgroundColorJourney = json['background_color_journey'];
    district = json['district'];
    productNameBuy = json['product_name_buy'];
    if (json['journey_tracking'] != null) {
      journeyTracking = <JourneyTracking>[];
      json['journey_tracking'].forEach((v) {
        journeyTracking.add(new JourneyTracking.fromJson(v));
      });
    }
    if (json['product_buy'] != null) {
      productBuy = <ProductBuy>[];
      json['product_buy'].forEach((v) {
        productBuy.add(ProductBuy.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_id'] = this.dealId;
    data['deal_code'] = this.dealCode;
    data['deal_name'] = this.dealName;
    data['phone'] = this.phone;
    data['amount'] = this.amount;
    data['type_customer'] = this.typeCustomer;
    data['customer_code'] = this.customerCode;
    data['journey_name'] = this.journeyName;
    data['journey_code'] = this.journeyCode;
    data['pipeline_code'] = this.pipelineCode;
    data['closing_date'] = this.closingDate;
    data['closing_due_date'] = this.closingDueDate;
    data['reason_lose_code'] = this.reasonLoseCode;
    data['branch_name'] = this.branchName;
    data['order_source_name'] = this.orderSourceName;
    data['tag'] = this.tag;
    data['probability'] = this.probability;
    data['deal_description'] = this.dealDescription;
    data['sale_id'] = this.saleId;
    data['staff_name'] = this.staffName;
    data['time_revoke_lead'] = this.timeRevokeLead;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_name'] = this.customerName;
    data['customer_avatar'] = this.customerAvatar;
    data['customer_email'] = this.customerEmail;
    data['customer_gender'] = this.customerGender;
    data['province'] = this.province;
    data['district'] = this.district;
    data['address'] = this.address;
    data['background_color_journey'] = this.backgroundColorJourney;
    data['product_name_buy'] = this.productNameBuy;
    if (this.journeyTracking != null) {
      data['journey_tracking'] =
          this.journeyTracking.map((v) => v.toJson()).toList();
    }
    if (this.productBuy != null) {
      data['product_buy'] = this.productBuy.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JourneyTracking {
  String journeyCode;
  int journeyId;
  String journeyName;
  int pipelineId;
  String pipelineCode;
  bool check;

  JourneyTracking(
      {this.journeyCode,
      this.journeyId,
      this.journeyName,
      this.pipelineId,
      this.pipelineCode,
      this.check});

  JourneyTracking.fromJson(Map<String, dynamic> json) {
    journeyCode = json['journey_code'];
    journeyId = json['journey_id'];
    journeyName = json['journey_name'];
    pipelineId = json['pipeline_id'];
    pipelineCode = json['pipeline_code'];
    check = json['check'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['journey_code'] = this.journeyCode;
    data['journey_id'] = this.journeyId;
    data['journey_name'] = this.journeyName;
    data['pipeline_id'] = this.pipelineId;
    data['pipeline_code'] = this.pipelineCode;
    data['check'] = this.check;
    return data;
  }
}

class ProductBuy {
  int dealDetailId;
  int objectId;
  String objectName;
  String objectType;
  double price;
  int quantity;
  int discount;
  double amount;

  ProductBuy(
      {this.dealDetailId,
      this.objectId,
      this.objectName,
      this.objectType,
      this.price,
      this.quantity,
      this.discount,
      this.amount});

  ProductBuy.fromJson(Map<String, dynamic> json) {
    dealDetailId = json['deal_detail_id'];
    objectId = json['object_id'];
    objectName = json['object_name'];
    objectType = json['object_type'];
    price = json['price'];
    quantity = json['quantity'];
    discount = json['discount'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_detail_id'] = this.dealDetailId;
    data['object_id'] = this.objectId;
    data['object_name'] = this.objectName;
    data['object_type'] = this.objectType;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    return data;
  }
}