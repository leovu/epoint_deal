
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/utils/ultility.dart';
import 'package:flutter/material.dart';

import 'booking_staff_response_model.dart';

class BookingListResponseModel {
  List<BookingListModel>? data;

  BookingListResponseModel({this.data});

  BookingListResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <BookingListModel>[];
      json.forEach((v) {
        data!.add(new BookingListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingListModel {
  int? customerAppointmentId;
  String? customerAppointmentCode;
  String? branchName;
  String? appointmentSourceName;
  String? date;
  String? time;
  String? status;
  String? serviceUsingName;
  String? customerName;
  String? phone;
  String? customerTypeName;
  int? customerId;
  String? statusName;
  String? description;
  double? total;
  Color? colorPrimary;
  Color? colorSub;
  Color? colorText;
  List<BookingStatusUpdateModel>? statusUpdate;
  List<BookingAppointmentDetailModel>? appointmentDetail;
  BookingStylistModel? stylist;

  BookingListModel(
      {this.customerAppointmentId,
      this.customerAppointmentCode,
      this.branchName,
      this.appointmentSourceName,
      this.date,
      this.time,
      this.status,
      this.serviceUsingName,
      this.customerName,
      this.phone,
      this.customerTypeName,
      this.customerId,
      this.statusName,
      this.description,
      this.total,
      this.statusUpdate,
      this.appointmentDetail,
      this.stylist});

  BookingListModel.fromJson(Map<String, dynamic> json) {
    customerAppointmentId = json['customer_appointment_id'];
    customerAppointmentCode = json['customer_appointment_code'];
    branchName = json['branch_name'];
    appointmentSourceName = json['appointment_source_name'];
    date = json['date'];
    time = json['time'];
    status = json['status'];
    serviceUsingName = json['service_using_name'];
    customerName = json['customer_name'];
    phone = json['phone'];
    customerTypeName = json['customer_type_name'];
    customerId = json['customer_id'];
    statusName = json['status_name'];
    description = json['description'];
    total = double.tryParse((json['total'] ?? 0.0).toString());
    colorPrimary = stringToColor(json['status_primary_color']);
    colorSub = stringToColor(json['status_sub_color']);
    colorText = stringToColor(json['status_text_color'],
        defaultColor: AppColors.white);
    if (json['status_update'] != null) {
      statusUpdate = <BookingStatusUpdateModel>[];
      json['status_update'].forEach((v) {
        statusUpdate!.add(new BookingStatusUpdateModel.fromJson(v));
      });
    }
    if (json['appointment_detail'] != null) {
      appointmentDetail = <BookingAppointmentDetailModel>[];
      json['appointment_detail'].forEach((v) {
        appointmentDetail!.add(new BookingAppointmentDetailModel.fromJson(v));
      });
    }
    stylist =
        (json['stylist'] != null && json['stylist'] is Map<String, dynamic>)
            ? new BookingStylistModel.fromJson(json['stylist'])
            : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_appointment_id'] = this.customerAppointmentId;
    data['customer_appointment_code'] = this.customerAppointmentCode;
    data['branch_name'] = this.branchName;
    data['appointment_source_name'] = this.appointmentSourceName;
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    data['service_using_name'] = this.serviceUsingName;
    data['customer_name'] = this.customerName;
    data['phone'] = this.phone;
    data['customer_type_name'] = this.customerTypeName;
    data['customer_id'] = this.customerId;
    data['status_name'] = this.statusName;
    data['description'] = this.description;
    data['total'] = this.total;
    if (this.statusUpdate != null) {
      data['status_update'] =
          this.statusUpdate!.map((v) => v.toJson()).toList();
    }
    if (this.appointmentDetail != null) {
      data['appointment_detail'] =
          this.appointmentDetail!.map((v) => v.toJson()).toList();
    }
    if (this.stylist != null) {
      data['stylist'] = this.stylist!.toJson();
    }
    return data;
  }
}

class BookingStatusUpdateModel {
  String? status;
  String? statusName;
  Color? colorPrimary;
  Color? colorSub;
  Color? colorText;

  BookingStatusUpdateModel(
      {this.status,
      this.statusName,
      this.colorPrimary,
      this.colorSub,
      this.colorText});

  BookingStatusUpdateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    statusName = json['status_name'];
    colorPrimary = stringToColor(json['status_primary_color']);
    colorSub = stringToColor(json['status_sub_color']);
    colorText = stringToColor(json['status_text_color'],
        defaultColor: AppColors.white);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['status_name'] = this.statusName;
    return data;
  }
}

class BookingAppointmentDetailModel {
  String? serviceName;
  int? staffId;
  String? staffName;
  int? roomId;
  String? roomName;
  int? customerNumber;
  int? time;
  String? serviceAvatar;
  double? price;
  double? amount;
  double? quantity;
  int? serviceId;
  String? objectType;
  int? objectId;
  String? objectCode;
  String? staffAvatar;
  double? surcharge;
  String? discountType;
  double? discountValue;
  double? discount;
  String? discountCode;
  String? description;
  List<BookingStaffModel>? staffs;

  BookingAppointmentDetailModel(
      {this.serviceName,
      this.staffId,
      this.staffName,
      this.roomId,
      this.roomName,
      this.customerNumber,
      this.time,
      this.serviceAvatar,
      this.price,
      this.amount,
      this.quantity,
      this.serviceId,
      this.objectType,
      this.objectId,
      this.objectCode,
      this.staffAvatar,
      this.surcharge,
      this.discountType,
      this.discountValue,
      this.discount,
      this.discountCode,
      this.description,
      this.staffs});

  BookingAppointmentDetailModel.fromJson(Map<String, dynamic> json) {
    serviceName = json['service_name'];
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    roomId = json['room_id'];
    roomName = json['room_name'];
    customerNumber = json['customer_number'];
    time = json['time'];
    serviceAvatar = json['service_avatar'];
    price = double.tryParse((json['price'] ?? 0).toString());
    amount = double.tryParse((json['amount'] ?? 0).toString());
    quantity = double.tryParse((json['quantity'] ?? 0).toString());
    serviceId = json['service_id'];
    objectType = json['object_type'];
    objectId = json['object_id'];
    objectCode = json['object_code'];
    staffAvatar = json['staff_avatar'];
    surcharge = double.tryParse((json['surcharge'] ?? 0).toString());
    discountType = json['discount_type'];
    discountValue = double.tryParse((json['discount_value'] ?? "").toString());
    discount = double.tryParse((json['discount'] ?? 0).toString());
    discountCode = json['discount_code'];
    description = json['description'];
    if (json['staffs'] != null) {
      staffs = <BookingStaffModel>[];
      json['staffs'].forEach((v) {
        staffs!.add(new BookingStaffModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_name'] = this.serviceName;
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['room_id'] = this.roomId;
    data['room_name'] = this.roomName;
    data['customer_number'] = this.customerNumber;
    data['time'] = this.time;
    data['service_avatar'] = this.serviceAvatar;
    data['price'] = this.price;
    data['amount'] = this.amount;
    data['quantity'] = this.quantity;
    data['service_id'] = this.serviceId;
    data['object_type'] = this.objectType;
    data['object_id'] = this.objectId;
    data['object_code'] = this.objectCode;
    data['staff_avatar'] = this.staffAvatar;
    data['surcharge'] = this.surcharge;
    data['discount_type'] = this.discountType;
    data['discount_value'] = this.discountValue;
    data['discount'] = this.discount;
    data['discount_code'] = this.discountCode;
    data['description'] = this.description;
    if (this.staffs != null) {
      data['staffs'] = this.staffs!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookingStylistModel {
  int? staffId;
  String? staffName;
  String? staffAvatar;
  String? roomName;
  int? roomId;

  BookingStylistModel(
      {this.staffId,
      this.staffName,
      this.staffAvatar,
      this.roomName,
      this.roomId});

  BookingStylistModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    staffName = json['staff_name'];
    staffAvatar = json['staff_avatar'];
    roomName = json['room_name'];
    roomId = json['room_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['staff_name'] = this.staffName;
    data['staff_avatar'] = this.staffAvatar;
    data['room_name'] = this.roomName;
    data['room_id'] = this.roomId;
    return data;
  }
}

class BookingListByStaffModel {
  BookingStylistModel? staffModel;
  List<BookingListModel>? models;

  BookingListByStaffModel({this.staffModel, this.models});
}
