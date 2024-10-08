import 'package:epoint_deal_plugin/model/response/get_tag_model_response.dart';
import 'package:epoint_deal_plugin/model/response/other_free_branch_response_model.dart';

class DetailDealModelResponse {
  int? errorCode;
  String? errorDescription;
  DetailDealData? data;

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
      data['Data'] = this.data!.toJson();
    }
    return data;
  }
}

class DetailDealData {
  int? dealId;
  String? dealCode;
  String? dealName;
  String? phone;
  num? amount;
  String? typeCustomer;
  String? customerCode;
  String? journeyName;
  String? journeyCode;
  String? pipelineCode;
  String? closingDate;
  String? closingDueDate;
  String? reasonLoseCode;
  String? branchName;
  String? orderSourceName;
  int? orderSourceId;
  List<TagData>? tag;
  int? probability;
  String? dealDescription;
  int? saleId;
  String? staffName;
  int? timeRevokeLead;
  String? createdAt;
  String? updatedAt;
  String? customerName;
  String? customerAvatar;
  String? customerEmail;
  String? customerGender;
  String? province;
  String? district;
  String? address;
  String? backgroundColorJourney;
  String? productNameBuy;
  String? dateLastCare;
  int? diffDay;
  int? relatedWork;
  int? appointment;
  int? expectedRevenue;
  int? total;
  String? discountType;
  int? discountValue;
  int? voucherCode;
  int? totalOtherFee;
  int? amountBeforeVat;
  int? totalVat;
  String? ward;
  String? businessClue;
  String? fanpage;
  String? zalo;
  String? customerSourceName;
  List<OrderFeeModel>? otherFee;
  List<CustomerCare>? customerCare;
  List<JourneyTracking>? journeyTracking;
  List<ProductBuy>? productBuy;
  num? discount;
  List<CustomerDetailConfigModel>? tabConfigs;

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
      this.orderSourceId,
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
      this.productBuy,
      this.dateLastCare,
      this.diffDay,
      this.relatedWork,
      this.appointment,
      this.customerCare,
      this.discount,
      this.tabConfigs,
      this.expectedRevenue,
      this.total,
      this.discountType,
      this.discountValue,
      this.voucherCode,
      this.totalOtherFee,
      this.amountBeforeVat,
      this.totalVat,
      this.ward,
      this.businessClue,
      this.fanpage,
      this.zalo,
      this.customerSourceName,
      this.otherFee});


  DetailDealData.fromJson(Map<String, dynamic> json) {
    dealId = json['deal_id'] ?? 0;
    dealCode = json['deal_code'] ?? "";
    dealName = json['deal_name'] ?? "";
    phone = json['phone'] ?? "";
    amount = json['amount'] ?? 0;
    typeCustomer = json['type_customer'] ?? "";
    customerCode = json['customer_code'] ?? "";
    journeyName = json['journey_name'] ?? "";
    journeyCode = json['journey_code'] ?? "";
    pipelineCode = json['pipeline_code'] ?? "";
    closingDate = json['closing_date'] ?? "";
    closingDueDate = json['closing_due_date'] ?? "";
    reasonLoseCode = json['reason_lose_code'] ?? "";
    branchName = json['branch_name'] ?? "";
    orderSourceName = json['order_source_name'] ?? "";
    expectedRevenue = json['expected_revenue'] ?? 0;
    if (json['tag'] != null) {
      tag = <TagData>[];
      json['tag'].forEach((v) {
        tag!.add(new TagData.fromJson(v));
      });
    }
    if (json['tab_configs'] != null) {
      tabConfigs = <CustomerDetailConfigModel>[];
      json['tab_configs'].forEach((v) {
        tabConfigs!.add(new CustomerDetailConfigModel.fromJson(v));
      });
    }
    probability = json['probability'] ?? 0;
    dealDescription = json['deal_description'] ?? "";
    saleId = json['sale_id'] ?? 0;
    staffName = json['staff_name'] ?? "";
    timeRevokeLead = json['time_revoke_lead'] ?? 0;
    createdAt = json['created_at'] ?? "";
    updatedAt = json['updated_at'] ?? "";
    customerName = json['customer_name'];
    customerAvatar = json['customer_avatar'] ?? "";
    customerEmail = json['customer_email'] ?? "";
    customerGender = json['customer_gender'] ?? "";
    province = json['province'] ?? "";
    district = json['district'] ?? "";
    backgroundColorJourney = json['background_color_journey'] ?? "";
    productNameBuy = json['product_name_buy'] ?? "";
    dateLastCare = json['date_last_care'];
    diffDay = json['diff_day'];
    relatedWork = json['related_work'];
    appointment = json['appointment'];
    orderSourceId = json['order_source_id'] ?? 0;
    discount = json['discount'];
    voucherCode = json["voucher_code"];

    if (json['journey_tracking'] != null) {
      journeyTracking = <JourneyTracking>[];
      json['journey_tracking'].forEach((v) {
        journeyTracking!.add(new JourneyTracking.fromJson(v));
      });
    }
    if (json['product_buy'] != null) {
      productBuy = <ProductBuy>[];
      json['product_buy'].forEach((v) {
        productBuy!.add(ProductBuy.fromJson(v));
      });
    }

    if (json['customer_care'] != null) {
      customerCare = <CustomerCare>[];
      json['customer_care'].forEach((v) {
        customerCare!.add(new CustomerCare.fromJson(v));
      });
    }

    total = json['total'];
    discountType = json['discount_type'];
    discountValue = json['discount_value'];
    totalOtherFee = json['total_other_fee'];
    amountBeforeVat = json['amount_before_vat'];
    totalVat = json['total_vat'];
    ward = json['ward'];
    address = json['address'];
    businessClue = json['business_clue'];
    fanpage = json['fanpage'];
    zalo = json['zalo'];
    customerSourceName = json['customer_source_name'];
    if (json['other_fee'] != null) {
      otherFee = <OrderFeeModel>[];
      json['other_fee'].forEach((v) {
        otherFee!.add(new OrderFeeModel.fromJson(v));
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
    
    if (this.tag != null) {
      data['tag'] = this.tag!.map((v) => v.toJson()).toList();
    }
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
    data['order_source_id'] = this.orderSourceId;
    data['expected_revenue'] = this.expectedRevenue;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['total_other_fee'] = this.totalOtherFee;
    data['amount_before_vat'] = this.amountBeforeVat;
    data['total_vat'] = this.totalVat;
    data['ward'] = this.ward;
    data['business_clue'] = this.businessClue;
    data['fanpage'] = this.fanpage;
    data['zalo'] = this.zalo;
    data['customer_source_name'] = this.customerSourceName;
    if (this.journeyTracking != null) {
      data['journey_tracking'] =
          this.journeyTracking!.map((v) => v.toJson()).toList();
    }
    if (this.productBuy != null) {
      data['product_buy'] = this.productBuy!.map((v) => v.toJson()).toList();
    }
    if (this.otherFee != null) {
      data['other_fee'] = this.otherFee!.map((v) => v.toJson()).toList();
    }
    data['discount'] = this.discount;
    data['date_last_care'] = this.dateLastCare;
    data['diff_day'] = this.diffDay;
    data['related_work'] = this.relatedWork;
    data['appointment '] = this.appointment;

    if (this.customerCare != null) {
      data['customer_care'] = this.customerCare!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class JourneyTracking {
  String? journeyCode;
  int? journeyId;
  String? journeyName;
  int? pipelineId;
  String? pipelineCode;
  bool? check;

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

class CustomerDetailConfigModel {
  int? customerConfigTabDetailId;
  String? code;
  String? tabNameVi;
  String? tabNameEn;
  int? sortOrder;
  int? total;

  CustomerDetailConfigModel(
      {this.customerConfigTabDetailId,
      this.code,
      this.tabNameVi,
      this.tabNameEn,
      this.sortOrder,
      this.total});

  CustomerDetailConfigModel.fromJson(Map<String, dynamic> json) {
    customerConfigTabDetailId = json['customer_config_tab_detail_id'];
    code = json['code'];
    tabNameVi = json['tab_name_vi'];
    tabNameEn = json['tab_name_en'];
    sortOrder = json['sort_order'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_config_tab_detail_id'] = this.customerConfigTabDetailId;
    data['code'] = this.code;
    data['tab_name_vi'] = this.tabNameVi;
    data['tab_name_en'] = this.tabNameEn;
    data['sort_order'] = this.sortOrder;
    data['total'] = this.total;
    return data;
  }
}

// class OtherFee {
//   int? otherFeeId;
//   String? otherFeeCode;
//   String? otherFeeName;
//   int? otherFeeValue;
//   String? feeType;
//   String? feeMoney;

//   OtherFee(
//       {this.otherFeeId,
//       this.otherFeeCode,
//       this.otherFeeName,
//       this.otherFeeValue,
//       this.feeType,
//       this.feeMoney});

//   OtherFee.fromJson(Map<String, dynamic> json) {
//     otherFeeId = json['other_fee_id'];
//     otherFeeCode = json['other_fee_code'];
//     otherFeeName = json['other_fee_name'];
//     otherFeeValue = json['other_fee_value'];
//     feeType = json['fee_type'];
//     feeMoney = json['fee_money'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['other_fee_id'] = this.otherFeeId;
//     data['other_fee_code'] = this.otherFeeCode;
//     data['other_fee_name'] = this.otherFeeName;
//     data['other_fee_value'] = this.otherFeeValue;
//     data['fee_type'] = this.feeType;
//     data['fee_money'] = this.feeMoney;
//     return data;
//   }
// }

class ProductBuy {
  int? dealDetailId;
  int? objectId;
  String? objectName;
  String? objectType;
  num? price;
  num? quantity;
  int? discount;
  num? amount;
  String? note;
  String? dealCode;
  String? objectCode;
  int? position;
  int? discountValue;
  String? discountType;
  String? voucherCode;
  String? objectDescription;
  int? unitId;
  String? unitName;
  String? productsDescription;
  int? productId;
  String? productChildType;
  int? productChildBaseId;
  int? serviceOtherFlagId;
  String? serviceOtherFlagName;

  ProductBuy(
      {this.dealDetailId,
      this.objectId,
      this.objectName,
      this.objectType,
      this.price,
      this.quantity,
      this.discount,
      this.amount,
      this.note,
      this.dealCode, 
      this.objectCode,
      this.position,
      this.discountValue,
      this.discountType,
      this.voucherCode,
      this.objectDescription,
      this.unitId,
      this.unitName,
      this.productsDescription,
      this.productId,
      this.productChildType,
      this.productChildBaseId,
      this.serviceOtherFlagId,
      this.serviceOtherFlagName});

  ProductBuy.fromJson(Map<String, dynamic> json) {
    dealDetailId = json['deal_detail_id'];
    objectId = json['object_id'];
    objectName = json['object_name'];
    objectType = json['object_type'];
    price = json['price'];
    quantity = json['quantity'];
    discount = json['discount'];
    amount = json['amount'];
    note = json['note'];
    dealCode = json['deal_code'];
    objectCode = json['object_code'];
    position = json['position'];
    discountValue = json['discount_value'];
    discountType = json['discount_type'];
    voucherCode = json['voucher_code'];
    objectDescription = json['object_description'];
    unitId = json['unit_id'];
    unitName = json['unit_name'];
    productsDescription = json['products_description'];
    productId = json['product_id'];
    productChildType = json['product_child_type'];
    productChildBaseId = json['product_child_base_id'];
    serviceOtherFlagId = json['service_other_flag_id'];
    serviceOtherFlagName = json['service_other_flag_name'];
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
    data['note'] = this.note;
    data['deal_code'] = this.dealCode;
    data['object_code'] = this.objectCode;
    data['position'] = this.position;
    data['discount_value'] = this.discountValue;
    data['discount_type'] = this.discountType;
    data['voucher_code'] = this.voucherCode;
    data['object_description'] = this.objectDescription;
    data['unit_id'] = this.unitId;
    data['unit_name'] = this.unitName;
    data['products_description'] = this.productsDescription;
    data['product_id'] = this.productId;
    data['product_child_type'] = this.productChildType;
    data['product_child_base_id'] = this.productChildBaseId;
    data['service_other_flag_id'] = this.serviceOtherFlagId;
    data['service_other_flag_name'] = this.serviceOtherFlagName;
    
    return data;
  }
}

class CustomerCare {
  int? manageWorkId;
  String? manageWorkCode;
  String? manageWorkCustomerType;
  int? manageProjectId;
  String? manageProjectName;
  int? manageTypeWorkId;
  String? manageTypeWorkKey;
  String? manageTypeWorkName;
  String? manageTypeWorkIcon;
  String? createdAt;
  String? manageWorkTitle;
  String? dateStart;
  String? dateEnd;
  String? dateFinish;
  int? processorId;
  String? staffFullName;
  String? staffAvatar;
  int? manageStatusId;
  String? manageStatusName;
  String? manageStatusColor;
  int? countFile;
  int? countComment;
  int? daysLate;
  List<ListTagDetail>? listTag;

  CustomerCare(
      {this.manageWorkId,
      this.manageWorkCode,
      this.manageWorkCustomerType,
      this.manageProjectId,
      this.manageProjectName,
      this.manageTypeWorkId,
      this.manageTypeWorkKey,
      this.manageTypeWorkName,
      this.manageTypeWorkIcon,
      this.createdAt,
      this.manageWorkTitle,
      this.dateStart,
      this.dateEnd,
      this.dateFinish,
      this.processorId,
      this.staffFullName,
      this.staffAvatar,
      this.manageStatusId,
      this.manageStatusName,
      this.manageStatusColor,
      this.listTag,
      this.countFile,
      this.countComment,
      this.daysLate});

  CustomerCare.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    manageWorkCode = json['manage_work_code'];
    manageWorkCustomerType = json['manage_work_customer_type'];
    manageProjectId = json['manage_project_id'];
    manageProjectName = json['manage_project_name'];
    manageTypeWorkId = json['manage_type_work_id'];
    manageTypeWorkKey = json['manage_type_work_key'];
    manageTypeWorkName = json['manage_type_work_name'];
    manageTypeWorkIcon = json['manage_type_work_icon'];
    createdAt = json['created_at'];
    manageWorkTitle = json['manage_work_title'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    dateFinish = json['date_finish'];
    processorId = json['processor_id'];
    staffFullName = json['staff_full_name'];
    staffAvatar = json['staff_avatar'];
    manageStatusId = json['manage_status_id'];
    manageStatusName = json['manage_status_name'];
    manageStatusColor = json['manage_status_color'];
    countFile = json['count_file'];
    countComment = json['count_comment'];
    daysLate = json['days_late'];
    if (json['list_tag'] != null) {
      listTag = <ListTagDetail>[];
      json['list_tag'].forEach((v) {
        listTag!.add(new ListTagDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['manage_work_code'] = this.manageWorkCode;
    data['manage_work_customer_type'] = this.manageWorkCustomerType;
    data['manage_project_id'] = this.manageProjectId;
    data['manage_project_name'] = this.manageProjectName;
    data['manage_type_work_id'] = this.manageTypeWorkId;
    data['manage_type_work_key'] = this.manageTypeWorkKey;
    data['manage_type_work_name'] = this.manageTypeWorkName;
    data['manage_type_work_icon'] = this.manageTypeWorkIcon;
    data['created_at'] = this.createdAt;
    data['manage_work_title'] = this.manageWorkTitle;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['date_finish'] = this.dateFinish;
    data['processor_id'] = this.processorId;
    data['staff_full_name'] = this.staffFullName;
    data['staff_avatar'] = this.staffAvatar;
    data['manage_status_id'] = this.manageStatusId;
    data['manage_status_name'] = this.manageStatusName;
    data['manage_status_color'] = this.manageStatusColor;
    data['count_file'] = this.countFile;
    data['count_comment'] = this.countComment;
    data['days_late'] = this.daysLate;
    if (this.listTag != null) {
      data['list_tag'] = this.listTag!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ListTagDetail {
  int? manageWorkTagId;
  int? manageWorkId;
  int? manageTagId;
  String? tagName;

  ListTagDetail(
      {this.manageWorkTagId,
      this.manageWorkId,
      this.manageTagId,
      this.tagName});

  ListTagDetail.fromJson(Map<String, dynamic> json) {
    manageWorkTagId = json['manage_work_tag_id'];
    manageWorkId = json['manage_work_id'];
    manageTagId = json['manage_tag_id'];
    tagName = json['tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_tag_id'] = this.manageWorkTagId;
    data['manage_work_id'] = this.manageWorkId;
    data['manage_tag_id'] = this.manageTagId;
    data['tag_name'] = this.tagName;
    return data;
  }
}