import 'package:epoint_deal_plugin/model/page_info_model.dart';
import 'package:epoint_deal_plugin/model/response/booking_list_response_model.dart';

class BookingCustomerResponseModel {
  PageInfoModel? pageInfo;
  List<BookingListModel>? items;

  BookingCustomerResponseModel({this.pageInfo, this.items});

  BookingCustomerResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <BookingListModel>[];
      json['Items'].forEach((v) {
        items!.add(new BookingListModel.fromJson(v));
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