class PermissionResponseModel {
  List<PermissionModel>? permission;

  PermissionResponseModel({this.permission});

  PermissionResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['permission'] != null) {
      permission = <PermissionModel>[];
      json['permission'].forEach((v) {
        permission!.add(new PermissionModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.permission != null) {
      data['permission'] = this.permission!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class PermissionModel {
  String? widgetId;
  String? widgetName;
  int? isHotFunction;

  PermissionModel({this.widgetId, this.widgetName, this.isHotFunction});

  PermissionModel.fromJson(Map<String, dynamic> json) {
    widgetId = json['widget_id'];
    widgetName = json['widget_name'];
    isHotFunction = json['is_hot_function'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['widget_id'] = this.widgetId;
    data['widget_name'] = this.widgetName;
    data['is_hot_function'] = this.isHotFunction;
    return data;
  }
}
