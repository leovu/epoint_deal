
import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CustomerResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerModel>? items;

  CustomerResponseModel({this.pageInfo, this.items});

  CustomerResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerModel {
  int? customerId;
  String? fullName;
  String? birthday;
  String? gender;
  String? email;
  String? phone;
  String? customerCode;
  String? customerAvatar;
  int? customerGroupId;
  String? groupName;
  String? fullAddress;
  String? customerType;
  String? customerTypeName;
  String? createdAt;
  String? zalo;
  int? serviceCardActivedQuantity;
  List<DeliveryAddress>? deliveryAddress;

  CustomerModel(
      {this.customerId,
      this.fullName,
      this.birthday,
      this.gender,
      this.email,
      this.phone,
      this.customerCode,
      this.customerAvatar,
      this.customerGroupId,
      this.groupName,
      this.fullAddress,
      this.customerType,
      this.customerTypeName,
      this.createdAt,
      this.zalo,
      this.serviceCardActivedQuantity,
      this.deliveryAddress});

  CustomerModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    fullName = json['full_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    email = json['email'];
    phone = json['phone'];
    customerCode = json['customer_code'];
    customerAvatar = json['customer_avatar'];
    customerGroupId = json['customer_group_id'];
    groupName = json['group_name'];
    fullAddress = json['full_address'];
    customerType = json['customer_type'];
    customerTypeName = json['customer_type_name'];
    createdAt = json['created_at'];
    zalo = json['zalo'];
    serviceCardActivedQuantity = json['service_card_actived_quantity'];
    if (json['delivery_address'] != null) {
      deliveryAddress = <DeliveryAddress>[];
      json['delivery_address'].forEach((v) {
        deliveryAddress!.add(new DeliveryAddress.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['full_name'] = this.fullName;
    data['birthday'] = this.birthday;
    data['gender'] = this.gender;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['customer_code'] = this.customerCode;
    data['customer_avatar'] = this.customerAvatar;
    data['customer_group_id'] = this.customerGroupId;
    data['group_name'] = this.groupName;
    data['full_address'] = this.fullAddress;
    data['customer_type'] = this.customerType;
    data['customer_type_name'] = this.customerTypeName;
    data['created_at'] = this.createdAt;
    data['zalo'] = this.zalo;
    data['service_card_actived_quantity'] = this.serviceCardActivedQuantity;
    if (this.deliveryAddress != null) {
      data['delivery_address'] =
          this.deliveryAddress!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DeliveryAddress {
  int? customerContactId;
  String? customerContactCode;
  String? contactName;
  String? contactPhone;
  String? fullAddress;
  int? addressDefault;
  String? postcode;
  bool? selected;
  int? provinceId;
  int? districtId;
  int? wardId;
  String? provinceName;
  String? districtName;
  String? wardName;
  String? address;

  DeliveryAddress(
      {this.customerContactId,
      this.customerContactCode,
      this.contactName,
      this.contactPhone,
      this.fullAddress,
      this.addressDefault,
      this.postcode,
      this.selected,
      this.provinceId,
      this.districtId,
      this.wardId,
      this.provinceName,
      this.districtName,
      this.wardName,
      this.address});

  DeliveryAddress.fromJson(Map<String, dynamic> json) {
    customerContactId = json['customer_contact_id'];
    customerContactCode = json['customer_contact_code'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    fullAddress = json['full_address'];
    addressDefault = json['address_default'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    provinceName = json['province_name'];
    districtName = json['district_name'];
    wardName = json['ward_name'];
    address = json['address'];
    postcode = json['postcode'];
    selected = addressDefault == 1 ? true : false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_contact_id'] = this.customerContactId;
    data['customer_contact_code'] = this.customerContactCode;
    data['contact_name'] = this.contactName;
    data['contact_phone'] = this.contactPhone;
    data['full_address'] = this.fullAddress;
    data['address_default'] = this.addressDefault;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    data['ward_id'] = this.wardId;
    data['province_name'] = this.provinceName;
    data['district_name'] = this.districtName;
    data['ward_name'] = this.wardName;
    data['address'] = this.address;
    data['postcode'] = this.postcode;
    return data;
  }
}
