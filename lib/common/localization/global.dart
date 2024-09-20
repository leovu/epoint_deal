import 'dart:ui';
import 'package:http/http.dart' as http;

class Global {

  static bool validateCreateDate = true;

  static bool validateClosingDate = true;
  
  static bool validateClosingDueDate = true;

  static bool validateHistoryCareDate = true;

  static bool validateWorkScheduleDate = true;

  static Function? getListProduct;

  static  Function? createJob;

  static Function(Map<String,dynamic>)?  createCare;

  static Function(int)? editJob;

  static Function(Map<String,dynamic>)? createOrder;

  static String? branch_code;

  static double amount = 0.0;

  static double? discount = 0.0;

  static List<Map<String, dynamic>>? permissionModels = [];

  static String domain = '';
  static String brandCode = '';
  static String asscessToken = '';
  static Locale? locale;

  static http.Client client = http.Client();

  static int decimalNumber = 0;

  static int isDisabledPrice = 0;

  static int branchId = 0;

  static Function(Map<String,dynamic>)? callHotline; 


}