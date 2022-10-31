class AddDealModelRequest {
  String dealName;
  int saleId;
  String typeCustomer;
  String customerCode;
  String phone;
  String pipelineCode;
  String journeyCode;
  String closingDate;
  String branchCode;
  List<int> tag;
  int orderSourceId;
  double probability;
  String dealDescription;
  double amount;
  List<Product> product;

  AddDealModelRequest(
      {this.dealName,
      this.saleId,
      this.typeCustomer,
      this.customerCode,
      this.phone,
      this.pipelineCode,
      this.journeyCode,
      this.closingDate,
      this.branchCode,
      this.tag,
      this.orderSourceId,
      this.probability,
      this.dealDescription,
      this.amount,
      this.product});

  AddDealModelRequest.fromJson(Map<String, dynamic> json) {
    dealName = json['deal_name'];
    saleId = json['sale_id'];
    typeCustomer = json['type_customer'];
    customerCode = json['customer_code'];
    phone = json['phone'];
    pipelineCode = json['pipeline_code'];
    journeyCode = json['journey_code'];
    closingDate = json['closing_date'];
    branchCode = json['branch_code'];
    tag = json['tag'].cast<int>();
    orderSourceId = json['order_source_id'];
    probability = json['probability'];
    dealDescription = json['deal_description'];
    amount = json['amount'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_name'] = this.dealName;
    data['sale_id'] = this.saleId;
    data['type_customer'] = this.typeCustomer;
    data['customer_code'] = this.customerCode;
    data['phone'] = this.phone;
    data['pipeline_code'] = this.pipelineCode;
    data['journey_code'] = this.journeyCode;
    data['closing_date'] = this.closingDate;
    data['branch_code'] = this.branchCode;
    data['tag'] = this.tag;
    data['order_source_id'] = this.orderSourceId;
    data['probability'] = this.probability;
    data['deal_description'] = this.dealDescription;
    data['amount'] = this.amount;
    if (this.product != null) {
      data['product'] = this.product.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
  String objectType;
  String objectName;
  String objectCode;
  int objectId;
  int quantity;
  num price;
  num amount;

  Product(
      {this.objectType,
      this.objectName,
      this.objectCode,
      this.objectId,
      this.quantity,
      this.price,
      this.amount});

  Product.fromJson(Map<String, dynamic> json) {
    objectType = json['object_type'];
    objectName = json['object_name'];
    objectCode = json['object_code'];
    objectId = json['object_id'];
    quantity = json['quantity'];
    price = json['price'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['object_type'] = this.objectType;
    data['object_name'] = this.objectName;
    data['object_code'] = this.objectCode;
    data['object_id'] = this.objectId;
    data['quantity'] = this.quantity;
    data['price'] = this.price;
    data['amount'] = this.amount;
    return data;
  }
}
