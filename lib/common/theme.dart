import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppColors {
  static const subColor = Color(0xFF2F2E41);
  static const primaryColor = Color(0xFF0067AC);
  static const primary50Color = Color(0xFFF9DECF);
  static const white = Color(0xFFFFFFFF);
  static const white50 = Color(0xFFFAFAFA);
  static const black = Color(0xFF000000);
  static const lightGrey = Color.fromARGB(255, 247, 243, 243);
  static const grey600 = Color(0xFF777777);
  static const dark = Color(0xFF040C21);
  static const grey200 = Color(0xFFD8D8D8);
  static const lineColor = Color(0xFFEFF0F2);
  static const greenLightColor = Color(0xFFE5FAE6);
  static const greenBorderColor = Color(0xFFC1F0C1);
  static const greenLeadColor = Color(0xFF0BC50B);
  static const paginationColor = Color(0xFFF1E4DC);
  static const tabActiveColor = Color(0xFF262B35);
  static const tabInActiveColor = Color(0xFF666D7C);
  static const promotionColor = Color(0xFFF3F4F6);
  static const iconInActiveColor = Color(0xFF727682);
  static const black50Color = Color(0xFF11192E);
  static const colorLine = Color(0xFFF1F1F1);
  static const colorLineImage = Color(0xFFE4E4E4);
  static const headerColorBackground = Color(0xFFFF7421);
  static const headerColorLinearTop = Color(0xFFFFF1D3);
  static const headerColorLinearBottom = Color(0xFFFFE5D4);
  static const colorSelectedService = Color(0xFFFFF5EB);
  static const colorUnSelectedService = Color(0xFFF4F6F8);
  static const colorBorderUnSelectedService = Color(0xFFEAEEF1);
  static const redColor = Color(0xFFE22119);
  static const colorRed = Color(0xFFFF0000);
  static const greenColor = Color(0xFF11B482);
  static const orangeColorGradientTop = Color(0xFFFFA93A);
  static const orangeColorGradientBottom = Color(0xFFFFF9ED);
  static const lineCardColor = Color(0xFFEFEFEF);
  static const blueColor = Color(0xFF2F80ED);
  static const colorBlue = Color(0xFF276EDF);
  static const grey500Color = Color(0xFFA0A4AF);
  static const grey700Color = Color(0xFFC7CBD7);
  static const grey600Color = Color(0xFFBEC0C7);
  static const grey300Color = Color(0xFFF9F9F9);
  static const grey200Color = Color(0xFFF4F4F4);
  static const greyF8Color = Color(0xFFF8F8F8);
  static const redAccColor = Color(0xFFFF8F8F);
  static const red500 = Color(0xFFF44336);
  static const blueAccColor = Color(0xFF75AEFF);
  static const colorIconVersion = Color(0xFF4D515E);
  static const colorBgTextField = Color(0xFFF5F5F6);
  static const colorBgBank = Color(0xFFF8F9FB);
  static const shadowColor = Color(0xFFC6C6C6);
  static const colorGreen = Color(0xFF30D78B);
  static const colorGreen50 = Color(0xFFEFFFF8);
  static const colorOrange50 = Color(0xFFFFF2EB);
  static const lineBlueColor = Color(0xFFE4E6EB);
  static const lineTabInactiveColor = Color(0xFFE2E3E6);
  static const lineBoardColor = Color(0xFFE6E6E6);
  static const lineBorderColor = Color(0xFFD2D5DB);
  static const grayBackGround = Color(0xFFE5E5E5);
  static const brown = Color(0xFFC59A70);

  static const backgroundNotification = Color(0xFFECF4FF);
  static const grey34 = Color(0xFFF3F4F7);
  static const colorTabUnselected = Color(0xFF707581);
  static const editColor = Color(0xFFADB2BD);

  static const bluePrimary = Color(0xFF2F9AF4);
  static const primaryUnselect = Color(0xFFFFEAD6);
  static const filterSelectedColor = Color(0xFFFFF5EF);
  static const backgroundRed = Color(0xFFFFF8F8);
  static const green = Color(0xFF4CD964);
  static const backgroundGrey = Color(0xFFF5F6F8);
  static const darkGrey = Color(0xFFD9D9D9);
  static const ash = Color(0xFF7D8290);
  static const colorDot = Color(0xFFADB1B9);
  static const disableColor = Color(0xFFDADADA);
  static const hintColor = Color(0xFF8E8E8E);
  static const borderColor = Color(0xFFE5E5E5);
  static const grey50Color = Color(0xFFF6F6F6);
  static const surveyProgress = Color(0xFFF5F7FA);

  static const primaryColorMix = Color(0xFFe1f0fa);
  static const primaryGradiantColor = Color(0xFF5faee3);
  static const whiteColor = Color(0xFFFFFFFF);
  static const blackColor = Color(0xFF000000);
  static const greyF2Color = Color(0xFFF2F2F2);
  static const primaryColorButton = RadialGradient(
      center: Alignment.centerRight,
      radius: 0.75,
      colors: <Color>[
        AppColors.primaryColor,
        AppColors.primaryGradiantColor,
      ],
      tileMode: TileMode.clamp);
  static const primaryColorReport = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.1, 0.45, 0.9],
      colors: <Color>[
        AppColors.primaryColor,
        AppColors.primaryGradiantColor,
        AppColors.whiteColor,
      ],
      tileMode: TileMode.clamp);
  static const ticketNewColor = Color(0xFF20C997);
  static const darkRedColor = Color(0xFFCE3A3A);
  static const darkGreenColor = Color(0xFF2AA27E);
  static const greyC4Color = Color(0xFFC4C4C4);
  static const processing = Color(0xFFF3A256);
  static const finish = Color(0xFF5191F1);
  static const orange200 = Color(0xFFFFD699);
  static const orange300 = Color(0xFFF6822D);
  static const orange500 = Color(0xFFFF9800);
  static const grey100 = Color(0xFFECECEC);
  static const red100 = Color(0xFFFDD9D7);
  static const red50 = Color(0xFFFFE7E7);
  static const checkIn = Color(0xFFFDD9D7);
  static const checkInSoon = Color(0xFFDBEFDC);
  static const checkInLate = Color(0xFFFFEACC);
  static const backgroundOpacity = Color(0xFF101010);
  static const cyan = Color(0xFF00C9F5);
  static const yellow = Color(0xFFF2C94C);
  static const gray50 = Color(0xFFEEEFF3);
  static const green50 = Color(0xFFE6F5ED);
  static const green300 = Color(0xFF20CB6F);
  static const surveyShadow = Color(0xFF0065A7);
  static const greenLight = Color(0xFFB7DFB9);
  static const redLight = Color(0xFFFBB4AF);
  static const blueLight = Color(0xFF99D5CF);
  static const surveySuccess = Color(0xFF2AA27E);
  static const surveyWrong = Color(0xFFF44336);
  static const functionAppointment = Color(0xFF26547C);
  static const functionService = Color(0xFF067BC2);
  static const functionProduct = Color(0xFF2B4141);
  static const functionCustomer = Color(0xFFDB5ABA);
  static const functionLead = Color(0xFFFFC107);
  static const functionDeal = Color(0xFF402600);
  static const functionOrder = Color(0xFF558564);
  static const functionReport = Color(0xFF802C11);
  static const functionWarranty = Color(0xFF017177);
  static const functionTicket = Color(0xFF4FC3CB);
  static const functionProjectManager = Color(0xFF1F989F);
  static const functionJob = Color(0xFFB73229);
  static const functionDocument = Color(0xFFC47DD0);
  static const functionChat = Color(0xFF1677E8);
  static const functionChatHub = Color(0xFF004B44);
  static const functionTimekeeping = Color(0xFFDD2C00);
  static const functionFrequentlyAskedQuestions = primaryColor;
  static const pinkSale = Color(0xFFE91D62);
  static const pieChartBudget = Color(0xFF480CA8);
}

