class CustomerServiceCardDetailResponseModel {
  int? customerServiceCardId;
  String? name;
  double? price;
  String? serviceCardType;
  String? serviceCardTypeName;
  int? activeId;
  String? activeName;
  String? cardCode;
  String? expiredDate;
  String? activedDate;
  int? isActived;
  int? numberUsing;
  int? countUsing;
  int? remainAmount;
  int? status;
  String? customerTypeName;
  int? customerId;
  int? orderId;
  String? orderCode;
  String? activedAt;
  int? orderCreatedBy;
  String? orderCreatedName;
  String? orderCreatedDate;
  String? createdAt;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? customerName;

  CustomerServiceCardDetailResponseModel(
      {this.customerServiceCardId,
        this.name,
        this.price,
        this.serviceCardType,
        this.serviceCardTypeName,
        this.activeId,
        this.activeName,
        this.cardCode,
        this.expiredDate,
        this.activedDate,
        this.isActived,
        this.numberUsing,
        this.countUsing,
        this.remainAmount,
        this.status,
        this.customerTypeName,
        this.customerId,
        this.orderId,
        this.orderCode,
        this.activedAt,
        this.orderCreatedBy,
        this.orderCreatedDate,
        this.orderCreatedName,
        this.createdAt,
        this.createdBy,
        this.updatedBy,
        this.staffCreatedName,
        this.staffUpdatedName,
        this.customerName});

  CustomerServiceCardDetailResponseModel.fromJson(Map<String, dynamic> json) {
    customerServiceCardId = json['customer_service_card_id'];
    name = json['name'];
    price = double.tryParse((json['price'] ?? 0.0).toString());
    serviceCardType = json['service_card_type'];
    serviceCardTypeName = json['service_card_type_name'];
    activeId = json['active_id'];
    activeName = json['active_name'];
    cardCode = json['card_code'];
    expiredDate = json['expired_date'];
    activedDate = json['actived_date'];
    isActived = json['is_actived'];
    numberUsing = json['number_using'];
    countUsing = json['count_using'];
    remainAmount = json['remain_amount'];
    status = json['status'];
    customerTypeName = json['customer_type_name'];
    customerId = json['customer_id'];
    orderId = json['order_id'];
    orderCode = json['order_code'];
    activedAt = json['actived_at'];
    orderCreatedBy = json['order_created_by'];
    orderCreatedDate = json['order_created_date'];
    orderCreatedName = json['order_created_name'];
    createdAt = json['created_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    customerName = json['customer_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_service_card_id'] = this.customerServiceCardId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['service_card_type'] = this.serviceCardType;
    data['service_card_type_name'] = this.serviceCardTypeName;
    data['active_id'] = this.activeId;
    data['active_name'] = this.activeName;
    data['card_code'] = this.cardCode;
    data['expired_date'] = this.expiredDate;
    data['actived_date'] = this.activedDate;
    data['is_actived'] = this.isActived;
    data['number_using'] = this.numberUsing;
    data['count_using'] = this.countUsing;
    data['remain_amount'] = this.remainAmount;
    data['status'] = this.status;
    data['customer_type_name'] = this.customerTypeName;
    data['customer_id'] = this.customerId;
    data['order_id'] = this.orderId;
    data['order_code'] = this.orderCode;
    data['actived_at'] = this.activedAt;
    data['order_created_by'] = this.orderCreatedBy;
    data['order_created_date'] = this.orderCreatedDate;
    data['order_created_name'] = this.orderCreatedName;
    data['created_at'] = this.createdAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['customer_name'] = this.customerName;
    return data;
  }
}
