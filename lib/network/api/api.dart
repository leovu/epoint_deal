import 'package:epoint_deal_plugin/common/localization/global.dart';

class API {

   static String? get server => Global.domain;
  static int get successCode => 0;
  static int get noDataCode => 1;

    // Order
  static getOrder() => "order";
  static getOrderDetail() => "order/detail-v3";
  static getService() => "service/get-services";
  static getProduct() => "product/get-products";
  static productCategory() => "product/product-category/list";
  static getMemberDiscount() => "order/get-discount-member";
  static orderStore() => "order/store-v3";
  static orderUpdate() => "order/update-v3";
  static getPrintOrder() => "order/print-info";
  static uploadPhotoOrder() => "order/upload-image-v2";
  static checkVoucher() => "order/get-voucher";
  static removePhotoOrder() => "order/remove-image";
  static destroyOrder() => "order/cancel";
  static createQRCode() => "order/create-qr-code";
  static getStatusVNPay() => "order/get-status-vn-pay";
  static getTransportMethod() => "order/get-transport-method";
  static productDetail() => "product/product-detail";
  static serviceDetail() => "service/detail";
  static printDevices() => "order/print/devices";
  static serviceCategory() => "service/service-category";
  static orderConfig() => "order/get-order-config";
  static orderServiceCard() => "order/service-card";
  static orderServiceCardDetail() => "order/service-card-detail";
  static orderServiceCardUsing() => "order/service-card-using";
  static orderServiceCardDetailActive() => "order/service-card-detail-active";
  static orderStaff() => "order/get-staff";
  static orderVAT() => "order/vat";
  static config() => "order/config";
  static otherFreeBranch() => "order/other-free-branch";
  static sendRating() => "api/zns/send-rating";

    // Booking
  static provinceFull() => "booking/province-full";
  static district() => "booking/district";
  static ward() => "booking/ward";
  static getAppointmentResource() => "booking/get-appointment-source";
  static getStaff() => "booking/get-staff";
  static bookingList() => "booking/list-date-week-month";
  static getRoom() => "booking/get-room";
  static bookingListDateRangeTime() => "booking/list-date-range-time";
  static timeBooking() => "booking/time-booking";
  static bookingStore() => "booking/store-v2";
  static checkAppointment() => "booking/check-appointment";
  static bookingUpdate() => "booking/update-v2";
  static bookingDetail() => "booking/detail-v2";
  static bookingCustomer() => "booking/list-booking-customer";
  static bookingUpdateStatus() => "booking/update-status";
  static bookingStatus() => "booking/get-status";
  static bookingServiceCard() => "booking/list-customer-service-card";
  static bookingOrderAppointment() => "booking/order-appointment";
  static bookingListPurpose() => "booking/get-list-purpose";

    //Payment
  static getPaymentMethod() => "order/payment-method";
  static payment() => "order/order-payment-v2";
  static checkTransportCharge() => "order/check-transport-charge";

    // Warranty
  // static warrantyCard() => "warranty/warranty-card/get-warranty-card";
  // static warrantyCardCustomer() => "warranty/maintenance/get-warranty-card-customer";
  // static warrantyPackage() => "warranty/warranty-card/get-package";
  // static warrantyStatus() => "warranty/warranty-card/list-status";
  // static warrantyQuickUpdate() => "warranty/warranty-card/quick-update";
  // static warrantyDetail() => "warranty/warranty-card/detail";
  // static warrantyUpdate() => "warranty/warranty-card/update";
  // static maintenance() => "warranty/maintenance/get-maintenance";
  // static maintenanceStatus() => "warranty/maintenance/list-status";
  // static maintenanceDetail() => "warranty/maintenance/detail";
  // static maintenanceCostType() => "warranty/maintenance/get-cost-type";
  // static maintenanceStore() => "warranty/maintenance/store";
  // static maintenanceUpdate() => "warranty/maintenance/update";
  static maintenanceReceipt() => "warranty/maintenance/receipt";
}