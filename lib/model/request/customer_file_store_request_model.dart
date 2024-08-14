class CustomerFileStoreRequestModel {
  int? customerId;
  List<String>? listFile;

  CustomerFileStoreRequestModel({this.customerId, this.listFile});

  CustomerFileStoreRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    listFile = json['list_file'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['list_file'] = this.listFile;
    return data;
  }
}
