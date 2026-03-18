

import 'package:epoint_deal_plugin/model/response/work_job_overview_response_model.dart';

class WorkListChildResponseModel {
  List<WorkJobModel>? data;

  WorkListChildResponseModel({this.data});

  WorkListChildResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkJobModel>[];
      json.forEach((v) {
        data!.add(new WorkJobModel.fromJson(v));
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