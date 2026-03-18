class CustomerNoteStoreRequestModel {
  int? customerId;
  String? note;

  CustomerNoteStoreRequestModel({this.customerId, this.note});

  CustomerNoteStoreRequestModel.fromJson(Map<String, dynamic> json) {
    customerId = json['customer_id'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_id'] = this.customerId;
    data['note'] = this.note;
    return data;
  }
}
