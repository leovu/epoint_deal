

import 'package:epoint_deal_plugin/model/response/customer_response_model.dart';

class CustomerDetailResponseModel {
  int? customerId;
  String? fullName;
  String? customerCode;
  String? gender;
  String? phone;
  String? provinceName;
  String? districtName;
  String? wardName;
  int? provinceId;
  int? districtId;
  int? wardId;
  String? address;
  String? email;
  String? birthday;
  int? customerGroupId;
  int? customerSourceId;
  String? customerSourceName;
  String? groupName;
  int? customerReferId;
  String? referName;
  String? customerAvatar;
  double? point;
  int? memberLevelId;
  String? level;
  String? zalo;
  String? facebook;
  String? note;
  String? customerType;
  String? customerTypeName;
  String? createdDate;
  String? updatedDate;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? taxCode;
  String? representative;
  String? profileCode;
  int? bussinessId;
  String? businessName;
  int? branchId;
  String? branchName;
  String? hotline;
  int? employeeCount;
  String? fullAddress;
  List<DeliveryAddress>? deliveryAddress;
  List<CustomerDetailTagModel>? tags;
  List<CustomerDetailConfigModel>? tabConfigs;
  CustomerDetailContactModel? customerPersonContact;

  CustomerDetailResponseModel(
      {this.customerId,
      this.fullName,
      this.customerCode,
      this.gender,
      this.phone,
      this.provinceName,
      this.districtName,
      this.wardName,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.address,
      this.email,
      this.birthday,
      this.customerGroupId,
      this.customerSourceId,
      this.customerSourceName,
      this.groupName,
      this.customerReferId,
      this.referName,
      this.customerAvatar,
      this.point,
      this.memberLevelId,
      this.level,
      this.zalo,
      this.facebook,
      this.note,
      this.customerType,
      this.customerTypeName,
      this.createdDate,
      this.updatedDate,
      this.createdBy,
      this.updatedBy,
      this.staffCreatedName,
      this.staffUpdatedName,
      this.taxCode,
      this.representative,
      this.profileCode,
      this.bussinessId,
      this.businessName,
      this.branchId,
      this.branchName,
      this.hotline,
      this.employeeCount,
      this.fullAddress,
      this.deliveryAddress,
      this.tags,
      this.tabConfigs,
      this.customerPersonContact});

  CustomerDetailResponseModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    fullName = json['full_name'];
    customerCode = json['customer_code'];
    gender = json['gender'];
    phone = json['phone'];
    provinceName = json['province_name'];
    districtName = json['district_name'];
    wardName = json['ward_name'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    address = json['address'];
    email = json['email'];
    birthday = json['birthday'];
    customerGroupId = json['customer_group_id'];
    customerSourceId = json['customer_source_id'];
    customerSourceName = json['customer_source_name'];
    groupName = json['group_name'];
    customerReferId = json['customer_refer_id'];
    referName = json['refer_name'];
    customerAvatar = json['customer_avatar'];
    point = double.tryParse((json['point'] ?? 0.0).toString());
    memberLevelId = json['member_level_id'];
    level = json['level'];
    zalo = json['zalo'];
    facebook = json['facebook'];
    note = json['note'];
    customerType = json['customer_type'];
    customerTypeName = json['customer_type_name'];
    createdDate = json['created_date'];
    updatedDate = json['updated_date'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    taxCode = json['tax_code'];
    representative = json['representative'];
    profileCode = json['profile_code'];
    bussinessId = json['bussiness_id'];
    businessName = json['business_name'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    hotline = json['hotline'];
    employeeCount = json['employee_count'];
    fullAddress = json['full_address'];
    if (json['delivery_address'] != null) {
      deliveryAddress = <DeliveryAddress>[];
      json['delivery_address'].forEach((v) {
        deliveryAddress!.add(new DeliveryAddress.fromJson(v));
      });
    }
    if (json['tags'] != null) {
      tags = <CustomerDetailTagModel>[];
      json['tags'].forEach((v) {
        tags!.add(new CustomerDetailTagModel.fromJson(v));
      });
    }
    if (json['tab_configs'] != null) {
      tabConfigs = <CustomerDetailConfigModel>[];
      final events = <CustomerDetailConfigModel>[];
      json['tab_configs'].forEach((v) {
        events.add(new CustomerDetailConfigModel.fromJson(v));
      });
      for (var e in events) {
        if (tabConfigs!.isEmpty) {
          tabConfigs!.add(e);
        } else {
          for (var i = 0; i < tabConfigs!.length; i++) {
            if (i == (tabConfigs!.length - 1)) {
              if ((e.sortOrder ?? 0) > (tabConfigs!.last.sortOrder ?? 0)) {
                tabConfigs!.add(e);
              } else {
                tabConfigs!.insert(i, e);
              }
              break;
            } else {
              final currentItem = tabConfigs![i];
              if ((e.sortOrder ?? 0) <= (currentItem.sortOrder ?? 0)) {
                tabConfigs!.insert(i, e);
                break;
              } else {
                final nextItem = tabConfigs![i + 1];
                if ((e.sortOrder ?? 0) <= (nextItem.sortOrder ?? 0)) {
                  tabConfigs!.insert(i + 1, e);
                  break;
                }
              }
            }
          }
        }
      }
    }
    customerPersonContact = (json['customer_person_contact'] != null &&
            json['customer_person_contact'] is Map<String, dynamic>)
        ? new CustomerDetailContactModel.fromJson(
            json['customer_person_contact'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['full_name'] = this.fullName;
    data['customer_code'] = this.customerCode;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['province_name'] = this.provinceName;
    data['district_name'] = this.districtName;
    data['ward_name'] = this.wardName;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    data['ward_id'] = this.wardId;
    data['address'] = this.address;
    data['email'] = this.email;
    data['birthday'] = this.birthday;
    data['customer_group_id'] = this.customerGroupId;
    data['customer_source_id'] = this.customerSourceId;
    data['customer_source_name'] = this.customerSourceName;
    data['group_name'] = this.groupName;
    data['customer_refer_id'] = this.customerReferId;
    data['refer_name'] = this.referName;
    data['customer_avatar'] = this.customerAvatar;
    data['point'] = this.point;
    data['member_level_id'] = this.memberLevelId;
    data['level'] = this.level;
    data['zalo'] = this.zalo;
    data['facebook'] = this.facebook;
    data['note'] = this.note;
    data['customer_type'] = this.customerType;
    data['customer_type_name'] = this.customerTypeName;
    data['created_date'] = this.createdDate;
    data['updated_date'] = this.updatedDate;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['tax_code'] = this.taxCode;
    data['representative'] = this.representative;
    data['profile_code'] = this.profileCode;
    data['bussiness_id'] = this.bussinessId;
    data['business_name'] = this.businessName;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['hotline'] = this.hotline;
    data['employee_count'] = this.employeeCount;
    data['full_address'] = this.fullAddress;
    if (this.deliveryAddress != null) {
      data['delivery_address'] =
          this.deliveryAddress!.map((v) => v.toJson()).toList();
    }
    if (this.tags != null) {
      data['tags'] = this.tags!.map((v) => v.toJson()).toList();
    }
    if (this.tabConfigs != null) {
      data['tab_configs'] = this.tabConfigs!.map((v) => v.toJson()).toList();
    }
    if (this.customerPersonContact != null) {
      data['customer_person_contact'] = this.customerPersonContact!.toJson();
    }
    return data;
  }
}

class CustomerDetailTagModel {
  int? tagId;
  String? keyword;
  String? name;

  CustomerDetailTagModel({this.tagId, this.keyword, this.name});

  CustomerDetailTagModel.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    keyword = json['keyword'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    data['keyword'] = this.keyword;
    data['name'] = this.name;
    return data;
  }
}

class CustomerDetailConfigModel {
  int? customerConfigTabDetailId;
  String? tabNameVi;
  String? tabNameEn;
  int? sortOrder;
  double? total;
  String? code;

  CustomerDetailConfigModel(
      {this.customerConfigTabDetailId,
      this.tabNameVi,
      this.tabNameEn,
      this.sortOrder,
      this.total,
      this.code});

  CustomerDetailConfigModel.fromJson(Map<String, dynamic> json) {
    customerConfigTabDetailId = json['customer_config_tab_detail_id'];
    tabNameVi = json['tab_name_vi'];
    tabNameEn = json['tab_name_en'];
    sortOrder = json['sort_order'];
    total = json['total'] == null
        ? null
        : double.tryParse(json['total'].toString());
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_config_tab_detail_id'] = this.customerConfigTabDetailId;
    data['tab_name_vi'] = this.tabNameVi;
    data['tab_name_en'] = this.tabNameEn;
    data['sort_order'] = this.sortOrder;
    data['total'] = this.total;
    data['code'] = this.code;
    return data;
  }
}

class CustomerDetailContactModel {
  int? customerPersonContactId;
  String? personName;
  String? personPhone;
  String? personEmail;
  int? staffTitleId;
  String? staffTitleName;
  int? createdBy;
  String? staffCreatedName;
  String? createdAt;

  CustomerDetailContactModel(
      {this.customerPersonContactId,
      this.personName,
      this.personPhone,
      this.personEmail,
      this.staffTitleId,
      this.staffTitleName,
      this.createdBy,
      this.staffCreatedName,
      this.createdAt});

  CustomerDetailContactModel.fromJson(Map<String, dynamic> json) {
    customerPersonContactId = json['customer_person_contact_id'];
    personName = json['person_name'];
    personPhone = json['person_phone'];
    personEmail = json['person_email'];
    staffTitleId = json['staff_title_id'];
    staffTitleName = json['staff_title_name'];
    createdBy = json['created_by'];
    staffCreatedName = json['staff_created_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_person_contact_id'] = this.customerPersonContactId;
    data['person_name'] = this.personName;
    data['person_phone'] = this.personPhone;
    data['person_email'] = this.personEmail;
    data['staff_title_id'] = this.staffTitleId;
    data['staff_title_name'] = this.staffTitleName;
    data['created_by'] = this.createdBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
