class WorkSearchOverdueResponseModel {
  List<WorkSearchOverdueModel>? data;

  WorkSearchOverdueResponseModel({this.data});

  WorkSearchOverdueResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkSearchOverdueModel>[];
      json.forEach((v) {
        data!.add(new WorkSearchOverdueModel.fromJson(v));
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

class WorkSearchOverdueModel {
  String? dateEnd;

  WorkSearchOverdueModel({this.dateEnd});

  WorkSearchOverdueModel.fromJson(Map<String, dynamic> json) {
    dateEnd = json['date_end'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date_end'] = this.dateEnd;
    return data;
  }
}