import 'package:flutter/material.dart';

typedef CustomRefreshCallback = Future<void> Function();

final String decimalSympol = ".";
final imageTypeAfter = "after";
final DateTime minDateTime = DateTime(1900, 1, 1);

final String decimalSymbol = ".";
final String moneyUnit = "VND";

// typedef
typedef CustomBodyBuilder = Widget Function();

// DateTime

// Object type
final objectTypeOrder = "order";
final objectTypeMaintenance = "maintenance";

// Subject type
final subjectTypeProduct = "product";
final subjectTypeService = "service";
final subjectTypeServiceCard = "service_card";
final subjectTypeMemberCard = "member_card";

// Image type
final imageTypeBefore = "before";

// Order status
final String orderStatusNew = "new";
final String orderStatusConfirmed = "confirmed";
final String orderStatusPayHalf = "pay-half";
final String orderStatusPaySuccess = "paysuccess";
final String orderStatusOrderCancle = "ordercancle";

// Create object type
final String createObjectTypeTicket = "ticket";

// Ticket Type
final String ticketTypeD = "D";
final String ticketTypeI = "I";

// Priority
final String priorityL = "L";
final String priorityH = "H";
final String priorityN = "N";

// Time
final String typeTimeToday = "today";
final String typeTimeYesterday = "yesterday";
final String typeTimeThisWeek = "this_week";
final String typeTimeLastWeek = "last_week";
final String typeTimeLastMonth = "last_month";
final String typeTimeThisMonth = "this_month";
final String typeTimeCustom = "custom";

// Status
final String statusNew = "new";
final String statusCancel = "cancel";
final String statusApprove = "approve";

// Time
final String timeMinute = "m";
final String timeHour = "h";
final String timeDay = "d";
final String timeWeek = "w";

// Repeat
final String repeatDay = "daily";
final String repeatWeek = "weekly";
final String repeatMonth = "monthly";

// Card type
final String cardTypeBonus = "bonus";
final String cardTypeKPI = "kpi";

// Priority job
final int priorityJobHigh = 1;
final int priorityJobNormal = 2;
final int priorityJobLow = 3;

// Time previous remind
final int timePrevious10 = 10;
final int timePrevious15 = 15;
final int timePrevious30 = 30;
final int timePrevious60 = 60;

// Notification Action
final String notificationActionOrderDetail = "order_detail";
final String notificationActionAppointmentDetail = "appointment_detail";
final String notificationActionHome = "home";
final String notificationActionTicketDetail = "ticket_detail";
final String notificationActionTicketMaterialDetail = "request_material_detail";
final String notificationActionAcceptanceDetail = "acceptance_detail";
final String notificationActionWorkDetail = "manage_work_detail";
final String notificationActionMyWork = "my_work";
final String notificationActionSurveyDetail = "survey_detail";
final String notificationActionApplicationDetail = "time_off_days_detail";

// Payment method
const String paymentMethodVNPAY = "VNPAY";
const String paymentMethodCASH = "CASH";

// Location ship type
const int locationShipTypeAtAddress = 0;
const int locationShipTypeAtStore = 1;

// Header
const String accessPointCheckSum = "access-point-check-sum";

// Money
const double money100 = 100000;
const double money200 = 200000;
const double money500 = 500000;
const double money1ml = 1000000;
const double money1bl = 1000000000;

// Survey status
const String surveyStatusOpen = "open";
const String surveyStatusComing = "coming";

// Survey question type
const String surveyQuestionTypePageText = "page_text";
const String surveyQuestionTypeSingleChoice = "single_choice";
const String surveyQuestionTypeMultiChoice = "multi_choice";
const String surveyQuestionTypeText = "text";
const String surveyQuestionTypePagePicture = "page_picture";

// Tracker type
const String trackerTypeParent = "parent";
const String trackerTypeChild = "child";

// Application status
const String applicationStatusAccept = "accept";
const String applicationStatusDecline = "decline";

// Application code
const String applicationCodeCompensatoryLeave = "002";
const String applicationCodeBusinessTravel = "003";
const String applicationCodeF0WorkAtHome = "004";
const String applicationCodeWorkAtHomeOther = "020";
const String applicationCodeAnnualLeave = "006";
const String applicationCodeMarriageLeave = "007";
const String applicationCodeChildMarriageLeave = "008";
const String applicationCodeMourningLeave = "009";
const String applicationCodeUnpaidLeave = "011";
const String applicationCodeSickLeave = "013";
const String applicationCodeChildSickLeave = "014";
const String applicationCodeMaternityLeave = "015";
const String applicationCodeLate = "017";
const String applicationCodeComeBackSoon = "018";
const String applicationCodeCovid19 = "019";

