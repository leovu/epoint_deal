class PrintDevicesResponseModel {
  List<PrintDevicesModel>? data;

  PrintDevicesResponseModel({this.data});

  PrintDevicesResponseModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      data = <PrintDevicesModel>[];
      json.forEach((v) {
        data!.add(new PrintDevicesModel.fromJson(v));
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

class PrintDevicesModel {
  int? printBillDeviceId;
  int? branchId;
  String? branchName;
  String? printerName;
  String? printerIp;
  int? printerPort;
  String? template;
  int? templateWidth;
  int? isDefault;

  PrintDevicesModel(
      {this.printBillDeviceId,
        this.branchId,
        this.branchName,
        this.printerName,
        this.printerIp,
        this.printerPort,
        this.template,
        this.templateWidth,
        this.isDefault});

  PrintDevicesModel.fromJson(Map<String, dynamic> json) {
    printBillDeviceId = json['print_bill_device_id'];
    branchId = json['branch_id'];
    branchName = json['branch_name'];
    printerName = json['printer_name'];
    printerIp = json['printer_ip'];
    printerPort = json['printer_port'];
    template = json['template'];
    templateWidth = json['template_width'];
    isDefault = json['is_default'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['print_bill_device_id'] = this.printBillDeviceId;
    data['branch_id'] = this.branchId;
    data['branch_name'] = this.branchName;
    data['printer_name'] = this.printerName;
    data['printer_ip'] = this.printerIp;
    data['printer_port'] = this.printerPort;
    data['template'] = this.template;
    data['template_width'] = this.templateWidth;
    data['is_default'] = this.isDefault;
    return data;
  }
}