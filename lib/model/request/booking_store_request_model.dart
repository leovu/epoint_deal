class BookingStoreRequestModel {
  int? customerAppointmentId;
  int? branchId;
  int? customerId;
  String? date;
  String? time;
  List<BookingStoreServiceNewModel>? service;
  int? appointmentSourceId;
  double? total;
  double? discount;
  double? amount;
  String? description;
  String? customerAppointmentType;
  String? status;
  int? vatId;
  double? vat;
  String? totalTax;
  String? amountBeforeVat;
  double? totalOtherFee;
  List<BookingStaffSaleModel>? staffSale;
  List<BookingOtherFeeModel>? otherFee;
  int? customerRefer;
  double? discountMember;
  String? discountType;
  double? discountValue;
  String? discountCode;
  int? appointmentPurposeId;

  BookingStoreRequestModel(
      {this.customerAppointmentId,
        this.branchId,
        this.customerId,
        this.date,
        this.time,
        this.service,
        this.appointmentSourceId,
        this.total,
        this.discount,
        this.amount,
        this.description,
        this.customerAppointmentType,
        this.status,
        this.vatId,
        this.vat,
        this.totalTax,
        this.amountBeforeVat,
        this.totalOtherFee,
        this.staffSale,
        this.otherFee,
        this.customerRefer,
        this.discountMember,
        this.discountType,
        this.discountValue,
        this.discountCode,
        this.appointmentPurposeId});

  BookingStoreRequestModel.fromJson(Map<String, dynamic> json) {
    customerAppointmentId = json['customer_appointment_id'];
    branchId = json['branch_id'];
    customerId = json['customer_id'];
    date = json['date'];
    time = json['time'];
    if (json['service'] != null) {
      service = <BookingStoreServiceNewModel>[];
      json['service'].forEach((v) {
        service!.add(new BookingStoreServiceNewModel.fromJson(v));
      });
    }
    appointmentSourceId = json['appointment_source_id'];
    total = json['total'];
    discount = json['discount'];
    amount = json['amount'];
    description = json['description'];
    customerAppointmentType = json['customer_appointment_type'];
    status = json['status'];
    vatId = json['vat_id'];
    vat = json['vat'];
    totalTax = json['total_tax'];
    amountBeforeVat = json['amount_before_vat'];
    totalOtherFee = json['total_other_fee'];
    if (json['staff_sale'] != null) {
      staffSale = <BookingStaffSaleModel>[];
      json['staff_sale'].forEach((v) {
        staffSale!.add(new BookingStaffSaleModel.fromJson(v));
      });
    }
    if (json['other_fee'] != null) {
      otherFee = <BookingOtherFeeModel>[];
      json['other_fee'].forEach((v) {
        otherFee!.add(new BookingOtherFeeModel.fromJson(v));
      });
    }
    customerRefer = json['customer_refer'];
    discountMember = json['discount_member'];
    discountType = json['discount_type'];
    discountValue = double.tryParse((json['discount_value'] ?? "").toString());
    discountCode = json['discount_code'];
    appointmentSourceId = json['appointment_purpose_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_appointment_id'] = this.customerAppointmentId;
    data['branch_id'] = this.branchId;
    data['customer_id'] = this.customerId;
    data['date'] = this.date;
    data['time'] = this.time;
    if (this.service != null) {
      data['service'] = this.service!.map((v) => v.toJson()).toList();
    }
    data['appointment_source_id'] = this.appointmentSourceId;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['description'] = this.description;
    data['customer_appointment_type'] = this.customerAppointmentType;
    data['status'] = this.status;
    data['vat_id'] = this.vatId;
    data['vat'] = this.vat;
    data['total_tax'] = this.totalTax;
    data['amount_before_vat'] = this.amountBeforeVat;
    data['total_other_fee'] = this.totalOtherFee;
    if (this.staffSale != null) {
      data['staff_sale'] = this.staffSale!.map((v) => v.toJson()).toList();
    }
    if (this.otherFee != null) {
      data['other_fee'] = this.otherFee!.map((v) => v.toJson()).toList();
    }
    data['customer_refer'] = this.customerRefer;
    data['discount_member'] = this.discountMember;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['discount_code'] = this.discountCode;
    data['appointment_purpose_id'] = this.appointmentPurposeId;
    return data;
  }
}

class BookingStoreServiceNewModel {
  double? price;
  String? objectType;
  int? objectId;
  String? objectCode;
  String? objectName;
  double? quantity;
  String? discountType;
  double? discount;
  double? discountValue;
  String? discountCode;
  double? surcharge;
  List<int>? staffId;
  int? roomId;
  String? description;
  double? amount;

  BookingStoreServiceNewModel(
      {this.price,
        this.objectType,
        this.objectId,
        this.objectCode,
        this.objectName,
        this.quantity,
        this.discountType,
        this.discount,
        this.discountValue,
        this.discountCode,
        this.surcharge,
        this.staffId,
        this.roomId,
        this.description,
        this.amount});

  BookingStoreServiceNewModel.fromJson(Map<String, dynamic> json) {
    price = json['price'];
    objectType = json['object_type'];
    objectId = json['object_id'];
    objectCode = json['object_code'];
    objectName = json['object_name'];
    quantity = json['quantity'];
    discountType = json['discount_type'];
    discount = json['discount'];
    discountValue = double.tryParse((json['discount_value'] ?? "").toString());
    discountCode = json['discount_code'];
    surcharge = json['surcharge'];
    staffId = json['staff_id'].cast<int>();
    roomId = json['room_id'];
    description = json['description'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['price'] = this.price;
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    data['object_code'] = this.objectCode;
    data['object_name'] = this.objectName;
    data['quantity'] = this.quantity;
    data['discount_type'] = this.discountType;
    data['discount'] = this.discount;
    data['discount_value'] = this.discountValue;
    data['discount_code'] = this.discountCode;
    data['surcharge'] = this.surcharge;
    data['staff_id'] = this.staffId;
    data['room_id'] = this.roomId;
    data['description'] = this.description;
    data['amount'] = this.amount;
    return data;
  }
}

class BookingStaffSaleModel {
  int? staffId;

  BookingStaffSaleModel({this.staffId});

  BookingStaffSaleModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    return data;
  }
}

class BookingOtherFeeModel {
  int? otherFeeId;
  String? value;
  String? vat;
  String? valueVat;
  String? totalValue;
  String? valueType;

  BookingOtherFeeModel(
      {this.otherFeeId, this.value, this.vat, this.valueVat, this.totalValue, this.valueType});

  BookingOtherFeeModel.fromJson(Map<String, dynamic> json) {
    otherFeeId = json['other_fee_id'];
    value = json['value'];
    vat = json['vat'];
    valueVat = json['value_vat'];
    totalValue = json['total_value'];
    valueType = json['value_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['other_fee_id'] = this.otherFeeId;
    data['value'] = this.value;
    data['vat'] = this.vat;
    data['value_vat'] = this.valueVat;
    data['total_value'] = this.totalValue;
    data['value_type'] = this.valueType;
    return data;
  }
}