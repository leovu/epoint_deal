
import 'package:epoint_deal_plugin/model/response/work_job_overview_response_model.dart';

class WorkMyResponseModel {
  List<WorkMyModel>? data;

  WorkMyResponseModel({this.data});

  WorkMyResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <WorkMyModel>[];
      json.forEach((v) {
        data!.add(new WorkMyModel.fromJson(v));
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

class WorkMyModel {
  String? textBlock;
  List<WorkJobModel>? list;
  bool? expanded;

  WorkMyModel({this.textBlock, this.list});

  WorkMyModel.fromJson(Map<String, dynamic> json) {
    textBlock = json['text_block'];
    if (json['list'] != null) {
      list = <WorkJobModel>[];
      json['list'].forEach((v) {
        list!.add(new WorkJobModel.fromJson(v));
      });
    }
    expanded = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text_block'] = this.textBlock;
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}