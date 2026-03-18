import 'package:epoint_deal_plugin/model/page_info_model.dart';

class ListNoteResponseModel {
  int? errorCode;
  String? errorDescription;
  List<NoteData>? data;
  PageInfoModel? pageInfo;

  ListNoteResponseModel({this.errorCode, this.errorDescription, this.data});

  ListNoteResponseModel.fromJson(Map<String, dynamic> json) {
    errorCode = json['ErrorCode'];
    errorDescription = json['ErrorDescription'];
    if (json['Data'] != null) {
      data = <NoteData>[];
      json['Data'].forEach((v) {
        data!.add(new NoteData.fromJson(v));
      });
    }
  }

  ListNoteResponseModel.fromList(List<dynamic>? json) {
    if (json != null) {
      data = <NoteData>[];
      json.forEach((v) {
        data!.add(new NoteData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ErrorCode'] = this.errorCode;
    data['ErrorDescription'] = this.errorDescription;
    if (this.data != null) {
      data['Data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class NoteData {
  int? customerDealNoteId;
  String? content;
  int? createdBy;
  String? createdByName;
  String? createdAt;

  NoteData(
      {this.customerDealNoteId,
      this.content,
      this.createdBy,
      this.createdByName,
      this.createdAt});

  NoteData.fromJson(Map<String, dynamic> json) {
    customerDealNoteId = json['customer_deal_note_id'];
    content = json['content'];
    createdBy = json['created_by'];
    createdByName = json['created_by_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['customer_deal_note_id'] = this.customerDealNoteId;
    data['content'] = this.content;
    data['created_by'] = this.createdBy;
    data['created_by_name'] = this.createdByName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
