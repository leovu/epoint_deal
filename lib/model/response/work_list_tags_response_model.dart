class WorkListTagsResponseModel {
  List<WorkListTagsModel>? data;

  WorkListTagsResponseModel({this.data});

  WorkListTagsResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkListTagsModel>[];
      json.forEach((v) {
        data!.add(new WorkListTagsModel.fromJson(v));
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

class WorkListTagsModel {
  int? manageTagId;
  String? manageTagName;
  String? manageTagIcon;
  late bool isSelected;

  WorkListTagsModel({this.manageTagId, this.manageTagName, this.manageTagIcon});

  WorkListTagsModel.fromJson(Map<String, dynamic> json) {
    manageTagId = json['manage_tag_id'];
    manageTagName = json['manage_tag_name'];
    manageTagIcon = json['manage_tag_icon'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_tag_id'] = this.manageTagId;
    data['manage_tag_name'] = this.manageTagName;
    data['manage_tag_icon'] = this.manageTagIcon;
    return data;
  }
}