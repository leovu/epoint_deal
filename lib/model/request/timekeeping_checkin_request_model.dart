class TimekeepingCheckInRequestModel {
  int? timeWorkingStaffId;
  String? deviceId;
  String? accessPointIp;
  String? checkSum;
  String? wifiName;
  String? latitude;
  String? longitude;
  String? imei;
  String? deviceName;
  String? platform;

  TimekeepingCheckInRequestModel(
      {this.timeWorkingStaffId,
        this.deviceId,
        this.accessPointIp,
        this.checkSum,
        this.wifiName,
        this.latitude,
        this.longitude,
        this.imei,
        this.deviceName,
        this.platform});

  TimekeepingCheckInRequestModel.fromJson(Map<String, dynamic> json) {
    timeWorkingStaffId = json['time_working_staff_id'];
    deviceId = json['device_id'];
    accessPointIp = json['access_point_ip'];
    checkSum = json['check_sum'];
    wifiName = json['wifi_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    imei = json['imei'];
    deviceName = json['device_name'];
    platform = json['platform'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time_working_staff_id'] = this.timeWorkingStaffId;
    data['device_id'] = this.deviceId;
    data['access_point_ip'] = this.accessPointIp;
    data['check_sum'] = this.checkSum;
    data['wifi_name'] = this.wifiName;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['imei'] = this.imei;
    data['device_name'] = this.deviceName;
    data['platform'] = this.platform;
    return data;
  }
}