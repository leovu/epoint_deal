import 'dart:io';

import 'booking_detail_response_model.dart';
import 'booking_staff_response_model.dart';
import 'customer_response_model.dart';

class OrderDetailResponseModel {
  int? orderId;
  String? orderCode;
  int? branchId;
  String? branchName;
  int? referId;
  String? referName;
  int? saleId;
  String? saleName;
  double? total;
  double? discount;
  double? discountValue;
  String? discountType;
  String? discountCode;
  double? tranportCharge;
  double? amount;
  String? processStatus;
  String? processStatusColor;
  String? voucherCode;
  double? discountMember;
  String? orderDate;
  int? orderSourceId;
  String? orderSourceName;
  int? receiveAtCounter;
  int? typeShipping;
  int? deliveryCostId;
  String? customerContactCode;
  String? orderDescription;
  int? paymentMethodId;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? createdAt;
  String? updatedAt;
  int? customerId;
  String? paymentMethodName;
  String? typeShippingText;
  double? owed;
  String? processStatusName;
  int? isRemove;
  int? isCancel;
  int? isEdit;
  List<OrderDetailModel>? orderDetail;
  double? quantity;
  String? paymentStatus;
  List<OrderReceiptModel>? receiptDetail;
  double? payed;
  List<OrderImageModel>? imageBefore;
  List<OrderImageModel>? imageAfter;
  CustomerModel? customer;
  DeliveryAddress? customerContactShipping;
  List<BookingDetailFeeModel>? otherFee;
  int? vatId;
  String? vat;
  String? vatDescription;
  double? totalOtherFee;
  double? amountBeforeVat;
  double? totalTax;

  OrderDetailResponseModel({
    this.orderId,
    this.orderCode,
    this.branchId,
    this.branchName,
    this.referId,
    this.referName,
    this.saleId,
    this.saleName,
    this.total,
    this.discount,
    this.discountValue,
    this.discountType,
    this.discountCode,
    this.tranportCharge,
    this.amount,
    this.processStatus,
    this.processStatusColor,
    this.voucherCode,
    this.discountMember,
    this.orderDate,
    this.orderSourceId,
    this.orderSourceName,
    this.receiveAtCounter,
    this.typeShipping,
    this.deliveryCostId,
    this.customerContactCode,
    this.orderDescription,
    this.paymentMethodId,
    this.staffCreatedName,
    this.staffUpdatedName,
    this.createdAt,
    this.updatedAt,
    this.customerId,
    this.paymentMethodName,
    this.typeShippingText,
    this.owed,
    this.processStatusName,
    this.isRemove,
    this.isCancel,
    this.isEdit,
    this.orderDetail,
    this.paymentStatus,
    this.receiptDetail,
    this.payed,
    this.imageBefore,
    this.imageAfter,
    this.customer,
    this.customerContactShipping,
    this.otherFee,
    this.vatId,
    this.vat,
    this.vatDescription,
    this.totalOtherFee,
    this.amountBeforeVat,
    this.totalTax,
  });

  OrderDetailResponseModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderCode = json['order_code'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    referId = json['refer_id'];
    referName = json['refer_name'];
    saleId = json['sale_id'];
    saleName = json['sale_name'];
    total = double.tryParse((json['total'] ?? 0.0).toString());
    discount = json['discount'] == null
        ? null
        : double.tryParse((json['discount'] ?? 0.0).toString());
    discountValue = double.tryParse((json['discount_value'] ?? "").toString());
    discountType = json['discount_type'];
    discountCode = json['discount_code'];
    tranportCharge =
        double.tryParse((json['tranport_charge'] ?? 0.0).toString());
    amount = double.tryParse((json['amount'] ?? 0.0).toString());
    processStatus = json['process_status'];
    processStatusColor = json['process_status_color'];
    voucherCode = json['voucher_code'];
    discountMember =
        double.tryParse((json['discount_member'] ?? 0.0).toString());
    orderDate = json['order_date'];
    orderSourceId = json['order_source_id'];
    orderSourceName = json['order_source_name'];
    receiveAtCounter = json['receive_at_counter'];
    typeShipping = json['type_shipping'];
    deliveryCostId = json['delivery_cost_id'];
    customerContactCode = json['customer_contact_code'];
    orderDescription = json['order_description'];
    paymentMethodId = json['payment_method_id'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    customerId = json['customer_id'];
    paymentMethodName = json['payment_method_name'];
    typeShippingText = json['type_shipping_text'];
    owed = double.tryParse((json['owed'] ?? 0.0).toString());
    processStatusName = json['process_status_name'];
    isRemove = json['is_remove'];
    isCancel = json['is_cancel'];
    isEdit = json['is_edit'];
    quantity = 0;
    if (json['order_detail'] != null) {
      orderDetail = <OrderDetailModel>[];
      json['order_detail'].forEach((v) {
        final model = OrderDetailModel.fromJson(v);
        quantity = quantity! + model.quantity!;
        orderDetail!.add(model);
      });
    }
    paymentStatus = json['payment_status'];
    if (json['receipt_detail'] != null) {
      receiptDetail = <OrderReceiptModel>[];
      json['receipt_detail'].forEach((v) {
        receiptDetail!.add(new OrderReceiptModel.fromJson(v));
      });
    }
    payed = double.tryParse((json['payed'] ?? 0.0).toString());
    if (json['image_before'] != null) {
      imageBefore = <OrderImageModel>[];
      json['image_before'].forEach((v) {
        imageBefore!.add(new OrderImageModel.fromJson(v));
      });
    }
    if (json['image_after'] != null) {
      imageAfter = <OrderImageModel>[];
      json['image_after'].forEach((v) {
        imageAfter!.add(new OrderImageModel.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new CustomerModel.fromJson(json['customer'])
        : null;
    customerContactShipping = json['customer_contact_shipping'] != null
        ? new DeliveryAddress.fromJson(json['customer_contact_shipping'])
        : null;
    if (json['other_fee'] != null) {
      otherFee = <BookingDetailFeeModel>[];
      json['other_fee'].forEach((v) {
        otherFee!.add(new BookingDetailFeeModel.fromJson(v));
      });
    }
    vatId = json['vat_id'];
    vat = json['vat'];
    vatDescription = json['vat_description'];
    totalOtherFee =
        double.tryParse((json['total_other_fee'] ?? 0.0).toString());
    amountBeforeVat =
        double.tryParse((json['amount_before_vat'] ?? 0.0).toString());
    totalTax = double.tryParse((json['total_tax'] ?? 0.0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_code'] = this.orderCode;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['refer_id'] = this.referId;
    data['refer_name'] = this.referName;
    data['sale_id'] = this.saleId;
    data['sale_name'] = this.saleName;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['discount_value'] = this.discountValue;
    data['discount_type'] = this.discountType;
    data['discount_code'] = this.discountCode;
    data['tranport_charge'] = this.tranportCharge;
    data['amount'] = this.amount;
    data['process_status'] = this.processStatus;
    data['process_status_color'] = this.processStatusColor;
    data['voucher_code'] = this.voucherCode;
    data['discount_member'] = this.discountMember;
    data['order_date'] = this.orderDate;
    data['order_source_id'] = this.orderSourceId;
    data['order_source_name'] = this.orderSourceName;
    data['receive_at_counter'] = this.receiveAtCounter;
    data['type_shipping'] = this.typeShipping;
    data['delivery_cost_id'] = this.deliveryCostId;
    data['customer_contact_code'] = this.customerContactCode;
    data['order_description'] = this.orderDescription;
    data['payment_method_id'] = this.paymentMethodId;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['customer_id'] = this.customerId;
    data['payment_method_name'] = this.paymentMethodName;
    data['type_shipping_text'] = this.typeShippingText;
    data['owed'] = this.owed;
    data['process_status_name'] = this.processStatusName;
    data['is_remove'] = this.isRemove;
    data['is_cancel'] = this.isCancel;
    data['is_edit'] = this.isEdit;
    if (this.orderDetail != null) {
      data['order_detail'] = this.orderDetail!.map((v) => v.toJson()).toList();
    }
    data['payment_status'] = this.paymentStatus;
    if (this.receiptDetail != null) {
      data['receipt_detail'] =
          this.receiptDetail!.map((v) => v.toJson()).toList();
    }
    data['payed'] = this.payed;
    if (this.imageBefore != null) {
      data['image_before'] = this.imageBefore!.map((v) => v.toJson()).toList();
    }
    if (this.imageAfter != null) {
      data['image_after'] = this.imageAfter!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    if (this.customerContactShipping != null) {
      data['customer_contact_shipping'] =
          this.customerContactShipping!.toJson();
    }
    if (this.otherFee != null) {
      data['other_fee'] = this.otherFee!.map((v) => v.toJson()).toList();
    }
    data['vat_id'] = this.vatId;
    data['vat'] = this.vat;
    data['vat_description'] = this.vatDescription;
    data['total_other_fee'] = this.totalOtherFee;
    data['amount_before_vat'] = this.amountBeforeVat;
    data['total_tax'] = this.totalTax;
    return data;
  }
}

class OrderDetailModel {
  int? orderDetailId;
  int? objectId;
  String? objectName;
  String? objectType;
  String? objectCode;
  double? price;
  double? quantity;
  String? discountType;
  double? discountValue;
  double? discount;
  String? discountCode;
  double? amount;
  double? surcharge;
  String? createdAt;
  String? objectImage;
  int? isCheckPromotion;
  int? isChangePrice;
  int? referId;
  String? note;
  int? orderDetailIdParent;
  String? unitName;
  List<BookingStaffModel>? staffs;

  OrderDetailModel(
      {this.orderDetailId,
      this.objectId,
      this.objectName,
      this.objectType,
      this.objectCode,
      this.price,
      this.quantity,
      this.discountType,
      this.discountValue,
      this.discount,
      this.discountCode,
      this.amount,
      this.surcharge,
      this.createdAt,
      this.objectImage,
      this.isCheckPromotion,
      this.isChangePrice,
      this.referId,
      this.note,
      this.orderDetailIdParent,
      this.unitName,
      this.staffs});

  OrderDetailModel.fromJson(Map<String, dynamic> json) {
    orderDetailId = json['order_detail_id'];
    objectId = json['object_id'];
    objectName = json['object_name'];
    objectType = json['object_type'];
    objectCode = json['object_code'];
    price = double.tryParse((json['price'] ?? 0.0).toString());
    quantity = double.tryParse((json['quantity'] ?? 0.0).toString());
    discountType = json['discount_type'];
    discountValue = double.tryParse((json['discount_value'] ?? "").toString());
    discount = double.tryParse((json['discount'] ?? 0).toString());
    discountCode = json['discount_code'];
    amount = double.tryParse((json['amount'] ?? 0.0).toString());
    surcharge = double.tryParse((json['surcharge'] ?? "").toString());
    createdAt = json['created_at'];
    objectImage = json['object_image'];
    isCheckPromotion = json['is_check_promotion'];
    isChangePrice = json['is_change_price'];
    referId = json['refer_id'];
    note = json['note'];
    orderDetailIdParent = json['order_detail_id_parent'];
    unitName = json['unit_name'];
    if (json['staffs'] != null) {
      staffs = <BookingStaffModel>[];
      json['staffs'].forEach((v) {
        staffs!.add(new BookingStaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_detail_id'] = this.orderDetailId;
    data['object_id'] = this.objectId;
    data['object_name'] = this.objectName;
    data['object_type'] = this.objectType;
    data['object_code'] = this.objectCode;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['discount'] = this.discount;
    data['discount_code'] = this.discountCode;
    data['amount'] = this.amount;
    data['surcharge'] = this.surcharge;
    data['created_at'] = this.createdAt;
    data['object_image'] = this.objectImage;
    data['is_check_promotion'] = this.isCheckPromotion;
    data['is_change_price'] = this.isChangePrice;
    data['refer_id'] = this.referId;
    data['note'] = this.note;
    data['order_detail_id_parent'] = this.orderDetailIdParent;
    data['unit_name'] = this.unitName;
    if (this.staffs != null) {
      data['staffs'] = this.staffs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderReceiptModel {
  double? amount;
  String? note;
  String? cardCode;
  String? status;
  String? receiptType;
  String? receiptDate;

  OrderReceiptModel(
      {this.amount,
      this.note,
      this.cardCode,
      this.status,
      this.receiptType,
      this.receiptDate});

  OrderReceiptModel.fromJson(Map<String, dynamic> json) {
    amount = double.tryParse((json['amount'] ?? 0.0).toString());
    note = json['note'];
    cardCode = json['card_code'];
    status = json['status'];
    receiptType = json['receipt_type'];
    receiptDate = json['receipt_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['card_code'] = this.cardCode;
    data['status'] = this.status;
    data['receipt_type'] = this.receiptType;
    data['receipt_date'] = this.receiptDate;
    return data;
  }
}

class OrderImageModel {
  int? orderImageId;
  String? type;
  String? link;
  File? file;

  OrderImageModel({this.orderImageId, this.type, this.link});

  OrderImageModel.fromJson(Map<String, dynamic> json) {
    orderImageId = json['order_image_id'];
    type = json['type'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_image_id'] = this.orderImageId;
    data['type'] = this.type;
    data['link'] = this.link;
    return data;
  }
}
