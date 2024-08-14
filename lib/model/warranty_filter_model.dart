

import 'package:epoint_deal_plugin/model/response/warranty_package_response_model.dart';
import 'package:epoint_deal_plugin/model/response/warranty_status_response_model.dart';

class WarrantyFilterModel {
  WarrantyStatusModel? statusModel;
  WarrantyPackageModel? packageModel;
  String? date;
  DateTime? fromDate;
  DateTime? toDate;

  WarrantyFilterModel({
    this.statusModel,
    this.packageModel,
    this.date,
    this.fromDate,
    this.toDate
  });
}