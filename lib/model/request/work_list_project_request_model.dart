class WorkListProjectRequestModel {
  String? showProgram;

  WorkListProjectRequestModel({this.showProgram});

  WorkListProjectRequestModel.fromJson(Map<String, dynamic> json) {
    showProgram = json['show_program'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['show_program'] = this.showProgram;
    return data;
  }
}
