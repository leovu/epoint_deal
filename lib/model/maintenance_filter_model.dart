import 'package:epoint_deal_plugin/model/response/maintenance_status_response_model.dart';
import 'package:epoint_deal_plugin/model/response/warranty_card_response_model.dart';
import 'package:epoint_deal_plugin/model/response/warranty_package_response_model.dart';

class MaintenanceFilterModel {
  MaintenanceStatusModel? statusModel;
  WarrantyPackageModel? packageModel;
  WarrantyCardModel? warrantyModel;
  String? date;
  DateTime? fromDate;
  DateTime? toDate;

  MaintenanceFilterModel({
    this.statusModel,
    this.packageModel,
    this.warrantyModel,
    this.date,
    this.fromDate,
    this.toDate
  });
}