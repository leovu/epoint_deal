import 'package:epoint_deal_plugin/model/response/booking_staff_response_model.dart';
import 'package:epoint_deal_plugin/model/response/branch_response_model.dart';

class BookingListFilterModel {
  String? viewMode;
  BranchModel? branchModel;
  int? staffId;
  String? staffType;
  List<BookingStaffModel>? staffModels;

  BookingListFilterModel({
    this.viewMode,
    this.branchModel,
    this.staffId,
    this.staffType,
    this.staffModels
  });
}