// Application time type
const String applicationTimeTypeOneDay = "one-day";
const String applicationTimeTypeSeveralDays = "multi-day";
const String applicationTimeTypeMorning = "morning";
const String applicationTimeTypeAfternoon = "afternoon";

// My job type
const String myJobTypePerformer = "performer";
const String myJobTypeSupporter = "supporter";

// Survey validate type
const String surveyValidateTypeNone = "none";
const String surveyValidateTypeMin = "min";
const String surveyValidateTypeMax = "max";
const String surveyValidateTypeDigitsBetween = "digits_between";
const String surveyValidateTypeEmail = "email";
const String surveyValidateTypePhone = "phone";
const String surveyValidateTypeDateFormat = "date_format";
const String surveyValidateTypeNumeric = "numeric";

// View mode type
const String viewModeTypeMonth = "month";
const String viewModeTypeWeek = "week";
const String viewModeTypeDay = "day";

// Booking filter staff type
const String bookingFilterStaffTypeAll = "all";
const String bookingFilterStaffTypeRandom = "random";
const String bookingFilterStaffTypeCustomize = "customize";

// Booking status
const String bookingStatusNew = "new";
const String bookingStatusConfirm = "confirm";
const String bookingStatusCancel = "cancel";
const String bookingStatusFinish = "finish";
const String bookingStatusWait = "wait";
const String bookingStatusProcessing = "processing";

// Survey point type
const String surveyPointTypeNotPoint = "not_point";
const String surveyPointTypePoint = "point";

// Survey is start
const String surveyIsStartSuccess = "success";
const String surveyIsStartForbidden = "forbidden";

// Survey result answer
const String surveyResultAnswerSuccess = "success";
const String surveyResultAnswerWrong = "wrong";

// Regex
final String regexPhoneNumber = r'(0)+([0-9]{9,10})\b';
final String regexEmail = r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";

// Branch code
final String brandCodeDemo = "demodichvu";

// Image type
final List<String> imageType = ["jpeg", "jpg", "png"];

// Job code
final String jobCodeOverdue = "overdue";
final String jobCodeToday = "today";
final String jobCodeThisWeek = "this_week";
final String jobCodeNextWeek = "next_week";

// Gender
final String genderMale = "male";
final String genderFemale = "female";
final String genderOther = "other";

// Customer type
final String customerTypePersonal = "personal";
final String customerTypeBusiness = "business";

// Customer appointment type
final String customerAppointmentTypeAppointment = "appointment";
final String customerAppointmentTypeDirect = "direct";

// Int
final int maxLengthPhone = 100;
final int customerGuestId = 1;

// double
final double defaultCartQuantity = 1;

// String
final String discountTypeCash = "money";
final String discountTypePercent = "percent";
final String discountTypeCode = "voucher";

// Customer config id
const String customerConfigCodeOrder = "order";
const String customerConfigCodeAppointment = "appointment";
const String customerConfigCodeServiceCard = "service_card";
const String customerConfigCodeDebt = "debt";
const String customerConfigCodePayment = "receipt";
const String customerConfigCodeCommission = "commission_log";
const String customerConfigCodePoints = "loyalty";
const String customerConfigCodeContact = "contact";
const String customerConfigCodeCare = "customer_care";
const String customerConfigCodeWarranty = "warranty_card";
const String customerConfigCodeNote = "note";
const String customerConfigCodeFile = "file";
const String customerConfigCodeComment = "comment";
const String customerConfigCodeCaseWorker = "caseworker";
const String customerConfigCodeDeal = "deal";
const String customerConfigCodeDelivery = "address_delivery";
const String customerConfigCodeImage = "photo";

// Order config id
const String orderConfigCodeProduct = "product";
const String orderConfigCodeService = "service";
const String orderConfigCodeServiceCard = "service_card";

// Other Free Branch Type
const String otherFreeBranchTypeMoney = "money";
const String otherFreeBranchTypePercent = "percent";

// VAT price config
const String vatPriceConfigInclude = "include";
const String vatPriceConfigNonInclude = "non-include";