class AppFonts {
  static const font = "SF Pro Text";
}

class AppSizes {
  static double? maxWidth;
  static late double maxHeight;
  static double? ultraPadding;
  static double maxPadding = 0.0;
  static double minPadding = 0.0;
  static double? sizeOnTap;
  static double? sizeOnTapCheckIn;
  static late double statusBarHeight;
  static double? bottomHeight;
  static double? sizeAppBar;
  static double? screenHeight;
  static double? iconSize;
  static double? lineSize;
  static double? paddingSearch;
  static const timelineHeight = 80.0;
  static const timeWidth = 30.0;
  static const totalTimeline = 48;
  static const totalMinuteOfTimeline = 30;

  static init(BuildContext context) {
    maxWidth = MediaQuery.of(context).size.width;
    maxHeight = MediaQuery.of(context).size.height;
    statusBarHeight = MediaQuery.of(context).padding.top;
    bottomHeight = MediaQuery.of(context).padding.bottom;
    ultraPadding = maxWidth! * 0.1;
    sizeOnTapCheckIn = 64;
    sizeOnTap = 40.0;
    maxPadding = sizeOnTap! / 2;
    minPadding = maxPadding! / 2;
    sizeAppBar = statusBarHeight + kToolbarHeight;
    screenHeight = maxHeight - statusBarHeight;
    iconSize = 24;
    lineSize = 0.5;
    paddingSearch = 57;
  }
}

