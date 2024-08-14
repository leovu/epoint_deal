class OrderServiceCardDetailResponseModel {
  int? serviceCardId;
  String? code;
  int? serviceCardGroupId;
  String? groupName;
  String? serviceCardType;
  int? dateUsing;
  int? numberUsing;
  String? name;
  double? price;
  String? image;
  String? description;
  String? typeReferCommission;
  String? referCommissionValue;
  String? typeStaffCommission;
  String? staffCommissionValue;

  OrderServiceCardDetailResponseModel(
      {this.serviceCardId,
        this.code,
        this.serviceCardGroupId,
        this.groupName,
        this.serviceCardType,
        this.dateUsing,
        this.numberUsing,
        this.name,
        this.price,
        this.image,
        this.description,
        this.typeReferCommission,
        this.referCommissionValue,
        this.typeStaffCommission,
        this.staffCommissionValue});

  OrderServiceCardDetailResponseModel.fromJson(Map<String, dynamic> json) {
    serviceCardId = json['service_card_id'];
    code = json['code'];
    serviceCardGroupId = json['service_card_group_id'];
    groupName = json['group_name'];
    serviceCardType = json['service_card_type'];
    dateUsing = json['date_using'];
    numberUsing = json['number_using'];
    name = json['name'];
    price = double.tryParse((json['price'] ?? 0.0).toString());
    image = json['image'];
    description = json['description'];
    typeReferCommission = json['type_refer_commission'];
    referCommissionValue = json['refer_commission_value'];
    typeStaffCommission = json['type_staff_commission'];
    staffCommissionValue = json['staff_commission_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['service_card_id'] = this.serviceCardId;
    data['code'] = this.code;
    data['service_card_group_id'] = this.serviceCardGroupId;
    data['group_name'] = this.groupName;
    data['service_card_type'] = this.serviceCardType;
    data['date_using'] = this.dateUsing;
    data['number_using'] = this.numberUsing;
    data['name'] = this.name;
    data['price'] = this.price;
    data['image'] = this.image;
    data['description'] = this.description;
    data['type_refer_commission'] = this.typeReferCommission;
    data['refer_commission_value'] = this.referCommissionValue;
    data['type_staff_commission'] = this.typeStaffCommission;
    data['staff_commission_value'] = this.staffCommissionValue;
    return data;
  }
}
