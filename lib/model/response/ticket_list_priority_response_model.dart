class TicketListPriorityResponseModel {
  List<TicketListPriorityModel>? data;

  TicketListPriorityResponseModel({this.data});

  TicketListPriorityResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketListPriorityModel>[];
      json.forEach((v) {
        data!.add(new TicketListPriorityModel.fromJson(v));
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

class TicketListPriorityModel {
  String? priorityId;
  String? priorityName;
  int? isDefault;

  TicketListPriorityModel({this.priorityId, this.priorityName, this.isDefault});

  TicketListPriorityModel.fromJson(Map<String, dynamic> json) {
    priorityId = json['priority_id'];
    priorityName = json['priority_name'];
    isDefault = json['is_defalut'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priority_id'] = this.priorityId;
    data['priority_name'] = this.priorityName;
    data['is_defalut'] = this.isDefault;
    return data;
  }
}