class AppKeys {
  static const String keyHUD = "HUD";
  static const String keyLanguage = "LANGUAGE";
}

class AppTextSizes {
  // static double size7 = 7.0;
  static double size8 = 8.0;
  static double size10 = 10.0;
  static double size11 = 11.0;
  static double size12 = 12.0;
  static double size13 = 13.0;
  static double size14 = 14.0;
  static double size15 = 15.0;
  static double size16 = 16.0;
  static double size17 = 17.0;
  static double size18 = 18.0;
  static double size20 = 20.0;
  static double size22 = 22.0;
  static double size24 = 24.0;
  static double size25 = 25.0;
  static double size28 = 28.0;
  static double size30 = 30.0;
  static double size36 = 36.0;
}

class AppTextStyles {
  static TextStyle style20BlackBold = TextStyle(
      fontSize: AppTextSizes.size20,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle style20WhiteBold = TextStyle(
      fontSize: AppTextSizes.size20,
      color: Colors.white,
      fontWeight: FontWeight.bold);
  static TextStyle style18PrimaryBold = TextStyle(
      fontSize: AppTextSizes.size18,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle style18BlackBold = TextStyle(
      fontSize: AppTextSizes.size18,
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold);
  static TextStyle style18WhiteBold = TextStyle(
      fontSize: AppTextSizes.size18,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.bold);
  static TextStyle style18GreyBold = TextStyle(
      fontSize: AppTextSizes.size18,
      color: AppColors.grey500Color,
      fontWeight: FontWeight.bold);
  static TextStyle style17BlackBold = TextStyle(
      fontSize: AppTextSizes.size17,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle style17PrimaryBold = TextStyle(
      fontSize: AppTextSizes.size17,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle style17WhiteNormal = TextStyle(
      fontSize: AppTextSizes.size17,
      color: Colors.white,
      fontWeight: FontWeight.normal);
  static TextStyle style16PrimaryW700 = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w700);
  static TextStyle style16PrimaryBold = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle style16WhiteNormal = TextStyle(
      fontSize: AppTextSizes.size16,
      color: Colors.white,
      fontWeight: FontWeight.normal);
  static TextStyle style16WhiteBold = TextStyle(
      fontSize: AppTextSizes.size16,
      color: Colors.white,
      fontWeight: FontWeight.bold);
  static TextStyle style16BlackBold = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold);
  static TextStyle style16BlackNormal = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.blackColor,
      fontWeight: FontWeight.normal);
  static TextStyle style16Black600Bold = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.blackColor,
      fontWeight: FontWeight.w600);
  static TextStyle style16Grey500Normal = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.grey500Color,
      fontWeight: FontWeight.normal);
  static TextStyle style15BlackBold = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold);
  static TextStyle style15WhiteBold = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.bold);
  static TextStyle style15PrimaryBold = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle style15PrimaryNormal = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.normal);
  static TextStyle style15WhiteNormal = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.normal);
  static TextStyle style15BlackNormal = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.blackColor,
      fontWeight: FontWeight.normal);
  static TextStyle style15HintNormalItalic = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.hintColor,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic);
  static TextStyle style14WhiteBold = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.bold);
  static TextStyle style14DarkRedBold = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.darkRedColor,
      fontWeight: FontWeight.bold);
  static TextStyle style14DarkRedNormal = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.darkRedColor,
      fontWeight: FontWeight.normal);
  static TextStyle style14PrimaryBold = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle style14BlackBold = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold);
  static TextStyle style14PrimaryRegular = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.normal);
  static TextStyle style14BlackNormal = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.blackColor,
      fontWeight: FontWeight.normal);
  static TextStyle style14BlueNormal = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.blueColor,
      fontWeight: FontWeight.normal);
  static TextStyle style14HintNormal = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.hintColor,
      fontWeight: FontWeight.normal);
  static TextStyle style14WhiteNormal = TextStyle(
      fontSize: AppTextSizes.size14,
      color: Colors.white,
      fontWeight: FontWeight.normal);
  static TextStyle style14WhiteW500 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: Colors.white,
      fontWeight: FontWeight.w500);
  static TextStyle style14WhiteW700 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: Colors.white,
      fontWeight: FontWeight.w700);
  static TextStyle style14HintNormalItalic = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.hintColor,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic);
  static TextStyle style13BlackBold = TextStyle(
      fontSize: AppTextSizes.size13,
      color: Colors.black,
      fontWeight: FontWeight.bold);
  static TextStyle style13PrimaryNormal = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.normal);
  static TextStyle style13BlackNormal = TextStyle(
      fontSize: AppTextSizes.size13,
      color: Colors.black,
      fontWeight: FontWeight.normal);
  static TextStyle style13WhiteNormal = TextStyle(
      fontSize: AppTextSizes.size13,
      color: Colors.white,
      fontWeight: FontWeight.normal);
  static TextStyle style13GreyW700 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.grey500Color,
      fontWeight: FontWeight.w700);
  static TextStyle style13HintNormal = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.hintColor,
      fontWeight: FontWeight.normal);
  static TextStyle style12PrimaryBold = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.bold);
  static TextStyle style12HintNormal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.hintColor,
      fontWeight: FontWeight.normal);
  static TextStyle style12HintNormalItalic = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.hintColor,
      fontWeight: FontWeight.normal,
      fontStyle: FontStyle.italic);
  static TextStyle style12PrimaryNormal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.normal);
  static TextStyle style12WhiteBold = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.bold);
  static TextStyle style12BlackBold = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.blackColor,
      fontWeight: FontWeight.bold);
  static TextStyle style12grey200Bold = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.grey200Color,
      fontWeight: FontWeight.bold);
  static TextStyle style12grey500Bold = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.grey500Color,
      fontWeight: FontWeight.bold);
  static TextStyle style12WhiteNormal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.normal);
  static TextStyle style12grey200Normal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.grey200Color,
      fontWeight: FontWeight.normal);
  static TextStyle style12grey500Normal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.grey500Color,
      fontWeight: FontWeight.normal);
  static TextStyle style12BlackNormal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.blackColor,
      fontWeight: FontWeight.normal);
  static TextStyle style10WhiteBold = TextStyle(
      fontSize: AppTextSizes.size10,
      color: AppColors.whiteColor,
      fontWeight: FontWeight.bold);
  static TextStyle style10BlackNormal = TextStyle(
      fontSize: AppTextSizes.size10,
      color: AppColors.blackColor,
      fontWeight: FontWeight.normal);
  static TextStyle style20Blue600Bold = TextStyle(
      fontSize: AppTextSizes.size20,
      color: AppColors.functionFrequentlyAskedQuestions,
      fontWeight: FontWeight.w600);
  static TextStyle style20PrimaryBold = TextStyle(
      fontSize: AppTextSizes.size20,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w600);
  static TextStyle style12WhiteWeight700Italic = TextStyle(
    fontSize: AppTextSizes.size12,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );
  static TextStyle style10WhiteWeight700Italic = TextStyle(
    fontSize: AppTextSizes.size10,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );
  static TextStyle style18WhiteBoldItalic = TextStyle(
    fontSize: AppTextSizes.size18,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  static TextStyle style20WhiteWeight700 = TextStyle(
      fontSize: AppTextSizes.size20,
      color: AppColors.white,
      fontWeight: FontWeight.w700);
  static TextStyle style20BlackWeight400 = TextStyle(
      fontSize: AppTextSizes.size20,
      color: AppColors.black,
      fontWeight: FontWeight.w400);
  static TextStyle style36BlackNormal = TextStyle(
      fontSize: AppTextSizes.size36,
      color: AppColors.black,
      fontWeight: FontWeight.normal);
  static TextStyle style25WhiteWeight800Italic = TextStyle(
    fontSize: AppTextSizes.size25,
    color: AppColors.white,
    fontWeight: FontWeight.w800,
    fontStyle: FontStyle.italic,
  );

  static TextStyle style25BlackWeight700 = TextStyle(
      fontSize: AppTextSizes.size25,
      color: AppColors.black,
      fontWeight: FontWeight.w700);
  static TextStyle style24BlackBold = TextStyle(
      fontSize: AppTextSizes.size24,
      color: AppColors.black,
      fontWeight: FontWeight.bold);
  static TextStyle style22BlackBold = TextStyle(
      fontSize: AppTextSizes.size22,
      color: AppColors.black,
      fontWeight: FontWeight.bold);
  static TextStyle style15Grey600Normal = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.grey600,
      fontWeight: FontWeight.normal);
  static TextStyle style15Red600Normal = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.redColor,
      fontWeight: FontWeight.normal);
  static TextStyle style12Grey600Normal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.grey600,
      fontWeight: FontWeight.normal);
  static TextStyle style12Green600Normal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.green,
      fontWeight: FontWeight.normal);
  static TextStyle style12RedNormal = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.redColor,
      fontWeight: FontWeight.normal);
  static TextStyle style12BlackW400 = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.black,
      fontWeight: FontWeight.w400);
  static TextStyle style11BlackW700 = TextStyle(
      fontSize: AppTextSizes.size11,
      color: AppColors.black,
      fontWeight: FontWeight.w700);
  static TextStyle style12PrimaryW400 = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w400);

  static TextStyle style12PrimaryWeight600 = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w600);
  static TextStyle style14WhiteWeight700Italic = TextStyle(
    fontSize: AppTextSizes.size14,
    color: AppColors.white,
    fontWeight: FontWeight.w700,
    fontStyle: FontStyle.italic,
  );
  static TextStyle style14Black50Weight400 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.black50Color,
      fontWeight: FontWeight.w400);
  static TextStyle style14BlueUnderlineWeight400 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.blueColor,
      decoration: TextDecoration.underline,
      fontWeight: FontWeight.w400);
  static TextStyle style14WhiteWeight600 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.white,
      fontWeight: FontWeight.w600);
  static TextStyle style14WhiteWeight400 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.white,
      fontWeight: FontWeight.w400);
  static TextStyle style14Grey500Weight400 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.grey500Color,
      fontWeight: FontWeight.w400);
  static TextStyle style18LeadGreyBold = TextStyle(
      fontSize: AppTextSizes.size18,
      color: AppColors.colorTabUnselected,
      fontWeight: FontWeight.bold);
  static TextStyle style14reyTabWeight400 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.tabInActiveColor,
      fontWeight: FontWeight.w400);
  static TextStyle style14PrimaryWeight600 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w600);
  static TextStyle style14PrimaryWeight400 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w400);
  static TextStyle style14BlueWeight500 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.bluePrimary,
      fontWeight: FontWeight.w500);
  static TextStyle style16BlueWeight500 = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.bluePrimary,
      fontWeight: FontWeight.w500);
  static TextStyle style18BlueBold = TextStyle(
      fontSize: AppTextSizes.size18,
      color: AppColors.blueColor,
      fontWeight: FontWeight.bold);
  static TextStyle style14BlackWeight600 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.black,
      fontWeight: FontWeight.w600);
  static TextStyle style14BlackWeight500 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.black,
      fontWeight: FontWeight.w500);
  static TextStyle style14BlackWeight400 = TextStyle(
      fontSize: AppTextSizes.size14,
      color: AppColors.black,
      fontWeight: FontWeight.w400);
  static TextStyle style13BlackWeight400 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.black,
      fontWeight: FontWeight.w400);
  static TextStyle style13BlackWeight500 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.black,
      fontWeight: FontWeight.w500);
  static TextStyle style13BlackWeight600 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.black,
      fontWeight: FontWeight.w600);
  static TextStyle style13BlackWeight700 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.black,
      fontWeight: FontWeight.w700);
  static TextStyle style13RedWeight700 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.redColor,
      fontWeight: FontWeight.w700);
  static TextStyle style13RedWeight400 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.redColor,
      fontWeight: FontWeight.w400);
  static TextStyle style13Weight400 =
      TextStyle(fontSize: AppTextSizes.size13, fontWeight: FontWeight.w400);
  static TextStyle style13GrayWeight400 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.tabInActiveColor,
      fontWeight: FontWeight.w400);
  static TextStyle style13GreenWeight400 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.green,
      fontWeight: FontWeight.w400);
  static TextStyle style13PrimaryWeight400 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.primaryColor,
      fontWeight: FontWeight.w400);
  static TextStyle style13WhiteWeight400 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.white,
      fontWeight: FontWeight.w400);
  static TextStyle style13GreenWeight500 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.greenColor,
      fontWeight: FontWeight.w500);
  static TextStyle style13BlueWeight400 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.bluePrimary,
      fontWeight: FontWeight.w400);
  static TextStyle style13BlueWeight500 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.bluePrimary,
      fontWeight: FontWeight.w500);
  static TextStyle style13BluePrimaryWeight600 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.bluePrimary,
      fontWeight: FontWeight.w600);
  static TextStyle style13BluePrimaryWeight400 = TextStyle(
      fontSize: AppTextSizes.size13,
      color: AppColors.bluePrimary,
      fontWeight: FontWeight.w400);
  static TextStyle style12DartColorWeight500 = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.dark,
      fontWeight: FontWeight.w500);
  static TextStyle style12DartColorWeight400 = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.dark,
      fontWeight: FontWeight.w400);
  static TextStyle style12Grey500ColorWeight400 = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.grey500Color,
      fontWeight: FontWeight.w400);
  static TextStyle style11Grey500ColorWeight400 = TextStyle(
      fontSize: AppTextSizes.size11,
      color: AppColors.grey500Color,
      fontWeight: FontWeight.w400);
  static TextStyle style11WhiteWeight500 = TextStyle(
      fontSize: AppTextSizes.size11,
      color: AppColors.white,
      fontWeight: FontWeight.w500);
  static TextStyle style11WhiteNormal = TextStyle(
      fontSize: AppTextSizes.size11,
      color: AppColors.white,
      fontWeight: FontWeight.normal);
  static TextStyle style16BlackWeight700 = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.black,
      fontWeight: FontWeight.w700);
  static TextStyle style16BlackWeight500 = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.black,
      fontWeight: FontWeight.w500);
  static TextStyle style16BlackWeight600 = TextStyle(
      fontSize: AppTextSizes.size16,
      color: AppColors.black,
      fontWeight: FontWeight.w600);

  static TextStyle style12BlackWeight500 = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.black,
      fontWeight: FontWeight.w500);
  static TextStyle style12BlackWeight400 = TextStyle(
      fontSize: AppTextSizes.size12,
      color: AppColors.black,
      fontWeight: FontWeight.w400);
  static TextStyle style15BlackWeight700 = TextStyle(
      fontSize: AppTextSizes.size15,
      color: AppColors.black,
      fontWeight: FontWeight.w700);
}

