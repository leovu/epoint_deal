class ProjectCustomerTypeResponseModel {

  List<ProjectCustomerTypeModel>? data;

  ProjectCustomerTypeResponseModel({this.data});

  ProjectCustomerTypeResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <ProjectCustomerTypeModel>[];
      json.forEach((v) {
        data!.add(new ProjectCustomerTypeModel.fromJson(v));
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

class ProjectCustomerTypeModel{
  int? typeId;
  String? typeName;
  String? typeCode;
  bool? isSelected;

  ProjectCustomerTypeModel({
    this.typeId,
    this.typeName,
    this.typeCode,
    this.isSelected = true,
  });

  ProjectCustomerTypeModel.fromJson(Map<String, dynamic> json) {
    typeId = json['type_id'];
    typeName = json['type_name'];
    typeCode = json['type_code'];
    isSelected = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type_id'] = this.typeId;
    data['type_name'] = this.typeName;
    data['type_code'] = this.typeCode;
    return data;
  }
}
