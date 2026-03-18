
import 'package:epoint_deal_plugin/model/response/booking_list_response_model.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:flutter/material.dart';

import '../../../common/theme.dart';

class BookingDetailResponseModel {
  int? customerAppointmentId;
  String? customerAppointmentCode;
  int? branchId;
  int? customerId;
  String? branchName;
  String? appointmentSourceName;
  String? customerAppointmentType;
  String? date;
  String? time;
  String? status;
  String? statusPrimaryColor;
  String? statusSubColor;
  String? statusTextColor;
  int? customerQuantity;
  double? total;
  double? totalTax;
  double? discount;
  double? discountValue;
  String? discountType;
  String? discountCode;
  double? amount;
  double? discountMember;
  double? totalOtherFee;
  double? amountBeforeVat;
  String? branchProvinceName;
  String? branchDistrictName;
  String? branchAddress;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? groupName;
  String? description;
  int? appointmentSourceId;
  String? serviceUsingName;
  String? customerType;
  String? customerTypeName;
  String? customerName;
  String? customerAvatar;
  String? phone;
  String? birthday;
  String? email;
  String? address;
  String? customerCode;
  String? provinceType;
  String? provinceName;
  String? districtType;
  String? districtName;
  String? wardType;
  String? wardName;
  String? fullAddress;
  int? point;
  int? isCancel;
  int? isEdit;
  int? isOrder;
  String? statusName;
  List<BookingStatusUpdateModel>? statusUpdate;
  int? isReview;
  int? isRating;
  List<BookingAppointmentDetailModel>? appointmentDetail;
  BookingStylistModel? stylist;
  List<BookingLogModel>? log;
  Color? colorPrimary, colorSub, colorText;
  int? customerRefer;
  String? customerReferName;
  List<BookingDetailStaffModel>? staffSale;
  List<BookingDetailFeeModel>? otherFee;
  int? vatId;
  String? vat;
  String? vatDescription;
  int? serviceCardActivedQuantity;
  int? appointmentPurposeId;
  String? appointmentPurposeName;

  BookingDetailResponseModel(
      {this.customerAppointmentId,
      this.customerAppointmentCode,
      this.branchId,
      this.customerId,
      this.branchName,
      this.appointmentSourceName,
      this.customerAppointmentType,
      this.date,
      this.time,
      this.status,
      this.statusPrimaryColor,
      this.statusSubColor,
      this.statusTextColor,
      this.customerQuantity,
      this.total,
      this.totalTax,
      this.discount,
      this.discountValue,
      this.discountType,
      this.discountCode,
      this.amount,
      this.discountMember,
      this.totalOtherFee,
      this.amountBeforeVat,
      this.branchProvinceName,
      this.branchDistrictName,
      this.branchAddress,
      this.createdAt,
      this.updatedAt,
      this.createdBy,
      this.updatedBy,
      this.staffCreatedName,
      this.staffUpdatedName,
      this.groupName,
      this.description,
      this.appointmentSourceId,
      this.serviceUsingName,
      this.customerType,
      this.customerTypeName,
      this.customerName,
      this.customerAvatar,
      this.phone,
      this.birthday,
      this.email,
      this.address,
      this.customerCode,
      this.provinceType,
      this.provinceName,
      this.districtType,
      this.districtName,
      this.wardType,
      this.wardName,
      this.fullAddress,
      this.point,
      this.isCancel,
      this.isEdit,
      this.isOrder,
      this.statusName,
      this.statusUpdate,
      this.isReview,
      this.isRating,
      this.appointmentDetail,
      this.stylist,
      this.log,
      this.customerRefer,
      this.customerReferName,
      this.staffSale,
      this.otherFee,
      this.vatId,
      this.vat,
      this.vatDescription,
      this.serviceCardActivedQuantity,
      this.appointmentPurposeId,
      this.appointmentPurposeName});