class AppAnimation {
  static Duration duration = Duration(milliseconds: 500);
  static Curve curve = Curves.fastOutSlowIn;
}

class AppFormat {
  static DateFormat formatDate = DateFormat("dd/MM/yyyy");
  static DateFormat formatDateResponse = DateFormat("yyyy-MM-dd");
  static DateFormat formatDate1Response = DateFormat("dd-MM-yyyy");
  static DateFormat formatDateTimeResponse = DateFormat("yyyy-MM-dd HH:mm:ss");
  static DateFormat formatDateTime1Request = DateFormat("dd/MM/yyyy HH:mm:ss");
  static DateFormat formatDateTime = DateFormat("dd/MM/yyyy HH:mm");
  static DateFormat formatDateMonth = DateFormat("dd/MM");
  static DateFormat formatTime = DateFormat("HH:mm");
  static NumberFormat moneyFormatDot = NumberFormat("#,###", "vi-VN");
  static NumberFormat moneyFormat = NumberFormat("#,###");
  static DateFormat formatDateTimeEn = DateFormat("dd MMMM, yyyy", "en_US");
  static DateFormat formatDateTimeVn = DateFormat("dd MMMM, yyyy", "vi_VN");
  static DateFormat formatHHMMDateTimeEn =
      DateFormat("HH:mm - dd MMMM, yyyy", "en_US");
  static DateFormat formatHHMMDateTimeVn =
      DateFormat("HH:mm - dd MMMM, yyyy", "vi_VN");
  static NumberFormat quantityFormat = NumberFormat("#,###.###");
  static String formatNonSale = "d2d-nonsale/{instanceVer}";

  static DateFormat formatFullTime = DateFormat("HH:mm:ss");
  static DateFormat formatDateCreate = DateFormat("yyyy-MM-dd");
  static DateFormat formatDateTimeCreate = DateFormat("yyyy-MM-dd HH:mm");
  static DateFormat formatDateRequest = DateFormat("yyyy/MM/dd");
  static DateFormat formatRemind = DateFormat("HH:mm dd/MM");
  static DateFormat formatTimeDate = DateFormat("HH:mm dd/MM/yyyy");
  static DateFormat formatDayOfWeek = DateFormat("E");
}

class AppSizeWebConfig {
  static const maxWidthWeb = 500.0;
  static const maxHeightWeb = 926.0;
}

extension MoneyFormat on double? {
  String getMoneyFormat() {
    if (this == null) {
      return "0 VND";
    } else {
      return AppFormat.moneyFormat.format(this) + " VND";
    }
  }

  String getMoneyFormatWithoutVND() {
    if (this == null) {
      return "0";
    } else {
      return AppFormat.moneyFormat.format(this);
    }
  }

  String getNumberFormat() {
    if (this == null) {
      return "0";
    } else {
      return AppFormat.moneyFormat.format(this) + "";
    }
  }
}
