import 'booking_list_response_model.dart';

class BookingStatusResponseModel {
  List<BookingStatusUpdateModel>? data;

  BookingStatusResponseModel({this.data});

  BookingStatusResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <BookingStatusUpdateModel>[];
      json.forEach((v) {
        data!.add(new BookingStatusUpdateModel.fromJson(v));
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