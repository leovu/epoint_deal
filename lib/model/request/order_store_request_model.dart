import 'booking_store_request_model.dart';

class OrderStoreRequestModel {
  int? orderId;
  String? brandCode;
  int? customerId;
  double? total;
  double? discountMember;
  double? discount;
  String? discountType;
  double? discountValue;
  String? discountCode;
  double? amount;
  String? customerContactCode;
  String? shippingAddress;
  String? contactName;
  String? contactPhone;
  String? fullAddress;
  String? typeTime;
  String? timeAddress;
  String? orderDate;
  double? tranportCharge;
  int? deliveryCostId;
  int? typeShipping;
  int? saleId;
  int? provinceId;
  int? districtId;
  int? wardId;
  int? referId;
  String? orderDescription;
  int? receiveAtCounter;
  String? orderObjectType;
  int? orderObjectId;
  String? orderObjectCode;
  List<OrderStoreModel>? detail;
  List<BookingOtherFeeModel>? otherFee;
  double? totalOtherFee;
  int? vatId;
  double? vat;
  String? totalTax;
  String? amountBeforeVat;

  OrderStoreRequestModel({
    this.orderId,
    this.brandCode,
    this.customerId,
    this.total,
    this.discountMember,
    this.discount,
    this.amount,
    this.discountType,
    this.discountValue,
    this.discountCode,
    this.customerContactCode,
    this.shippingAddress,
    this.contactName,
    this.contactPhone,
    this.fullAddress,
    this.typeTime,
    this.timeAddress,
    this.orderDate,
    this.tranportCharge,
    this.deliveryCostId,
    this.typeShipping,
    this.saleId,
    this.provinceId,
    this.districtId,
    this.wardId,
    this.referId,
    this.orderDescription,
    this.receiveAtCounter,
    this.orderObjectType,
    this.orderObjectId,
    this.orderObjectCode,
    this.detail,
    this.otherFee,
    this.totalOtherFee,
    this.vatId,
    this.vat,
    this.totalTax,
    this.amountBeforeVat,
  });

  OrderStoreRequestModel.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    brandCode = json['brand_code'];
    customerId = json['customer_id'];
    total = json['total'];
    discountMember = json['discount_member'];
    discount = json['discount'];
    amount = json['amount'];
    discountType = json['discount_type'];
    discountValue = double.tryParse((json['discount_value'] ?? "").toString());
    discountCode = json['discount_code'];
    customerContactCode = json['customer_contact_code'];
    shippingAddress = json['shipping_address'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    fullAddress = json['full_address'];
    typeTime = json['type_time'];
    timeAddress = json['time_address'];
    orderDate = json['order_date'];
    tranportCharge = json['tranport_charge'];
    deliveryCostId = json['delivery_cost_id'];
    typeShipping = json['type_shipping'];
    saleId = json['sale_id'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    referId = json['refer_id'];
    receiveAtCounter = json['receive_at_counter'];
    orderObjectType = json['order_object_type'];
    orderObjectId = json['order_object_id'];
    orderObjectCode = json['order_object_code'];
    orderDescription = json['order_description'];
    if (json['detail'] != null) {
      detail = <OrderStoreModel>[];
      json['detail'].forEach((v) {
        detail!.add(new OrderStoreModel.fromJson(v));
      });
    }
    if (json['other_fee'] != null) {
      otherFee = <BookingOtherFeeModel>[];
      json['other_fee'].forEach((v) {
        otherFee!.add(new BookingOtherFeeModel.fromJson(v));
      });
    }
    totalOtherFee = json['total_other_fee'];
    vatId = json['vat_id'];
    vat = json['vat'];
    totalTax = json['total_tax'];
    amountBeforeVat = json['amount_before_vat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['brand_code'] = this.brandCode;
    data['customer_id'] = this.customerId;
    data['total'] = this.total;
    data['discount_member'] = this.discountMember;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['discount_code'] = this.discountCode;
    data['customer_contact_code'] = this.customerContactCode;
    data['shipping_address'] = this.shippingAddress;
    data['contact_name'] = this.contactName;
    data['contact_phone'] = this.contactPhone;
    data['full_address'] = this.fullAddress;
    data['type_time'] = this.typeTime;
    data['time_address'] = this.timeAddress;
    data['order_date'] = this.orderDate;
    data['tranport_charge'] = this.tranportCharge;
    data['delivery_cost_id'] = this.deliveryCostId;
    data['type_shipping'] = this.typeShipping;
    data['sale_id'] = this.saleId;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    data['ward_id'] = this.wardId;
    data['refer_id'] = this.referId;
    data['receive_at_counter'] = this.receiveAtCounter;
    data['order_object_type'] = this.orderObjectType;
    data['order_object_id'] = this.orderObjectId;
    data['order_object_code'] = this.orderObjectCode;
    data['order_description'] = this.orderDescription;
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    if (this.otherFee != null) {
      data['other_fee'] = this.otherFee!.map((v) => v.toJson()).toList();
    }
    data['total_other_fee'] = this.totalOtherFee;
    data['vat_id'] = this.vatId;
    data['vat'] = this.vat;
    data['total_tax'] = this.totalTax;
    data['amount_before_vat'] = this.amountBeforeVat;
    return data;
  }
}

class OrderStoreModel {
  String? objectType;
  int? objectId;
  String? objectName;
  String? objectCode;
  double? quantity;
  double? price;
  String? discountType;
  double? discount;
  double? discountValue;
  String? discountCode;
  double? amount;
  double? surcharge;
  List<int>? staffId;
  String? note;

  OrderStoreModel(
      {this.objectType,
      this.objectId,
      this.objectName,
      this.objectCode,
      this.quantity,
      this.price,
        this.discountType,
        this.discount,
        this.discountValue,
        this.discountCode,
      this.amount,
      this.surcharge,
      this.staffId,
      this.note});

  OrderStoreModel.fromJson(Map<String, dynamic> json) {
    objectType = json['object_type'];
    objectId = json['object_id'];
    objectName = json['object_name'];
    objectCode = json['object_code'];
    quantity = json['quantity'];
    price = json['price'];
    discountType = json['discount_type'];
    discount = json['discount'];
    discountValue = double.tryParse((json['discount_value'] ?? "").toString());
    discountCode = json['discount_code'];
    amount = json['amount'];
    surcharge = json['surcharge'];
    staffId = json['staff_id']?.cast<int>();
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    data['object_name'] = this.objectName;
    data['object_code'] = this.objectCode;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['discount_value'] = this.discountValue;
    data['discount_code'] = this.discountCode;
    data['amount'] = this.amount;
    data['surcharge'] = this.surcharge;
    data['staff_id'] = this.staffId;
    data['note'] = this.note;
    return data;
  }
}
