

import 'package:epoint_deal_plugin/model/page_info_model.dart';

class WorkListWorkResponseModel {
  PageInfoModel? pageInfo;
  List<WorkListWorkModel>? items;

  WorkListWorkResponseModel({this.pageInfo, this.items});

  WorkListWorkResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <WorkListWorkModel>[];
      json['Items'].forEach((v) {
        items!.add(new WorkListWorkModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WorkListWorkModel {
  int? manageWorkId;
  String? manageWorkTitle;

  WorkListWorkModel({this.manageWorkId, this.manageWorkTitle});

  WorkListWorkModel.fromJson(Map<String, dynamic> json) {
    manageWorkId = json['manage_work_id'];
    manageWorkTitle = json['manage_work_title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['manage_work_id'] = this.manageWorkId;
    data['manage_work_title'] = this.manageWorkTitle;
    return data;
  }
}