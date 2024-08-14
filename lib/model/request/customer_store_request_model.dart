class CustomerStoreRequestModel {
  int? customerId;
  String? fullName;
  String? phone;
  int? customerGroupId;
  String? customerType;
  String? birthday;
  int? provinceId;
  int? districtId;
  int? wardId;
  String? address;
  String? email;
  String? gender;
  int? customerSourceId;
  int? customerReferId;
  String? zalo;
  String? facebook;
  String? customerAvatar;
  int? branchId;
  String? profileCode;
  int? bussinessId;
  String? taxCode;
  String? hotline;
  String? representative;
  int? employeeCount;
  List<CustomerStoreContactModel>? customerPersonContacts;

  CustomerStoreRequestModel(
      {this.customerId,
        this.fullName,
        this.phone,
        this.customerGroupId,
        this.customerType,
        this.birthday,
        this.provinceId,
        this.districtId,
        this.wardId,
        this.address,
        this.email,
        this.gender,
        this.customerSourceId,
        this.customerReferId,
        this.zalo,
        this.facebook,
        this.customerAvatar,
        this.branchId,
        this.profileCode,
        this.bussinessId,
        this.taxCode,
        this.hotline,
        this.representative,
        this.employeeCount,
        this.customerPersonContacts});

  CustomerStoreRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    fullName = json['full_name'];
    phone = json['phone'];
    customerGroupId = json['customer_group_id'];
    customerType = json['customer_type'];
    birthday = json['birthday'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    address = json['address'];
    email = json['email'];
    gender = json['gender'];
    customerSourceId = json['customer_source_id'];
    customerReferId = json['customer_refer_id'];
    zalo = json['zalo'];
    facebook = json['facebook'];
    customerAvatar = json['customer_avatar'];
    branchId = json['branch_id'];
    profileCode = json['profile_code'];
    bussinessId = json['bussiness_id'];
    taxCode = json['tax_code'];
    hotline = json['hotline'];
    representative = json['representative'];
    employeeCount = json['employee_count'];
    if (json['customer_person_contacts'] != null) {
      customerPersonContacts = <CustomerStoreContactModel>[];
      json['customer_person_contacts'].forEach((v) {
        customerPersonContacts!.add(new CustomerStoreContactModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['customer_group_id'] = this.customerGroupId;
    data['customer_type'] = this.customerType;
    data['birthday'] = this.birthday;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    data['ward_id'] = this.wardId;
    data['address'] = this.address;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['customer_source_id'] = this.customerSourceId;
    data['customer_refer_id'] = this.customerReferId;
    data['zalo'] = this.zalo;
    data['facebook'] = this.facebook;
    data['customer_avatar'] = this.customerAvatar;
    data['branch_id'] = this.branchId;
    data['profile_code'] = this.profileCode;
    data['bussiness_id'] = this.bussinessId;
    data['tax_code'] = this.taxCode;
    data['hotline'] = this.hotline;
    data['representative'] = this.representative;
    data['employee_count'] = this.employeeCount;
    if (this.customerPersonContacts != null) {
      data['customer_person_contacts'] =
          this.customerPersonContacts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerStoreContactModel {
  String? personName;
  String? personPhone;
  String? personEmail;
  int? staffTitleId;

  CustomerStoreContactModel(
      {this.personName, this.personPhone, this.personEmail, this.staffTitleId});

  CustomerStoreContactModel.fromJson(Map<String, dynamic> json) {
    personName = json['person_name'];
    personPhone = json['person_phone'];
    personEmail = json['person_email'];
    staffTitleId = json['staff_title_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['person_name'] = this.personName;
    data['person_phone'] = this.personPhone;
    data['person_email'] = this.personEmail;
    data['staff_title_id'] = this.staffTitleId;
    return data;
  }
}
