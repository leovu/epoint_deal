

import 'package:epoint_deal_plugin/model/response/ticket_upload_file_response_model.dart';

class TicketImageResponseModel {
  List<TicketUploadFileResponseModel>? data;

  TicketImageResponseModel({this.data});

  TicketImageResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TicketUploadFileResponseModel>[];
      json.forEach((v) {
        data!.add(new TicketUploadFileResponseModel.fromJson(v));
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