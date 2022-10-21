class ClosingDateModel {
  String closingDateName;
  int closingDateID;
  bool selected;

  ClosingDateModel({this.closingDateName, this.closingDateID, this.selected});

  factory ClosingDateModel.fromJson(Map<String, dynamic> parsedJson) {
    return ClosingDateModel(
        closingDateName: parsedJson['closingDateName'],
        closingDateID: parsedJson['closingDateID'],
        selected: parsedJson['selected']);
  }
}