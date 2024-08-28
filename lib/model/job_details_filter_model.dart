

import 'package:epoint_deal_plugin/model/response/get_list_staff_responese_model.dart';
import 'package:epoint_deal_plugin/model/response/work_list_project_response_model.dart';
import 'package:epoint_deal_plugin/widget/widget.dart';

class JobDetailsFilterModel{
  String? name;
  String? overdue;
  List<WorkListStaffModel>? performers, assignors, supporters;
  CustomDropdownModel? status;
  DateTime? fromDate, toDate;
  WorkListProjectModel? project;
  CustomDropdownModel? typeModel, branchModel, departmentModel;
  String? tracker;

  JobDetailsFilterModel({
    this.name,
    this.overdue,
    this.performers,
    this.assignors,
    this.supporters,
    this.status,
    this.fromDate,
    this.toDate,
    this.project,
    this.typeModel,
    this.branchModel,
    this.departmentModel,
    this.tracker,
  });
}