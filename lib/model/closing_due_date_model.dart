class ClosingDueDateModel {
  String closingDueDateName;
  int closingDueDateID;
  bool selected;

  ClosingDueDateModel({this.closingDueDateName, this.closingDueDateID, this.selected});

  factory ClosingDueDateModel.fromJson(Map<String, dynamic> parsedJson) {
    return ClosingDueDateModel(
        closingDueDateName: parsedJson['closingDueDateName'],
        closingDueDateID: parsedJson['closingDueDateID'],
        selected: parsedJson['selected']);
  }
}