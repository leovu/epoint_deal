
import 'package:epoint_deal_plugin/model/page_info_model.dart';

import 'work_job_overview_response_model.dart';

class WorkMySearchResponseModel {
  PageInfoModel? pageInfo;
  List<WorkJobModel>? items;

  WorkMySearchResponseModel({this.pageInfo, this.items});

  WorkMySearchResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <WorkJobModel>[];
      json['Items'].forEach((v) {
        items!.add(new WorkJobModel.fromJson(v));
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