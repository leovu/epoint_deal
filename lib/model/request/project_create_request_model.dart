class ProjectCreateRequestModel {
  String? projectName;
  String? projectDescribe;
  int? projectStatusId;
  int? managerId;
  int? departmentId;
  String? prefixCode;
  String? permission;
  String? dateStart;
  String? dateEnd;
  String? budget;
  String? contractCode;
  String? customerType;
  int? customerId;
  String? colorCode;
  int? isImportant;
  String? resource;
  String? progress;
  List<Tag>? tag;

  ProjectCreateRequestModel(
      {this.projectName,
        this.projectDescribe,
        this.projectStatusId,
        this.managerId,
        this.departmentId,
        this.prefixCode,
        this.permission,
        this.dateStart,
        this.dateEnd,
        this.budget,
        this.contractCode,
        this.customerType,
        this.customerId,
        this.colorCode,
        this.isImportant,
        this.resource,
        this.progress,
        this.tag});

  ProjectCreateRequestModel.fromJson(Map<String, dynamic> json) {
    projectName = json['project_name'];
    projectDescribe = json['project_describe'];
    projectStatusId = json['project_status_id'];
    managerId = json['manager_id'];
    departmentId = json['department_id'];
    prefixCode = json['prefix_code'];
    permission = json['permission'];
    dateStart = json['date_start'];
    dateEnd = json['date_end'];
    budget = json['budget'];
    contractCode = json['contract_code'];
    customerType = json['customer_type'];
    customerId = json['customer_id'];
    colorCode = json['color_code'];
    isImportant = json['is_important'];
    resource = json['resource'];
    progress = json['progress'];
    if (json['tag'] != null) {
      tag = <Tag>[];
      json['tag'].forEach((v) {
        tag!.add(new Tag.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_name'] = this.projectName;
    data['project_describe'] = this.projectDescribe;
    data['project_status_id'] = this.projectStatusId;
    data['manager_id'] = this.managerId;
    data['department_id'] = this.departmentId;
    data['prefix_code'] = this.prefixCode;
    data['permission'] = this.permission;
    data['date_start'] = this.dateStart;
    data['date_end'] = this.dateEnd;
    data['budget'] = this.budget;
    data['contract_code'] = this.contractCode;
    data['customer_type'] = this.customerType;
    data['customer_id'] = this.customerId;
    data['color_code'] = this.colorCode;
    data['is_important'] = this.isImportant;
    data['resource'] = this.resource;
    data['progress'] = this.progress;
    if (this.tag != null) {
      data['tag'] = this.tag!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Tag {
  int? tagId;

  Tag({this.tagId});

  Tag.fromJson(Map<int, dynamic> json) {
    tagId = json['tag_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['tag_id'] = this.tagId;
    return data;
  }
}