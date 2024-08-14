import 'brand_scan_response_model.dart';

class LoginResponseModel {
  int? staffId;
  int? departmentId;
  String? departmentName;
  int? branchId;
  int? staffTitleId;
  String? userName;
  String? password;
  String? salt;
  String? fullName;
  String? birthday;
  String? gender;
  String? phone1;
  String? phone2;
  String? email;
  String? facebook;
  String? dateLastLogin;
  int? isAdmin;
  int? isActived;
  int? isDeleted;
  String? staffAvatar;
  String? address;
  int? createdBy;
  int? updatedBy;
  String? createdAt;
  String? updatedAt;
  String? rememberToken;
  int? isMaster;
  String? staffCode;
  String? salary;
  String? subsidize;
  String? commissionRate;
  String? passwordReset;
  String? datePasswordReset;
  String? branchName;
  String? branchCode;
  String? branchAddress;
  String? accessToken;
  String? queueName;
  String? queueRole;
  String? passwordChat;
  String? tokenMd5;
  BrandScanResponseModel? logo;
  int? isCheckinGPS;
  int? isCheckinWifi;
  int? checkInLimit;
  String? linkGetIp;
  int? isDisabledPrice;
  int? decimalNumber;

  LoginResponseModel(
      {this.staffId,
      this.departmentId,
      this.departmentName,
      this.branchId,
      this.staffTitleId,
      this.userName,
      this.password,
      this.salt,
      this.fullName,
      this.birthday,
      this.gender,
      this.phone1,
      this.phone2,
      this.email,
      this.facebook,
      this.dateLastLogin,
      this.isAdmin,
      this.isActived,
      this.isDeleted,
      this.staffAvatar,
      this.address,
      this.createdBy,
      this.updatedBy,
      this.createdAt,
      this.updatedAt,
      this.rememberToken,
      this.isMaster,
      this.staffCode,
      this.salary,
      this.subsidize,
      this.commissionRate,
      this.passwordReset,
      this.datePasswordReset,
      this.branchName,
      this.branchCode,
      this.branchAddress,
      this.accessToken,
      this.queueName,
      this.queueRole,
      this.passwordChat,
      this.tokenMd5,
      this.logo,
      this.isCheckinGPS,
      this.isCheckinWifi,
      this.checkInLimit,
      this.linkGetIp,
      this.isDisabledPrice,
      this.decimalNumber});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    departmentId = json['department_id'];
    departmentName = json['department_name'];
    branchId = json['branch_id'];
    staffTitleId = json['staff_title_id'];
    userName = json['user_name'];
    password = json['password'];
    salt = json['salt'];
    fullName = json['full_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    phone1 = json['phone1'];
    phone2 = json['phone2'];
    email = json['email'];
    facebook = json['facebook'];
    dateLastLogin = json['date_last_login'];
    isAdmin = json['is_admin'];
    isActived = json['is_actived'];
    isDeleted = json['is_deleted'];
    staffAvatar = json['staff_avatar'];
    address = json['address'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    rememberToken = json['remember_token'];
    isMaster = json['is_master'];
    staffCode = json['staff_code'];
    salary = json['salary'];
    subsidize = json['subsidize'];
    commissionRate = json['commission_rate'];
    passwordReset = json['password_reset'];
    datePasswordReset = json['date_password_reset'];
    branchName = json['branch_name'];
    branchCode = json['branch_code'];
    branchAddress = json['branch_address'];
    accessToken = json['access_token'];
    queueName = json['queue_name'];
    queueRole = json['queue_role'];
    passwordChat = json['password_chat'];
    tokenMd5 = json['token_md5'];
    logo = json['logo'] != null
        ? new BrandScanResponseModel.fromJson(json['logo'])
        : null;
    isCheckinGPS = json['is_checkin_gps'];
    isCheckinWifi = json['is_checkin_wifi'];
    checkInLimit = json['check_in_limit'];
    linkGetIp = json['link_get_ip'];
    isDisabledPrice = json['is_disabled_price'];
    decimalNumber = int.tryParse((json['decimal_number'] ?? 0).toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['department_id'] = this.departmentId;
    data['department_name'] = this.departmentName;
    data['branch_id'] = this.branchId;
    data['staff_title_id'] = this.staffTitleId;
    data['user_name'] = this.userName;
    data['password'] = this.password;
    data['salt'] = this.salt;
    data['full_name'] = this.fullName;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['phone1'] = this.phone1;
    data['phone2'] = this.phone2;
    data['email'] = this.email;
    data['facebook'] = this.facebook;
    data['date_last_login'] = this.dateLastLogin;
    data['is_admin'] = this.isAdmin;
    data['is_actived'] = this.isActived;
    data['is_deleted'] = this.isDeleted;
    data['staff_avatar'] = this.staffAvatar;
    data['address'] = this.address;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['remember_token'] = this.rememberToken;
    data['is_master'] = this.isMaster;
    data['staff_code'] = this.staffCode;
    data['salary'] = this.salary;
    data['subsidize'] = this.subsidize;
    data['commission_rate'] = this.commissionRate;
    data['password_reset'] = this.passwordReset;
    data['date_password_reset'] = this.datePasswordReset;
    data['branch_name'] = this.branchName;
    data['branch_code'] = this.branchCode;
    data['branch_address'] = this.branchAddress;
    data['access_token'] = this.accessToken;
    data['queue_name'] = this.queueName;
    data['queue_role'] = this.queueRole;
    data['password_chat'] = this.passwordChat;
    data['token_md5'] = this.tokenMd5;
    if (this.logo != null) {
      data['logo'] = this.logo!.toJson();
    }
    data['is_checkin_gps'] = this.isCheckinGPS;
    data['is_checkin_wifi'] = this.isCheckinWifi;
    data['check_in_limit'] = this.checkInLimit;
    data['link_get_ip'] = this.linkGetIp;
    data['is_disabled_price'] = this.isDisabledPrice;
    data['decimal_number'] = this.decimalNumber;
    return data;
  }
}
