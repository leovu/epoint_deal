class OrderHistoryResponseModel {
  int? errorCode;
  String? errorDescription;
  List<OrderHistoryData>? data;

  OrderHistoryResponseModel({this.errorCode, this.errorDescription, this.data});

  OrderHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    if (json['Data'] != null) {
      data = <OrderHistoryData>[];
      json['Data'].forEach((v) {
        data!.add(new OrderHistoryData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderHistoryData {
  int? orderId;
  String? orderCode;
  int? total;
  int? discount;
  int? amount;
  int? branchId;
  String? branchName;
  int? orderSourceId;
  int? receiveAtCounter;
  String? processStatus;
  String? createdAt;
  String? deliveryRequestDate;
  String? shippingAddress;
  String? contactName;
  String? contactPhone;
  String? pickupTime;
  String? dealCode;
  String? cashierDate;
  String? timeAddress;
  int? customerId;
  String? customerCode;
  String? fullName;
  String? phone;
  String? processStatusName;
  int? countProd;

  OrderHistoryData(
      {this.orderId,
      this.orderCode,
      this.total,
      this.discount,
      this.amount,
      this.branchId,
      this.branchName,
      this.orderSourceId,
      this.receiveAtCounter,
      this.processStatus,
      this.createdAt,
      this.deliveryRequestDate,
      this.shippingAddress,
      this.contactName,
      this.contactPhone,
      this.pickupTime,
      this.dealCode,
      this.cashierDate,
      this.timeAddress,
      this.customerId,
      this.customerCode,
      this.fullName,
      this.phone,
      this.processStatusName,
      this.countProd});

  OrderHistoryData.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    orderCode = json['order_code'];
    total = json['total'];
    discount = json['discount'];
    amount = json['amount'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    orderSourceId = json['order_source_id'];
    receiveAtCounter = json['receive_at_counter'];
    processStatus = json['process_status'];
    createdAt = json['created_at'];
    deliveryRequestDate = json['delivery_request_date'];
    shippingAddress = json['shipping_address'];
    contactName = json['contact_name'];
    contactPhone = json['contact_phone'];
    pickupTime = json['pickup_time'];
    dealCode = json['deal_code'];
    cashierDate = json['cashier_date'];
    timeAddress = json['time_address'];
    customerId = json['customer_id'];
    customerCode = json['customer_code'];
    fullName = json['full_name'];
    phone = json['phone'];
    processStatusName = json['process_status_name'];
    countProd = json['count_prod'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['order_code'] = this.orderCode;
    data['total'] = this.total;
    data['discount'] = this.discount;
    data['amount'] = this.amount;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['order_source_id'] = this.orderSourceId;
    data['receive_at_counter'] = this.receiveAtCounter;
    data['process_status'] = this.processStatus;
    data['created_at'] = this.createdAt;
    data['delivery_request_date'] = this.deliveryRequestDate;
    data['shipping_address'] = this.shippingAddress;
    data['contact_name'] = this.contactName;
    data['contact_phone'] = this.contactPhone;
    data['pickup_time'] = this.pickupTime;
    data['deal_code'] = this.dealCode;
    data['cashier_date'] = this.cashierDate;
    data['time_address'] = this.timeAddress;
    data['customer_id'] = this.customerId;
    data['customer_code'] = this.customerCode;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    data['process_status_name'] = this.processStatusName;
    data['count_prod'] = this.countProd;
    return data;
  }
}
