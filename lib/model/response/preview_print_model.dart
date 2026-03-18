import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';

class PreviewPrintResponseModel {
  Order? order;
  Receipt? receipt;
  List<ReceiptDetail>? receiptDetail;
  SpaInfo? spaInfo;
  int? totalCustomerPaid;
  ConfigPrintBill? configPrintBill;
  int? id;
  String? printTime;
  int? sTT;
  String? qrCode;
  String? convertNumberToWords;
  BranchInfo? branchInfo;
  List<OrderDetailModel>? orderDetail;
  int? totalQuantity;
  double? totalDiscount;
  int? totalDiscountDetail;
  String? textTotalAmountPaid;
  double? amountReturn;
  double? amountPaid;
  double? accountMoney;

  PreviewPrintResponseModel(
      {this.order,
        this.orderDetail,
        this.receipt,
        this.receiptDetail,
        this.spaInfo,
        this.totalCustomerPaid,
        this.configPrintBill,
        this.id,
        this.printTime,
        this.sTT,
        this.qrCode,
        this.convertNumberToWords,
        this.branchInfo,
        this.totalQuantity,
        this.totalDiscount,
        this.totalDiscountDetail,
        this.textTotalAmountPaid,
        this.amountReturn,
        this.amountPaid,
        this.accountMoney});

  PreviewPrintResponseModel.fromJson(Map<String, dynamic> json) {
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
    if (json['order_detail'] != null) {
      orderDetail = <OrderDetailModel>[];
      json['order_detail'].forEach((v) {
        orderDetail!.add(new OrderDetailModel.fromJson(v));
      });
    }
    receipt =
    json['receipt'] != null ? new Receipt.fromJson(json['receipt']) : null;
    if (json['receipt_detail'] != null) {
      receiptDetail = <ReceiptDetail>[];
      json['receipt_detail'].forEach((v) {
        receiptDetail!.add(new ReceiptDetail.fromJson(v));
      });
    }
    spaInfo =
    json['spaInfo'] != null ? new SpaInfo.fromJson(json['spaInfo']) : null;
    totalCustomerPaid = json['totalCustomerPaid'];
    configPrintBill = json['configPrintBill'] != null
        ? new ConfigPrintBill.fromJson(json['configPrintBill'])
        : null;
    id = json['id'];
    printTime = json['printTime'];
    sTT = json['STT'];
    qrCode = json['QrCode'];
    convertNumberToWords = json['convertNumberToWords'];
    branchInfo = json['branchInfo'] != null
        ? new BranchInfo.fromJson(json['branchInfo'])
        : null;
    totalQuantity = json['totalQuantity'];
    totalDiscount = double.tryParse('${json['totalDiscount']}');
    totalDiscountDetail = json['totalDiscountDetail'];
    textTotalAmountPaid = json['text_total_amount_paid'];
    amountReturn = double.tryParse('${json['amount_return']}');
    amountPaid = double.tryParse('${json['amount_paid']}');
    accountMoney = double.tryParse('${json['accountMoney']}');
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    if (this.orderDetail != null) {
      data['oder_detail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    if (this.receipt != null) {
      data['receipt'] = this.receipt!.toJson();
    }
    if (this.receiptDetail != null) {
      data['receipt_detail'] =
          this.receiptDetail!.map((v) => v.toJson()).toList();
    }
    if (this.spaInfo != null) {
      data['spaInfo'] = this.spaInfo!.toJson();
    }
    data['totalCustomerPaid'] = this.totalCustomerPaid;
    if (this.configPrintBill != null) {
      data['configPrintBill'] = this.configPrintBill!.toJson();
    }
    data['id'] = this.id;
    data['printTime'] = this.printTime;
    data['STT'] = this.sTT;
    data['QrCode'] = this.qrCode;
    data['convertNumberToWords'] = this.convertNumberToWords;
    if (this.branchInfo != null) {
      data['branchInfo'] = this.branchInfo!.toJson();
    }
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    data['totalQuantity'] = this.totalQuantity;
    data['totalDiscount'] = this.totalDiscount;
    data['totalDiscountDetail'] = this.totalDiscountDetail;
    data['text_total_amount_paid'] = this.textTotalAmountPaid;
    data['amount_return'] = this.amountReturn;
    data['amount_paid'] = this.amountPaid;
    return data;
  }
}

class Order {
  String? fullName;
  String? phone;
  String? address;
  String? customerAvatar;
  int? customerId;
  String? phone1;
  String? orderCode;
  double? total;
  int? discount;
  int? tranportCharge;
  String? voucherCode;
  double? amount;
  String? processStatus;
  int? orderId;
  String? amountPaid;
  String? note;
  int? receiptId;
  int? referId;
  int? memberLevelId;
  String? memberLevelName;
  int? memberLevelDiscount;
  int? discountMember;
  int? branchId;
  int? orderSourceId;
  int? deliveryActive;
  int? deliveryId;
  String? shippingAddress;
  String? groupNameCus;
  String? customerContactCode;
  String? postcode;
  String? fullAddress;
  String? provinceName;
  String? districtName;
  int? receiveAtCounter;
  String? createdAt;
  String? staffName;
  String? profileCode;
  String? customerCode;
  String? deliveryRequestDate;
  String? orderDescription;
  int? customerContactId;
  int? receiptInfoCheck;
  String? typeTime;
  String? timeAddress;
  int? typeShipping;

