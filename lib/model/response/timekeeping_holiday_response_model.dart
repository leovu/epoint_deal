class TimekeepingHolidayResponseModel {
  List<TimekeepingHolidayModel>? data;

  TimekeepingHolidayResponseModel({this.data});

  TimekeepingHolidayResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <TimekeepingHolidayModel>[];
      json.forEach((v) {
        data!.add(new TimekeepingHolidayModel.fromJson(v));
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

class TimekeepingHolidayModel {
  String? holidayDate;
  String? holidayName;

  TimekeepingHolidayModel({this.holidayDate, this.holidayName});

  TimekeepingHolidayModel.fromJson(Map<String, dynamic> json) {
    holidayDate = json['holiday_date'];
    holidayName = json['holiday_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['holiday_date'] = this.holidayDate;
    data['holiday_name'] = this.holidayName;
    return data;
  }
}
