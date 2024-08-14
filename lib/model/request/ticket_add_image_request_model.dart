

import 'package:epoint_deal_plugin/model/response/ticket_upload_file_response_model.dart';

class TicketAddImageRequestModel {
  int? ticketId;
  List<TicketUploadFileResponseModel>? listImage;

  TicketAddImageRequestModel({this.ticketId, this.listImage});

  TicketAddImageRequestModel.fromJson(Map<String, dynamic> json) {
    ticketId = json['ticket_id'];
    if (json['list-image'] != null) {
      listImage = <TicketUploadFileResponseModel>[];
      json['list-image'].forEach((v) {
        listImage!.add(new TicketUploadFileResponseModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ticket_id'] = this.ticketId;
    if (this.listImage != null) {
      data['list-image'] = this.listImage!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}