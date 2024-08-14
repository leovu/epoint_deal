
import 'package:epoint_deal_plugin/common/globals.dart';
import 'package:epoint_deal_plugin/common/localization/global.dart';
import 'package:collection/collection.dart';

class VisibilityWidgetName {
  static const String LE000000 = "LE000000"; //Code KHTN
  static const String LE000001 = "LE000001"; //Tạo KHTN
  static const String LE000002 = "LE000002"; //Xem chi tiết KHTN
  static const String LE000003 = "LE000003"; //Tab thông tin chi tiết KHTN
  static const String LE000004 = "LE000004"; //Tab cơ hội bán hàng chi tiết KHTN
  static const String LE000005 = "LE000005"; //Xem chi tiết CHBH
  static const String LE000006 = "LE000006"; //Tab chăm sóc khách hàng
  static const String LE000007 = "LE000007"; //Xem chi tiết chăm sóc khách hàng
  static const String LE000008 = "LE000008"; //Chỉnh sửa Chăm sóc khách hàng
  static const String LE000009 = "LE000009"; //Tab trao đổi
  static const String LE000010 = "LE000010"; //Tab Người liên hệ
  static const String LE000011 = "LE000011"; //Tạo CHBH asisitive touch
  static const String LE000012 = "LE000012"; //Tạo CSKH
  static const String LE000013 = "LE000013"; //Xóa KHTN
  static const String LE000014 = "LE000014"; //Chỉnh sửa KHTN

   static const String CM000000 = "CM000000"; //Khóa/bật chức năng khách hàng
  static const String CM000001 = "CM000001"; //Tạo khách hàng
  static const String CM000002 = "CM000002"; //Xem chi tiết khách hàng
  static const String CM000003 = "CM000003"; //Chỉnh sửa khách hàng
  static const String CM000004 = "CM000004"; //Xem liên hệ khách hàng
  static const String CM000005 = "CM000005"; //Chỉnh sửa liên hệ khách hàng
  static const String CM000006 = "CM000006"; //Cập nhật người giới thiệu khách hàng
  static const String CM000007 = "CM000007"; //Xem thông tin giá trị đơn hàng
  static const String OD000000 = "OD000000"; //Khóa/bật chức năng đơn hàng
  static const String OD000001 = "OD000001"; //Tạo đơn hàng
  static const String OD000002 = "OD000002"; //Xem chi tiết đơn hàng
  static const String OD000004 = "OD000004"; //Thanh toán đơn hàng
  static const String OD000005 = "OD000005"; //Xem danh sách sản phẩm
  static const String OD000007 = "OD000007"; //Xem hình ảnh đơn hàng
  static const String OD000008 = "OD000008"; //Chỉnh sửa và upload hình ảnh đơn hàng
  static const String OD000009 = "OD000009"; //Xem thông tin giá trị đơn hàng
  static const String RP000000 = "RP000000"; //Khóa/bật chức năng báo cáo
  static const String RP000001 = "RP000001"; //Xem doanh thu bán hàng
  static const String RP000002 = "RP000002"; //Xem hoa hồng
  static const String RP000003 = "RP000003"; //Xem tồn kho
  static const String TK000000 = "TK000000"; //Ticket
  static const String TK000001 = "TK000001"; //Ticket của tôi
  static const String TK000002 = "TK000002"; //Ticket chưa phân công
  static const String TK000003 = "TK000003"; //Ticket chưa hoàn thành
  static const String TK000004 = "TK000004"; //Danh sách ticket
  static const String WK000000 = "WK000000"; //Công việc
  static const String WK000001 = "WK000001"; //Việc của tôi
  static const String WK000002 = "WK000002"; //Phê duyệt công việc
  static const String WK000003 = "WK000003"; //Tạo công việc
  static const String WK000004 = "WK000004"; //Tổng quan công việc
  static const String WK000005 = "WK000005"; //Danh sách công việc
  static const String WK000006 = "WK000006"; //Công việc tôi giao
  static const String WK000007 = "WK000007"; //Xem nhắc nhở
  static const String WK000008 = "WK000008"; //Danh sách dự án
  static const String TI000000 = "TI000000"; //Chấm công
  static const String TI000001 = "TI000001"; //Lịch sử chấm công
  static const String CH000000 = "CH000000"; //Chat
  static const String SY000000 = "SY000000"; //Khảo sát
  static const String AP000000 = "AP000000"; //Đơn phép của tôi
  static const String AP000001 = "AP000001"; //Tạo đơn phép
  static const String AP000002 = "AP000002"; //Phê duyệt đơn phép
  static const String BK000000 = "BK000000"; //Tạo lịch hẹn
  static const String BK000001 = "BK000001"; //Danh sách lịch hẹn
  static const String DO000000 = "DO000000"; //Quản lý tài liệu
  static const String WA000000 = "WA000000"; //Bảo hành
  static const String WA000001 = "WA000001"; //Quét mã bảo hành
  static const String MA000000 = "MA000000"; //Bảo trì
  static const String CH000001 = "CH000001"; //Chat Hub
  static const String DE000000 = "DE000000"; //Cơ hội bán hàng
  static const String PR000000 = "PR000000"; //Quản lý dự án
  static const String PR000001 = "PR000001"; //Thêm dự án
}

bool checkVisibilityKey(String key) {

  bool returnCheck = false;
  try{
    final model = Global.permissionModels!.firstWhere((element) => element['widget_id'] == key);
    if(model != null){
      returnCheck = true;
    }
  }
  catch(_){}
  return returnCheck;
}

class ConfigKey {
  static const String vat = "vat";
  static const String discount = "discount"; // Giảm giá cho sản phẩm/dịch vụ
  static const String discount_voucher = "discount_voucher"; // Giảm giá Voucher cho sản phẩm/dịch vụ
  static const String discount_direct_money = "discount_direct_money"; // Giảm giá trực tiếp cho sản phẩm/dịch vụ
  static const String discount_direct_percent = "discount_direct_money"; // Giảm giá phần trăm cho sản phẩm/dịch vụ
  static const String discount_order = "discount_order"; // Giảm giá cho đơn hàng/đặt lịch
  static const String discount_order_voucher = "discount_order_voucher"; // Giảm giá Voucher cho đơn hàng/đặt lịch
  static const String discount_order_direct_money = "discount_order_direct_money"; // Giảm giá trực tiếp cho đơn hàng/đặt lịch
  static const String discount_order_direct_percent = "discount_order_direct_percent"; // Giảm giá phần trăm cho đơn hàng/đặt lịch
  static const String discount_order_member = "discount_order_member"; // Giảm giá thành viên cho đơn hàng/đặt lịch
  static const String receipt_other = "receipt_other"; // Thu khác cho đơn hàng/đặt lịch
  static const String order_refer = "order_refer"; // Người giới thiệu cho đơn hàng/đặt lịch
  static const String order_sale = "order_sale"; // Nhân viên tư vấn cho đơn hàng/đặt lịch

  static const String vat_price_config = "vat_price_config"; // include: tổng tiền đã bao gồm VAT; non-include: tổng tiền chưa bao gồm VAT
  static const String vat_value = "vat_value"; // Giá trị vat default
}

bool checkConfigKey(String key) {
  return Globals.configModels?.firstWhereOrNull((element) => element.key == key && element.value == "1") != null;
}