  Order(
      {this.fullName,
        this.phone,
        this.address,
        this.customerAvatar,
        this.customerId,
        this.phone1,
        this.orderCode,
        this.total,
        this.discount,
        this.tranportCharge,
        this.voucherCode,
        this.amount,
        this.processStatus,
        this.orderId,
        this.amountPaid,
        this.note,
        this.receiptId,
        this.referId,
        this.memberLevelId,
        this.memberLevelName,
        this.memberLevelDiscount,
        this.discountMember,
        this.branchId,
        this.orderSourceId,
        this.deliveryActive,
        this.deliveryId,
        this.shippingAddress,
        this.groupNameCus,
        this.customerContactCode,
        this.postcode,
        this.fullAddress,
        this.provinceName,
        this.districtName,
        this.receiveAtCounter,
        this.createdAt,
        this.staffName,
        this.profileCode,
        this.customerCode,
        this.deliveryRequestDate,
        this.orderDescription,
        this.customerContactId,
        this.receiptInfoCheck,
        this.typeTime,
        this.timeAddress,
        this.typeShipping});

  Order.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    phone = json['phone'];
    address = json['address'];
    customerAvatar = json['customer_avatar'];
    customerId = json['customer_id'];
    phone1 = json['phone1'];
    orderCode = json['order_code'];
    total = double.tryParse('${json['total']}');
    discount = json['discount'];
    tranportCharge = json['tranport_charge'];
    voucherCode = json['voucher_code'];
    amount = double.tryParse('${json['amount']}');
    processStatus = json['process_status'];
    orderId = json['order_id'];
    amountPaid = json['amount_paid'];
    note = json['note'];
    receiptId = json['receipt_id'];
    referId = json['refer_id'];
    memberLevelId = json['member_level_id'];
    memberLevelName = json['member_level_name'];
    memberLevelDiscount = json['member_level_discount'];
    discountMember = json['discount_member'];
    branchId = json['branch_id'];
    orderSourceId = json['order_source_id'];
    deliveryActive = json['delivery_active'];
    deliveryId = json['delivery_id'];
    shippingAddress = json['shipping_address'];
    groupNameCus = json['group_name_cus'];
    customerContactCode = json['customer_contact_code'];
    postcode = json['postcode'];
    fullAddress = json['full_address'];
    provinceName = json['province_name'];
    districtName = json['district_name'];
    receiveAtCounter = json['receive_at_counter'];
    createdAt = json['created_at'];
    staffName = json['staff_name'];
    profileCode = json['profile_code'];
    customerCode = json['customer_code'];
    deliveryRequestDate = json['delivery_request_date'];
    orderDescription = json['order_description'];
    customerContactId = json['customer_contact_id'];
    receiptInfoCheck = json['receipt_info_check'];
    typeTime = json['type_time'];
    timeAddress = json['time_address'];
    typeShipping = json['type_shipping'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['customer_avatar'] = this.customerAvatar;
    data['customer_id'] = this.customerId;
    data['phone1'] = this.phone1;
    data['order_code'] = this.orderCode;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['tranport_charge'] = this.tranportCharge;
    data['voucher_code'] = this.voucherCode;
    data['amount'] = this.amount;
    data['process_status'] = this.processStatus;
    data['order_id'] = this.orderId;
    data['amount_paid'] = this.amountPaid;
    data['note'] = this.note;
    data['receipt_id'] = this.receiptId;
    data['refer_id'] = this.referId;
    data['member_level_id'] = this.memberLevelId;
    data['member_level_name'] = this.memberLevelName;
    data['member_level_discount'] = this.memberLevelDiscount;
    data['discount_member'] = this.discountMember;
    data['branch_id'] = this.branchId;
    data['order_source_id'] = this.orderSourceId;
    data['delivery_active'] = this.deliveryActive;
    data['delivery_id'] = this.deliveryId;
    data['shipping_address'] = this.shippingAddress;
    data['group_name_cus'] = this.groupNameCus;
    data['customer_contact_code'] = this.customerContactCode;
    data['postcode'] = this.postcode;
    data['full_address'] = this.fullAddress;
    data['province_name'] = this.provinceName;
    data['district_name'] = this.districtName;
    data['receive_at_counter'] = this.receiveAtCounter;
    data['created_at'] = this.createdAt;
    data['staff_name'] = this.staffName;
    data['profile_code'] = this.profileCode;
    data['customer_code'] = this.customerCode;
    data['delivery_request_date'] = this.deliveryRequestDate;
    data['order_description'] = this.orderDescription;
    data['customer_contact_id'] = this.customerContactId;
    data['receipt_info_check'] = this.receiptInfoCheck;
    data['type_time'] = this.typeTime;
    data['time_address'] = this.timeAddress;
    data['type_shipping'] = this.typeShipping;
    return data;
  }
}

class Receipt {
  int? receiptId;
  String? receiptCode;
  int? customerId;
  int? orderId;
  String? amount;
  String? amountPaid;
  String? createdAt;
  int? createdBy;
  String? amountReturn;
  String? fullName;

