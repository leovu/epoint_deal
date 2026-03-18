class TimeoffdaysStaffsListResponseModel {
  List<TimeoffdaysStaffsListModel>? data;

  TimeoffdaysStaffsListResponseModel({this.data});

  TimeoffdaysStaffsListResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TimeoffdaysStaffsListModel>[];
      json.forEach((v) {
        data!.add(new TimeoffdaysStaffsListModel.fromJson(v));
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

class TimeoffdaysStaffsListModel {
  int? staffId;
  String? fullName;
  String? staffAvatar;
  String? staffTitle;
  int? staffTitleId;
  int? isApprovce;

  TimeoffdaysStaffsListModel(
      {this.staffId,
        this.fullName,
        this.staffAvatar,
        this.staffTitle,
        this.staffTitleId,
        this.isApprovce});

  TimeoffdaysStaffsListModel.fromJson(Map<String, dynamic> json) {
    staffId = json['staff_id'];
    fullName = json['full_name'];
    staffAvatar = json['staff_avatar'];
    staffTitle = json['staff_title'];
    staffTitleId = json['staff_title_id'];
    isApprovce = json['is_approvce'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['staff_id'] = this.staffId;
    data['full_name'] = this.fullName;
    data['staff_avatar'] = this.staffAvatar;
    data['staff_title'] = this.staffTitle;
    data['staff_title_id'] = this.staffTitleId;
    data['is_approvce'] = this.isApprovce;
    return data;
  }
}
