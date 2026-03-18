class ProjectTagsResponseModel {
  List<ProjectTagsModel>? data;

  ProjectTagsResponseModel({this.data});

  ProjectTagsResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProjectTagsModel>[];
      json.forEach((v) {
        data!.add(new ProjectTagsModel.fromJson(v));
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

class ProjectTagsModel {
  int? manageTagId;
  String? manageTagName;
  bool? isSelected;

  ProjectTagsModel({
    this.manageTagId,
    this.manageTagName,
    this.isSelected = false,
  });

  ProjectTagsModel.fromJson(Map<String, dynamic> json) {
    manageTagId = json['manage_tag_id'];
    manageTagName = json['manage_tag_name'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_tag_id'] = this.manageTagId;
    data['manage_tag_name'] = this.manageTagName;
    return data;
  }
}

