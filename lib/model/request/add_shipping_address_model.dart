class AddShippingRequestModel {
  String? brandCode;
  int? customerId;
  int? customerContactId;
  String? phone;
  String? fullName;
  String? address;
  int? provinceId;
  int? districtId;
  int? wardId;
  int? addressDefault;

  AddShippingRequestModel(
      {this.brandCode,
        this.customerId,
        this.customerContactId,
        this.phone,
        this.fullName,
        this.address,
        this.provinceId,
        this.districtId,
        this.wardId,
        this.addressDefault});

  AddShippingRequestModel.fromJson(Map<String, dynamic> json) {
    brandCode = json['brand_code'];
    customerId = json['customer_id'];
    customerContactId = json['customer_contact_id'];
    phone = json['phone'];
    fullName = json['full_name'];
    address = json['address'];
    provinceId = json['province_id'];
    districtId = json['district_id'];
    wardId = json['ward_id'];
    addressDefault = json['address_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['brand_code'] = this.brandCode;
    data['customer_id'] = this.customerId;
    if(this.customerContactId != null) {
      data['customer_contact_id'] = this.customerContactId;
    }
    data['phone'] = this.phone;
    data['full_name'] = this.fullName;
    data['address'] = this.address;
    data['province_id'] = this.provinceId;
    data['district_id'] = this.districtId;
    data['ward_id'] = this.wardId;
    data['address_default'] = this.addressDefault;
    return data;
  }
}