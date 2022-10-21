class CustomerTypeModel {
  String customerTypeName;
  String customerTypeNameEn;
  int customerTypeID;
  bool selected;

  CustomerTypeModel({this.customerTypeName,this.customerTypeNameEn, this.customerTypeID, this.selected});

  factory CustomerTypeModel.fromJson(Map<String, dynamic> parsedJson) {
    return CustomerTypeModel(
        customerTypeName: parsedJson['customerTypeName'],
        customerTypeID: parsedJson['customerTypeID'],
        customerTypeNameEn: parsedJson['customerTypeNameEn'],
        selected: parsedJson['selected']);
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['customerTypeName'] = this.customerTypeName;
  //   data['customerTypeID'] = this.customerTypeID;
  //   data['selected'] = this.selected;
  //   return data;
  // }
}