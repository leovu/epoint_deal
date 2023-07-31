class Global {

  static bool validateCreateDate = true;

  static bool validateClosingDate = true;
  
  static bool validateClosingDueDate = true;

  static bool validateHistoryCareDate = true;

  static bool validateWorkScheduleDate = true;

  static Function? getListProduct;

  static Function? createJob;

  static Function? editJob;

  static String? branch_code;

  static double amount = 0.0;

  static double? discount = 0.0;

  static List<Map<String, dynamic>>? permissionModels = [];
}