  Receipt(
      {this.receiptId,
        this.receiptCode,
        this.customerId,
        this.orderId,
        this.amount,
        this.amountPaid,
        this.createdAt,
        this.createdBy,
        this.amountReturn,
        this.fullName});

  Receipt.fromJson(Map<String, dynamic> json) {
    receiptId = json['receipt_id'];
    receiptCode = json['receipt_code'];
    customerId = json['customer_id'];
    orderId = json['order_id'];
    amount = json['amount'];
    amountPaid = json['amount_paid'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    amountReturn = json['amount_return'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_id'] = this.receiptId;
    data['receipt_code'] = this.receiptCode;
    data['customer_id'] = this.customerId;
    data['order_id'] = this.orderId;
    data['amount'] = this.amount;
    data['amount_paid'] = this.amountPaid;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['amount_return'] = this.amountReturn;
    data['full_name'] = this.fullName;
    return data;
  }
}

class ReceiptDetail {
  int? receiptDetailId;
  int? receiptId;
  int? cashierId;
  int? receiptType;
  double? amount;
  String? cardCode;
  String? createdAt;
  String? paymentMethodCode;
  String? paymentMethodName;

  ReceiptDetail(
      {this.receiptDetailId,
        this.receiptId,
        this.cashierId,
        this.receiptType,
        this.amount,
        this.cardCode,
        this.createdAt,
        this.paymentMethodCode,
        this.paymentMethodName});

  ReceiptDetail.fromJson(Map<String, dynamic> json) {
    receiptDetailId = json['receipt_detail_id'];
    receiptId = json['receipt_id'];
    cashierId = json['cashier_id'];
    receiptType = json['receipt_type'];
    amount = double.tryParse(json['amount']);
    cardCode = json['card_code'];
    createdAt = json['created_at'];
    paymentMethodCode = json['payment_method_code'];
    paymentMethodName = json['payment_method_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['receipt_detail_id'] = this.receiptDetailId;
    data['receipt_id'] = this.receiptId;
    data['cashier_id'] = this.cashierId;
    data['receipt_type'] = this.receiptType;
    data['amount'] = this.amount;
    data['card_code'] = this.cardCode;
    data['created_at'] = this.createdAt;
    data['payment_method_code'] = this.paymentMethodCode;
    data['payment_method_name'] = this.paymentMethodName;
    return data;
  }
}

class SpaInfo {
  int? id;
  String? name;
  String? code;
  List<String>? phone;
  int? isActived;
  int? isDeleted;
  String? email;
  String? hotLine;
  String? address;
  String? slogan;
  int? bussinessId;
  String? logo;
  String? fanpage;
  String? zalo;
  String? instagramPage;
  String? districtName;
  String? districtType;
  String? provinceName;
  String? taxCode;
  int? isPartPaid;

  SpaInfo(
      {this.id,
        this.name,
        this.code,
        this.phone,
        this.isActived,
        this.isDeleted,
        this.email,
        this.hotLine,
        this.address,
        this.slogan,
        this.bussinessId,
        this.logo,
        this.fanpage,
        this.zalo,
        this.instagramPage,
        this.districtName,
        this.districtType,
        this.provinceName,
        this.taxCode,
        this.isPartPaid});

  SpaInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    phone = json['phone'].cast<String>();
    isActived = json['is_actived'];
    isDeleted = json['is_deleted'];
    email = json['email'];
    hotLine = json['hot_line'];
    address = json['address'];
    slogan = json['slogan'];
    bussinessId = json['bussiness_id'];
    logo = json['logo'];
    fanpage = json['fanpage'];
    zalo = json['zalo'];
    instagramPage = json['instagram_page'];
    districtName = json['district_name'];
    districtType = json['district_type'];
    provinceName = json['province_name'];
    taxCode = json['tax_code'];
    isPartPaid = json['is_part_paid'];
    taxCode = json['tax_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['phone'] = this.phone;
    data['is_actived'] = this.isActived;
    data['is_deleted'] = this.isDeleted;
    data['email'] = this.email;
    data['hot_line'] = this.hotLine;
    data['address'] = this.address;
    data['slogan'] = this.slogan;
    data['bussiness_id'] = this.bussinessId;
    data['logo'] = this.logo;
    data['fanpage'] = this.fanpage;
    data['zalo'] = this.zalo;
    data['instagram_page'] = this.instagramPage;
    data['district_name'] = this.districtName;
    data['district_type'] = this.districtType;
    data['province_name'] = this.provinceName;
    data['tax_code'] = this.taxCode;
    data['is_part_paid'] = this.isPartPaid;
    return data;
  }
}

class ConfigPrintBill {
  int? printedSheet;
  int? isPrintReply;
  int? isShowLogo;
  int? isShowUnit;
  int? isShowAddress;
  int? isShowPhone;
  int? isShowOrderCode;
  int? isShowCashier;
  int? isShowCustomer;
  int? isShowDatetime;
  int? isShowFooter;
  String? template;
  String? symbol;
  int? isTotalBill;
  int? isTotalDiscount;
  int? isTotalAmount;
  int? isTotalReceipt;
  int? isAmountReturn;
  int? isAmountMember;
  int? isQrcodeOrder;
  int? isPaymentMethod;
  int? isCustomerCode;
  int? isOrderCode;
  int? isProfileCode;
  int? isCompanyTaxCode;
  int? isSign;
  int? isDeptCustomer;
  String? noteFooter;

  ConfigPrintBill(
      {this.printedSheet,
        this.isPrintReply,
        this.isShowLogo,
        this.isShowUnit,
        this.isShowAddress,
        this.isShowPhone,
        this.isShowOrderCode,
        this.isShowCashier,
        this.isShowCustomer,
        this.isShowDatetime,
        this.isShowFooter,
        this.template,
        this.symbol,
        this.isTotalBill,
        this.isTotalDiscount,
        this.isTotalAmount,
        this.isTotalReceipt,
        this.isAmountReturn,
        this.isAmountMember,
        this.isQrcodeOrder,
        this.isPaymentMethod,
        this.isCustomerCode,
        this.isOrderCode,
        this.isProfileCode,
        this.isCompanyTaxCode,
        this.isSign,
        this.isDeptCustomer,
        this.noteFooter});

  ConfigPrintBill.fromJson(Map<String, dynamic> json) {
    printedSheet = json['printed_sheet'];
    isPrintReply = json['is_print_reply'];
    isShowLogo = json['is_show_logo'];
    isShowUnit = json['is_show_unit'];
    isShowAddress = json['is_show_address'];
    isShowPhone = json['is_show_phone'];
    isShowOrderCode = json['is_show_order_code'];
    isShowCashier = json['is_show_cashier'];
    isShowCustomer = json['is_show_customer'];
    isShowDatetime = json['is_show_datetime'];
    isShowFooter = json['is_show_footer'];
    template = json['template'];
    symbol = json['symbol'];
    isTotalBill = json['is_total_bill'];
    isTotalDiscount = json['is_total_discount'];
    isTotalAmount = json['is_total_amount'];
    isTotalReceipt = json['is_total_receipt'];
    isAmountReturn = json['is_amount_return'];
    isAmountMember = json['is_amount_member'];
    isQrcodeOrder = json['is_qrcode_order'];
    isPaymentMethod = json['is_payment_method'];
    isCustomerCode = json['is_customer_code'];
    isOrderCode = json['is_order_code'];
    isProfileCode = json['is_profile_code'];
    isCompanyTaxCode = json['is_company_tax_code'];
    isSign = json['is_sign'];
    isDeptCustomer = json['is_dept_customer'];
    noteFooter = json['note_footer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['printed_sheet'] = this.printedSheet;
    data['is_print_reply'] = this.isPrintReply;
    data['is_show_logo'] = this.isShowLogo;
    data['is_show_unit'] = this.isShowUnit;
    data['is_show_address'] = this.isShowAddress;
    data['is_show_phone'] = this.isShowPhone;
    data['is_show_order_code'] = this.isShowOrderCode;
    data['is_show_cashier'] = this.isShowCashier;
    data['is_show_customer'] = this.isShowCustomer;
    data['is_show_datetime'] = this.isShowDatetime;
    data['is_show_footer'] = this.isShowFooter;
    data['template'] = this.template;
    data['symbol'] = this.symbol;
    data['is_total_bill'] = this.isTotalBill;
    data['is_total_discount'] = this.isTotalDiscount;
    data['is_total_amount'] = this.isTotalAmount;
    data['is_total_receipt'] = this.isTotalReceipt;
    data['is_amount_return'] = this.isAmountReturn;
    data['is_amount_member'] = this.isAmountMember;
    data['is_qrcode_order'] = this.isQrcodeOrder;
    data['is_payment_method'] = this.isPaymentMethod;
    data['is_customer_code'] = this.isCustomerCode;
    data['is_order_code'] = this.isOrderCode;
    data['is_profile_code'] = this.isProfileCode;
    data['is_company_tax_code'] = this.isCompanyTaxCode;
    data['is_sign'] = this.isSign;
    data['is_dept_customer'] = this.isDeptCustomer;
    data['note_footer'] = this.noteFooter;
    return data;
  }
}


class BranchInfo {
  int? branchId;
  String? branchName;
  String? address;
  String? description;
  String? phone;
  int? isActived;
  int? isDeleted;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? email;
  String? hotLine;
  String? provinceid;
  String? districtid;
  int? isRepresentative;
  String? representativeCode;
  String? provinceType;
  String? provinceName;
  String? districtType;
  String? districtName;
  String? branchCode;

  BranchInfo(
      {this.branchId,
        this.branchName,
        this.address,
        this.description,
        this.phone,
        this.isActived,
        this.isDeleted,
        this.createdBy,
        this.updatedBy,
        this.createdAt,
        this.email,
        this.hotLine,
        this.provinceid,
        this.districtid,
        this.isRepresentative,
        this.representativeCode,
        this.provinceType,
        this.provinceName,
        this.districtType,
        this.districtName,
        this.branchCode});

  BranchInfo.fromJson(Map<String, dynamic> json) {
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    address = json['address'];
    description = json['description'];
    phone = json['phone'];
    isActived = json['is_actived'];
    isDeleted = json['is_deleted'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    email = json['email'];
    hotLine = json['hot_line'];
    provinceid = json['provinceid'];
    districtid = json['districtid'];
    isRepresentative = json['is_representative'];
    representativeCode = json['representative_code'];
    provinceType = json['province_type'];
    provinceName = json['province_name'];
    districtType = json['district_type'];
    districtName = json['district_name'];
    branchCode = json['branch_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['address'] = this.address;
    data['description'] = this.description;
    data['phone'] = this.phone;
    data['is_actived'] = this.isActived;
    data['is_deleted'] = this.isDeleted;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['email'] = this.email;
    data['hot_line'] = this.hotLine;
    data['provinceid'] = this.provinceid;
    data['districtid'] = this.districtid;
    data['is_representative'] = this.isRepresentative;
    data['representative_code'] = this.representativeCode;
    data['province_type'] = this.provinceType;
    data['province_name'] = this.provinceName;
    data['district_type'] = this.districtType;
    data['district_name'] = this.districtName;
    data['branch_code'] = this.branchCode;
    return data;
  }
}
