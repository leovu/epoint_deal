import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';

class ApplicationFilterModel {
  List<int?>? types;
  WorkListStaffModel? staffModel;
  String? status;
  String? date;
  DateTime? fromDate;
  DateTime? toDate;

  ApplicationFilterModel({
    this.types,
    this.staffModel,
    this.status,
    this.date,
    this.fromDate,
    this.toDate
  });
}