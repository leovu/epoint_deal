


import 'package:epoint_deal_plugin/model/request/booking_customer_request_model.dart';
import 'package:epoint_deal_plugin/model/request/booking_detail_request_model.dart';
import 'package:epoint_deal_plugin/model/request/booking_list_date_request_model.dart';
import 'package:epoint_deal_plugin/model/request/booking_list_request_model.dart';
import 'package:epoint_deal_plugin/model/request/booking_staff_request_model.dart';
import 'package:epoint_deal_plugin/model/request/booking_store_request_model.dart';
import 'package:epoint_deal_plugin/model/request/booking_update_status_request_model.dart';
import 'package:epoint_deal_plugin/model/request/check_appointment_request_model.dart';
import 'package:epoint_deal_plugin/model/request/district_request_model.dart';
import 'package:epoint_deal_plugin/model/request/order_appointment_request_model.dart';
import 'package:epoint_deal_plugin/model/request/service_card_request_model.dart';
import 'package:epoint_deal_plugin/model/request/time_booking_request_model.dart';
import 'package:epoint_deal_plugin/model/request/ward_request_model.dart';
import 'package:epoint_deal_plugin/network/api/api.dart';
import 'package:epoint_deal_plugin/network/api/interaction.dart';
import 'package:flutter/material.dart';

class BookingResource{
  provinceFull(BuildContext? context) => Interaction(
      context: context,
      url: API.provinceFull()
  ).post();

  district(BuildContext? context, DistrictRequestModel model) => Interaction(
      context: context,
      url: API.district(),
      param: model.toJson()
  ).post();

  ward(BuildContext? context, WardRequestModel model) => Interaction(
      context: context,
      url: API.ward(),
      param: model.toJson()
  ).post();

  getAppointmentResource(BuildContext? context) => Interaction(
      context: context,
      url: API.getAppointmentResource()
  ).post();

  getStaff(BuildContext? context, BookingStaffRequestModel model) => Interaction(
      context: context,
      url: API.getStaff(),
      param: model.toJson()
  ).post();

  bookingList(BuildContext? context, BookingListRequestModel model) => Interaction(
      context: context,
      url: API.bookingList(),
      param: model.toJson()
  ).post();

  getRoom(BuildContext? context) => Interaction(
      context: context,
      url: API.getRoom(),
  ).post();

  bookingListDateRangeTime(BuildContext? context, BookingListDateRequestModel model) => Interaction(
      context: context,
      url: API.bookingListDateRangeTime(),
      param: model.toJson()
  ).post();

  timeBooking(BuildContext? context, TimeBookingRequestModel model) => Interaction(
      context: context,
      url: API.timeBooking(),
      param: model.toJson()
  ).post();

  bookingStore(BuildContext? context, BookingStoreRequestModel model) => Interaction(
      context: context,
      url: API.bookingStore(),
      param: model.toJson()
  ).post();

  checkAppointment(BuildContext? context, CheckAppointmentRequestModel model) => Interaction(
      context: context,
      url: API.checkAppointment(),
      param: model.toJson()
  ).post();

  bookingUpdate(BuildContext? context, BookingStoreRequestModel model) => Interaction(
      context: context,
      url: API.bookingUpdate(),
      param: model.toJson()
  ).post();

  bookingDetail(BuildContext? context, BookingDetailRequestModel model) => Interaction(
      context: context,
      url: API.bookingDetail(),
      param: model.toJson()
  ).post();

  bookingCustomer(BuildContext? context, BookingCustomerRequestModel model) => Interaction(
      context: context,
      url: API.bookingCustomer(),
      param: model.toJson()
  ).post();

  bookingUpdateStatus(BuildContext? context, BookingUpdateStatusRequestModel model) => Interaction(
      context: context,
      url: API.bookingUpdateStatus(),
      param: model.toJson()
  ).post();

  bookingStatus(BuildContext? context) => Interaction(
      context: context,
      url: API.bookingStatus()
  ).post();

  bookingServiceCard(BuildContext? context, ServiceCardRequestModel model) => Interaction(
      context: context,
      url: API.bookingServiceCard(),
      param: model.toJson()
  ).post();

  bookingOrderAppointment(BuildContext? context, OrderAppointmentRequestModel model) => Interaction(
      context: context,
      url: API.bookingOrderAppointment(),
      param: model.toJson()
  ).post();

  bookingListPurpose(BuildContext? context) => Interaction(
      context: context,
      url: API.bookingListPurpose(),
  ).post();
}