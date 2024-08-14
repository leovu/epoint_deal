import 'booking_list_response_model.dart';

class CustomerAppointmentListResponseModel {
  List<BookingListModel>? data;

  CustomerAppointmentListResponseModel({this.data});

  CustomerAppointmentListResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <BookingListModel>[];
      json.forEach((v) {
        data!.add(new BookingListModel.fromJson(v));
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