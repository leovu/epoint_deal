class TicketHistoryResponseModel {
  List<TicketHistoryModel>? data;

  TicketHistoryResponseModel({this.data});

  TicketHistoryResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketHistoryModel>[];
      json.forEach((v) {
        data!.add(new TicketHistoryModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TicketHistoryModel {
  String? createdName;
  String? createdAt;
  String? note;

  TicketHistoryModel({this.createdName, this.createdAt, this.note});

  TicketHistoryModel.fromJson(Map<String, dynamic> json) {
    createdName = json['created_name'];
    createdAt = json['created_at'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['created_name'] = this.createdName;
    data['created_at'] = this.createdAt;
    data['note'] = this.note;
    return data;
  }
}