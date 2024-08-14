class CreateOrderRequestModel {
  String? brandCode;
  int? customerId;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? orderCode;
  int? orderId;
  double? total;
  double? discountMember;
  double? discount;
  double? amount;
  String? voucherCode;
  String? customerContactCode;
  String? contactName;
  String? contactPhone;
  String? fullAddress;
  String? branchCode;
  int? paymentMethodId;
  double? transportCharge;
  int? typeShipping;
  int? deliveryCostId;
  String? orderDescription;
  String? processStatus;
  int? deliveryActive;
  List<Detail>? detail;

  CreateOrderRequestModel(
      {this.brandCode,
      this.customerId,
      this.customerName,
      this.customerPhone,
      this.customerAddress,
      this.total,
      this.discountMember,
      this.discount,
      this.amount,
      this.voucherCode,
      this.customerContactCode,
      this.contactName,
      this.contactPhone,
      this.fullAddress,
      this.branchCode,
      this.paymentMethodId,
      this.transportCharge,
      this.typeShipping,
      this.deliveryCostId,
      this.orderId,
      this.orderCode,
      this.detail,
      this.processStatus,
      this.deliveryActive,
      this.orderDescription});

  CreateOrderRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    customerId = json['customer_id'];
    total = json['total'];
    discountMember = json['discount_member'];
    discount = json['discount'];
    amount = json['amount'];
    voucherCode = json['voucher_code'];
    customerContactCode = json['customer_contact_code'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    fullAddress = json['full_address'];
    branchCode = json['branch_code'];
    paymentMethodId = json['payment_method_id'];
    transportCharge = json['transport_charge'];
    deliveryCostId = json['delivery_cost_id'];
    typeShipping = json['type_shipping'];
    processStatus = json['process_status'];
    deliveryActive = json['delivery_active'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    if (json['detail'] != null) {
      detail = <Detail>[];
      json['detail'].forEach((v) {
        detail!.add(new Detail.fromJson(v));
      });
    }
    orderDescription = json['order_description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['customer_id'] = this.customerId;
    data['total'] = this.total;
    data['discount_member'] = this.discountMember;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['voucher_code'] = this.voucherCode;
    data['customer_contact_code'] = this.customerContactCode;
    data['contact_name'] = this.contactName;
    data['contact_phone'] = this.contactPhone;
    data['full_address'] = this.fullAddress;
    data['branch_code'] = this.branchCode;
    data['payment_method_id'] = this.paymentMethodId;
    data['transport_charge'] = this.transportCharge;
    data['delivery_cost_id'] = this.deliveryCostId;
    data['type_shipping'] = this.typeShipping;
    if (this.orderId != null) {
      data['order_id'] = this.orderId;
    }
    if (this.orderCode != null) {
      data['order_code'] = this.orderCode;
    }
    if (this.processStatus != null) {
      data['process_status'] = this.processStatus;
    }
    if (this.deliveryActive != null) {
      data['delivery_active'] = this.deliveryActive;
    }
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    data['order_description'] = this.orderDescription;
    return data;
  }
}

class Detail {
  String? objectType;
  int? objectId;
  String? objectName;
  String? objectCode;
  double? quantity;
  double? price;
  double? discount;
  double? amount;
  String? note;
  List<AttachOrderModel>? attach;

  Detail(
      {this.objectType,
      this.objectId,
      this.objectName,
      this.objectCode,
      this.quantity,
      this.price,
      this.discount,
      this.amount,
      this.note,
      this.attach});

  Detail.fromJson(Map<String, dynamic> json) {
    objectType = json['object_type'];
    objectId = json['object_id'];
    objectName = json['object_name'];
    objectCode = json['object_code'];
    quantity = json['quantity'];
    price = json['price'];
    discount = json['discount'];
    amount = json['amount'];
    note = json['note'];
    if (json['attach'] != null) {
      attach = <AttachOrderModel>[];
      json['attach'].forEach((v) {
        attach!.add(new AttachOrderModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    data['object_name'] = this.objectName;
    data['object_code'] = this.objectCode;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['note'] = this.note;
    if (this.attach != null) {
      data['attach'] = this.attach!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AttachOrderModel {
  int? objectId;
  String? objectName;
  String? objectType;
  String? objectCode;
  double? price;
  int? quantity;
  double? amount;

  AttachOrderModel(
      {this.objectId,
        this.objectName,
        this.objectType,
        this.objectCode,
        this.price,
        this.quantity,
        this.amount});

  AttachOrderModel.fromJson(Map<String, dynamic> json) {
    objectId = json['object_id'];
    objectName = json['object_name'];
    objectType = json['object_type'];
    objectCode = json['object_code'];
    price = double.tryParse((json['price'] ?? 0.0).toString());
    quantity = json['quantity'];
    amount = double.tryParse((json['amount'] ?? 0.0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_id'] = this.objectId;
    data['object_name'] = this.objectName;
    data['object_type'] = this.objectType;
    data['object_code'] = this.objectCode;
    data['price'] = this.price;
    data['quantity'] = this.quantity;
    data['amount'] = this.amount;
    return data;
  }
}