class ConfigResponseModel {
  List<ConfigModel>? data;

  ConfigResponseModel({this.data});

  ConfigResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ConfigModel>[];
      json.forEach((v) {
        data!.add(new ConfigModel.fromJson(v));
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

class ConfigModel {
  int? id;
  String? title;
  String? key;
  String? value;
  int? parentId;
  String? description;

  ConfigModel(
      {this.id,
        this.title,
        this.key,
        this.value,
        this.parentId,
        this.description});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    key = json['key'];
    value = json['value'];
    parentId = json['parent_id'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['key'] = this.key;
    data['value'] = this.value;
    data['parent_id'] = this.parentId;
    data['description'] = this.description;
    return data;
  }
}