  BookingDetailResponseModel.fromJson(Map<String, dynamic> json) {
    customerAppointmentId = json['customer_appointment_id'];
    customerAppointmentCode = json['customer_appointment_code'];
    branchId = json['branch_id'];
    customerId = json['customer_id'];
    branchName = json['branch_name'];
    appointmentSourceName = json['appointment_source_name'];
    customerAppointmentType = json['customer_appointment_type'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    statusPrimaryColor = json['status_primary_color'];
    statusSubColor = json['status_sub_color'];
    statusTextColor = json['status_text_color'];
    customerQuantity = json['customer_quantity'];
    total = double.tryParse((json['total'] ?? 0.0).toString());
    totalTax = double.tryParse((json['total_tax'] ?? 0.0).toString());
    discount = json['discount'] == null
        ? null
        : double.tryParse(json['discount'].toString());
    discountValue = double.tryParse((json['discount_value'] ?? "").toString());
    discountType = json['discount_type'];
    discountCode = json['discount_code'];
    amount = double.tryParse((json['amount'] ?? 0.0).toString());
    discountMember =
        double.tryParse((json['discount_member'] ?? 0.0).toString());
    totalOtherFee =
        double.tryParse((json['total_other_fee'] ?? 0.0).toString());
    amountBeforeVat =
        double.tryParse((json['amount_before_vat'] ?? 0.0).toString());
    branchProvinceName = json['branch_province_name'];
    branchDistrictName = json['branch_district_name'];
    branchAddress = json['branch_address'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    groupName = json['group_name'];
    description = json['description'];
    appointmentSourceId = json['appointment_source_id'];
    serviceUsingName = json['service_using_name'];
    customerType = json['customer_type'];
    customerTypeName = json['customer_type_name'];
    customerName = json['customer_name'];
    customerAvatar = json['customer_avatar'];
    phone = json['phone'];
    birthday = json['birthday'];
    email = json['email'];
    address = json['address'];
    customerCode = json['customer_code'];
    provinceType = json['province_type'];
    provinceName = json['province_name'];
    districtType = json['district_type'];
    districtName = json['district_name'];
    wardType = json['ward_type'];
    wardName = json['ward_name'];
    fullAddress = json['full_address'];
    point = json['point'];
    isCancel = json['is_cancel'];
    isEdit = json['is_edit'];
    isOrder = json['is_order'];
    statusName = json['status_name'];
    if (json['status_update'] != null) {
      statusUpdate = <BookingStatusUpdateModel>[];
      json['status_update'].forEach((v) {
        statusUpdate!.add(new BookingStatusUpdateModel.fromJson(v));
      });
    }
    isReview = json['is_review'];
    isRating = json['is_rating'];
    if (json['appointment_detail'] != null) {
      appointmentDetail = <BookingAppointmentDetailModel>[];
      json['appointment_detail'].forEach((v) {
        appointmentDetail!.add(new BookingAppointmentDetailModel.fromJson(v));
      });
    }
    stylist = json['stylist'] != null
        ? new BookingStylistModel.fromJson(json['stylist'])
        : null;
    if (json['log'] != null) {
      log = <BookingLogModel>[];
      json['log'].forEach((v) {
        log!.add(new BookingLogModel.fromJson(v));
      });
    }
    colorPrimary = stringToColor(json['status_primary_color']);
    colorSub = stringToColor(json['status_sub_color']);
    colorText = stringToColor(json['status_text_color'],
        defaultColor: AppColors.white);
    customerRefer = json['customer_refer'];
    customerReferName = json['customer_refer_name'];
    if (json['staff_sale'] != null) {
      staffSale = <BookingDetailStaffModel>[];
      json['staff_sale'].forEach((v) {
        staffSale!.add(new BookingDetailStaffModel.fromJson(v));
      });
    }
    if (json['other_fee'] != null) {
      otherFee = <BookingDetailFeeModel>[];
      json['other_fee'].forEach((v) {
        otherFee!.add(new BookingDetailFeeModel.fromJson(v));
      });
    }
    vatId = json['vat_id'];
    vat = json['vat'];
    vatDescription = json['vat_description'];
    serviceCardActivedQuantity = json['service_card_actived_quantity'];
    appointmentPurposeId = json['appointment_purpose_id'];
    appointmentPurposeName = json['appointment_purpose_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_appointment_id'] = this.customerAppointmentId;
    data['customer_appointment_code'] = this.customerAppointmentCode;
    data['branch_id'] = this.branchId;
    data['customer_id'] = this.customerId;
    data['branch_name'] = this.branchName;
    data['appointment_source_name'] = this.appointmentSourceName;
    data['customer_appointment_type'] = this.customerAppointmentType;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    data['status_primary_color'] = this.statusPrimaryColor;
    data['status_sub_color'] = this.statusSubColor;
    data['status_text_color'] = this.statusTextColor;
    data['customer_quantity'] = this.customerQuantity;
    data['total'] = this.total;
    data['total_tax'] = this.totalTax;
    data['discount'] = this.discount;
    data['discount_value'] = this.discountValue;
    data['discount_type'] = this.discountType;
    data['discount_code'] = this.discountCode;
    data['amount'] = this.amount;
    data['discount_member'] = this.discountMember;
    data['total_other_fee'] = this.totalOtherFee;
    data['amount_before_vat'] = this.amountBeforeVat;
    data['branch_province_name'] = this.branchProvinceName;
    data['branch_district_name'] = this.branchDistrictName;
    data['branch_address'] = this.branchAddress;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['group_name'] = this.groupName;
    data['description'] = this.description;
    data['appointment_source_id'] = this.appointmentSourceId;
    data['service_using_name'] = this.serviceUsingName;
    data['customer_type'] = this.customerType;
    data['customer_type_name'] = this.customerTypeName;
    data['customer_name'] = this.customerName;
    data['customer_avatar'] = this.customerAvatar;
    data['phone'] = this.phone;
    data['birthday'] = this.birthday;
    data['email'] = this.email;
    data['address'] = this.address;
    data['customer_code'] = this.customerCode;
    data['province_type'] = this.provinceType;
    data['province_name'] = this.provinceName;
    data['district_type'] = this.districtType;
    data['district_name'] = this.districtName;
    data['ward_type'] = this.wardType;
    data['ward_name'] = this.wardName;
    data['full_address'] = this.fullAddress;
    data['point'] = this.point;
    data['is_cancel'] = this.isCancel;
    data['is_edit'] = this.isEdit;
    data['is_order'] = this.isOrder;
    data['status_name'] = this.statusName;
    if (this.statusUpdate != null) {
      data['status_update'] =
          this.statusUpdate!.map((v) => v.toJson()).toList();
    }
    data['is_review'] = this.isReview;
    data['is_rating'] = this.isRating;
    if (this.appointmentDetail != null) {
      data['appointment_detail'] =
          this.appointmentDetail!.map((v) => v.toJson()).toList();
    }
    if (this.stylist != null) {
      data['stylist'] = this.stylist!.toJson();
    }
    if (this.log != null) {
      data['log'] = this.log!.map((v) => v.toJson()).toList();
    }
    data['customer_refer'] = this.customerRefer;
    data['customer_refer_name'] = this.customerReferName;
    if (this.staffSale != null) {
      data['staff_sale'] = this.staffSale!.map((v) => v.toJson()).toList();
    }
    if (this.otherFee != null) {
      data['other_fee'] = this.otherFee!.map((v) => v.toJson()).toList();
    }
    data['vat_id'] = this.vatId;
    data['vat'] = this.vat;
    data['vat_description'] = this.vatDescription;
    data['service_card_actived_quantity'] = this.serviceCardActivedQuantity;
    data['appointment_purpose_id'] = this.appointmentPurposeId;
    data['appointment_purpose_name'] = this.appointmentPurposeName;
    return data;
  }
}

class BookingLogModel {
  int? id;
  String? status;
  String? createdAt;
  String? note;

  BookingLogModel({this.id, this.status, this.createdAt, this.note});

  BookingLogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    createdAt = json['created_at'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['note'] = this.note;
    return data;
  }
}

class BookingDetailStaffModel {
  int? customerAppointmentStaffId;
  int? customerAppointmentId;
  int? staffId;
  String? staffName;

  BookingDetailStaffModel(
      {this.customerAppointmentStaffId,
      this.customerAppointmentId,
      this.staffId,
      this.staffName});

  BookingDetailStaffModel.fromJson(Map<String, dynamic> json) {
    customerAppointmentStaffId = json['customer_appointment_staff_id'];
    customerAppointmentId = json['customer_appointment_id'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_appointment_staff_id'] = this.customerAppointmentStaffId;
    data['customer_appointment_id'] = this.customerAppointmentId;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    return data;
  }
}

class BookingDetailFeeModel {
  int? customerAppointmentOtherFeeId;
  int? customerAppointmentId;
  int? otherFeeId;
  double? value;
  String? vat;
  double? valueVat;
  double? totalValue;
  String? otherFeeCode;
  String? otherFeeName;
  String? otherFeeVat;
  String? otherFeeValue;
  String? otherFeeIncludeVat;
  String? valueType;

  BookingDetailFeeModel(
      {this.customerAppointmentOtherFeeId,
      this.customerAppointmentId,
      this.otherFeeId,
      this.value,
      this.vat,
      this.valueVat,
      this.totalValue,
      this.otherFeeCode,
      this.otherFeeName,
      this.otherFeeVat,
      this.otherFeeValue,
      this.otherFeeIncludeVat,
      this.valueType});

  BookingDetailFeeModel.fromJson(Map<String, dynamic> json) {
    customerAppointmentOtherFeeId = json['customer_appointment_other_fee_id'];
    customerAppointmentId = json['customer_appointment_id'];
    otherFeeId = json['other_fee_id'];
    value = double.tryParse((json['value'] ?? "").toString());
    vat = json['vat'];
    valueVat = double.tryParse((json['value_vat'] ?? "").toString());
    totalValue = double.tryParse((json['total_value'] ?? "").toString());
    otherFeeCode = json['other_fee_code'];
    otherFeeName = json['other_fee_name'];
    otherFeeVat = json['other_fee_vat'];
    otherFeeValue = json['other_fee_value'];
    otherFeeIncludeVat = json['other_fee_include_vat'];
    valueType = json['value_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_appointment_other_fee_id'] =
        this.customerAppointmentOtherFeeId;
    data['customer_appointment_id'] = this.customerAppointmentId;
    data['other_fee_id'] = this.otherFeeId;
    data['value'] = this.value;
    data['vat'] = this.vat;
    data['value_vat'] = this.valueVat;
    data['total_value'] = this.totalValue;
    data['other_fee_code'] = this.otherFeeCode;
    data['other_fee_name'] = this.otherFeeName;
    data['other_fee_vat'] = this.otherFeeVat;
    data['other_fee_value'] = this.otherFeeValue;
    data['other_fee_include_vat'] = this.otherFeeIncludeVat;
    data['value_type'] = this.valueType;
    return data;
  }
}
