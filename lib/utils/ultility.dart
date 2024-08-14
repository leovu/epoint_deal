
import 'dart:convert';
import 'dart:developer';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:epoint_deal_plugin/common/assets.dart';
import 'package:epoint_deal_plugin/common/constant.dart';
import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:epoint_deal_plugin/common/localization/app_localizations.dart';
import 'package:epoint_deal_plugin/common/theme.dart';
import 'package:epoint_deal_plugin/model/customer_order_photo_model.dart';
import 'package:epoint_deal_plugin/model/discount_cart_model.dart';
import 'package:epoint_deal_plugin/model/response/order_detail_response_model.dart';
import 'package:epoint_deal_plugin/model/response/voucher_response_model.dart';
import 'package:epoint_deal_plugin/presentation/order_module/src/ui/customer_order_photo_screen.dart';
import 'package:epoint_deal_plugin/widget/custom_navigation.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:keyboard_actions/keyboard_actions_item.dart';
import 'package:url_launcher/url_launcher.dart' as urlLauncher;
import 'package:http/http.dart' as http;

void keyboardDismissOnTap(BuildContext context) {
  final currentFocus = FocusScope.of(context);
  FocusScopeNode rootScope = WidgetsBinding.instance.focusManager.rootScope;

  if (currentFocus != rootScope) {
    if (currentFocus.hasFocus && !currentFocus.hasPrimaryFocus) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}

extension IterableModifier<E> on Iterable<E> {
  E? firstWhereOrNull(bool Function(E) test) =>
      cast<E>().firstWhere((v) => v != null && test(v));
}

Color stringToColor(String? event, {Color? defaultColor}) {
  return (event ?? "").isEmpty
      ? (defaultColor ?? AppColors.primaryColor)
      : HexColor(event);
}



class Validators {
  var validatePhone = RegExp(r'(0)+([0-9]{9,10})\b');
  var validateNumber = RegExp(r"^[\d]*$");

 bool isValidPhone(String? phone){
    if (phone!=null&&phone.isNotEmpty&&validatePhone.hasMatch(phone)){
      return true;
    }
    return false;
  }

  bool isNumber(String? number){
    if (number!=null&&number.isNotEmpty&&validateNumber.hasMatch(number)){
      return true;
    }
    return false;
  }

}

String formatMoney(double? event, {NumberFormat? format}) {
  if (event == null) {
    return "";
  }

  return (format ?? AppFormat.quantityFormat).format(event);
}

customPrint(dynamic event) {
  log(event.toString());
}

dynamic stringToJson(String? event) {
  if (event == null) return null;
  return json.decode(event);
}

DateTime? parseDate(String? event, {DateFormat? parse}) {
  if ((event ?? "").isEmpty) {
    return null;
  }

  return (parse ?? AppFormat.formatDateResponse).parse(event!);
}

launch(String? url) {
  if ((url ?? "").isEmpty) {
    return;
  }
  urlLauncher.launchUrl(
    Uri.parse(url!),
    mode: urlLauncher.LaunchMode.externalApplication,
  );
}

callPhone(String? phone) {
  FlutterPhoneDirectCaller.callNumber(phone ?? "");
}

sendSMS(String? phone) {
  launch("sms:" + (phone ?? "").trim());
}

googleMap(String? lat, String? lng) async {
  launch("https://www.google.com/maps/search/${lat ?? "0.0"},${lng ?? "0.0"}");
}

String jsonToString(dynamic event) {
  return json.encode(event);
}



String formatDate(DateTime? event, {DateFormat? format}) {
  if (event == null) {
    return "";
  }

  return (format ?? AppFormat.formatDate).format(event);
}

String parseAndFormatDate(String? event,
    {DateFormat? format, DateFormat? parse}) {
  if ((event ?? "").isEmpty) {
    return "";
  }

  return (format ?? AppFormat.formatDate)
      .format((parse ?? AppFormat.formatDateResponse).parse(event!));
}


double parseMoney(String? event, {NumberFormat? parse, double? defaultValue}) {
  if ((event ?? "").isEmpty) {
    return defaultValue ?? 0.0;
  }

  return (parse ?? AppFormat.quantityFormat).parse(event!) as double? ??
      defaultValue ??
      0.0;
}

hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

String getVoucherImage(DiscountCartModel model) {
  return model.model != null
      ? Assets.imageDiscountVoucher
      : model.percent != null
          ? Assets.imageDiscountDirect
          : Assets.imageDiscountCash;
}

double getDiscount(DiscountCartModel? model, {double? total}) {
  if (model == null) {
    return 0;
  }

  if (model.model != null) {
    return model.model!.discount ?? 0;
  }

  if (model.amount != null) {
    return model.amount!;
  }

  double price = total ?? 0;
  if (price == 0) {
    return 0;
  }

  return model.percent! / 100 * price;
}

openFile(BuildContext context, String? name, String? path) {
  if (imageType.contains((path ?? "").split(".").last)) {
    CustomNavigator.push(context,
        CustomerOrderPhotoScreen([CustomerOrderPhotoModel(url: path)]));
  } else {
    CustomNavigator.push(context, CustomFileView(path, name));
  }
}

fieldFocus(BuildContext context, FocusNode? focusNode) {
  FocusScope.of(context).requestFocus(focusNode);
}

String formatTextDateTime(String? datetime, bool textMonth) {
  final dateTime = DateTime.parse(datetime ?? "");
  String textFormat;
  if (textMonth == true) {
    textFormat = (dateTime.day.toString() +
        " " +
        AppLocalizations.text(LangKey.month)! +
        " " +
        dateTime.month.toString() +
        ", " +
        dateTime.year.toString());
  } else {
    textFormat = dateTime.day.toString() +
        "/" +
        dateTime.month.toString() +
        "/" +
        dateTime.year.toString();
  }
  return textFormat;
}

String? pathToImage(String path) {
  if (path == "doc" || path == "docx") {
    return Assets.imageMSWord;
  } else if (path == "xls" || path == "xlsx" || path == "xlsm") {
    return Assets.imageMSExcel;
  } else if (path == "pdf") {
    return Assets.imagePDF;
  } else if (path == "ppt" || path == "pptx") {
    return Assets.imagePPT;
  }

  return null;
}

KeyboardActionsItem buildKeyboardAction(FocusNode node,
    {String text = "Done", GestureTapCallback? onTap}) {
  return KeyboardActionsItem(focusNode: node, toolbarButtons: [
    (node) => InkWell(
          onTap: onTap ?? () => node.unfocus(),
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        )
  ]);
}


Color parseStatusColor(int? id) {
  if (id == 1) {
    return AppColors.ticketNewColor;
  }
  if (id == 2) {
    return AppColors.processing;
  }
  if (id == 3) {
    return AppColors.finish;
  }
  if (id == 4) {
    return AppColors.blackColor;
  }
  if (id == 5) {
    return Colors.deepPurple;
  }
  if (id == 6) {
    return Colors.red;
  }
  return AppColors.hintColor;
}

Color parseOrderStatusColor(String? status) {
  if (status == orderStatusNew) return Colors.orange;
  if (status == orderStatusConfirmed) return Colors.blue;
  if (status == orderStatusPayHalf) return Colors.deepPurple;
  if (status == orderStatusPaySuccess) return Colors.green;
  if (status == orderStatusOrderCancle) return Colors.red;
  return Colors.black;
}

double getBookingAmount(double amount, double discount, double surcharge,
    {double quantity = 1}) {
  double value = (amount * quantity) + surcharge - discount;
  return (value < 0 ? 0 : value);
}

double getWidthPerRow(int itemPerRow) {
  return (AppSizes.maxWidth! -
          AppSizes.maxPadding * 2 -
          AppSizes.minPadding * (itemPerRow - 1) -
          1) /
      itemPerRow;
}

bool _isPaymentAvailable(String? status) {
  return status == orderStatusNew ||
      status == orderStatusConfirmed ||
      status == orderStatusPayHalf;
}

bool isOrderPayment(List<OrderReceiptModel>? models, String? processStatus) {
  return (models?.length ?? 0) == 0 || _isPaymentAvailable(processStatus);
}

String hideMoney(double? event, bool show) {
  event = event ?? 0.0;
  if (!show) {
    return List.generate(5, (index) => "*").join();
  }

  return formatMoney(event);
}

DiscountCartModel? parseDiscount(
    double? discount, String? type, double? value, String? code) {
  if ((discount ?? 0.0) > 0) {
    if (type == discountTypeCode) {
      return DiscountCartModel(
          model:
              CheckVoucherResponseModel(voucherCode: code, discount: discount));
    }
    if (type == discountTypePercent) {
      return DiscountCartModel(percent: value?.toInt() ?? 0);
    }

    return DiscountCartModel(amount: discount);
  }
  return null;
}

toast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.primaryColor,
      textColor: Colors.white);
}

copyText(BuildContext context, String text,
    {String? message = "Copied to Clipboard"}) {
  Clipboard.setData(ClipboardData(text: text)).then((_) {
    if (message != null) toast(message);
  });
}

String hidePhone(String? event, bool show) {
  if ((event ?? "").isEmpty) {
    return "";
  }

  int length = 3;

  if (!show) {
    if (event!.length > length) {
      return "${List.generate(event.length - length, (index) => "*").join()}${event.substring(event.length - length)}";
    }

    return List.generate(event.length, (index) => "*").join();
  }

  return event ?? "";
}





// openFile(BuildContext context, String? name, String? path) {
//   if (imageType.contains((path ?? "").split(".").last)) {
//     CustomNavigator.push(context,
//         CustomerOrderPhotoScreen([CustomerOrderPhotoModel(url: path)]));
//   } else {
//     CustomNavigator.push(context, CustomFileView(path, name));
//   }
// }


class HexColor extends Color {
  static int getColorFromHex(String? hexColor) {
    if((hexColor ?? "") == ""){
      hexColor = "000000";
    }
    hexColor = hexColor!.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String? hexColor) : super(getColorFromHex(hexColor));
}