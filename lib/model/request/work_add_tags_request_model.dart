class WorkAddTagsRequestModel {
  String? manageTagName;

  WorkAddTagsRequestModel({this.manageTagName});

  WorkAddTagsRequestModel.fromJson(Map<String, dynamic> json) {
    manageTagName = json['manage_tag_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_tag_name'] = this.manageTagName;
    return data;
  }
}