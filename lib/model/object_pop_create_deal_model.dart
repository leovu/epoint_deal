class ObjectPopCreateDealModel {
  int? deal_id;
  bool? status;

  ObjectPopCreateDealModel({this.deal_id, this.status});

  factory ObjectPopCreateDealModel.fromJson(Map<String, dynamic> parsedJson) {
    return ObjectPopCreateDealModel(
        deal_id: parsedJson['deal_id'],
        status: parsedJson['status']);
  }
Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_id'] = this.deal_id;
     data['status'] = this.status;

    return data;
  }

}