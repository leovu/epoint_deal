
import 'package:epoint_deal_plugin/model/page_info_model.dart';

class CustomerDealResponseModel {
  PageInfoModel? pageInfo;
  List<CustomerDealModel>? items;
  List<CustomerDealStatusModel>? status;

  CustomerDealResponseModel({this.pageInfo, this.items, this.status});

  CustomerDealResponseModel.fromJson(Map<String, dynamic> json) {
    pageInfo = json['PageInfo'] != null
        ? new PageInfoModel.fromJson(json['PageInfo'])
        : null;
    if (json['Items'] != null) {
      items = <CustomerDealModel>[];
      json['Items'].forEach((v) {
        items!.add(new CustomerDealModel.fromJson(v));
      });
    }
    if (json['status'] != null) {
      status = <CustomerDealStatusModel>[];
      json['status'].forEach((v) {
        status!.add(new CustomerDealStatusModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.pageInfo != null) {
      data['PageInfo'] = this.pageInfo!.toJson();
    }
    if (this.items != null) {
      data['Items'] = this.items!.map((v) => v.toJson()).toList();
    }
    if (this.status != null) {
      data['status'] = this.status!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CustomerDealModel {
  String? dealCode;
  String? dealName;
  String? name;
  String? ownerName;
  String? saleName;
  String? journeyName;
  String? journeyCode;
  String? defaultSystem;
  String? defaultSystemName;
  String? phone;
  double? amount;
  String? dateAssign;
  String? closingDate;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  int? updatedBy;
  String? staffCreatedName;
  String? staffUpdatedName;
  String? pipelineJourneyDefaultName;
  int? distanceDays;
  String? statusColor;

  CustomerDealModel(
      {this.dealCode,
        this.dealName,
        this.name,
        this.ownerName,
        this.saleName,
        this.journeyName,
        this.journeyCode,
        this.defaultSystem,
        this.defaultSystemName,
        this.phone,
        this.amount,
        this.dateAssign,
        this.closingDate,
        this.createdAt,
        this.updatedAt,
        this.createdBy,
        this.updatedBy,
        this.staffCreatedName,
        this.staffUpdatedName,
        this.pipelineJourneyDefaultName,
        this.distanceDays,
        this.statusColor});

  CustomerDealModel.fromJson(Map<String, dynamic> json) {
    dealCode = json['deal_code'];
    dealName = json['deal_name'];
    name = json['name'];
    ownerName = json['owner_name'];
    saleName = json['sale_name'];
    journeyName = json['journey_name'];
    journeyCode = json['journey_code'];
    defaultSystem = json['default_system'];
    defaultSystemName = json['default_system_name'];
    phone = json['phone'];
    amount = double.tryParse((json['amount'] ?? 0.0).toString());
    dateAssign = json['date_assign'];
    closingDate = json['closing_date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    updatedBy = json['updated_by'];
    staffCreatedName = json['staff_created_name'];
    staffUpdatedName = json['staff_updated_name'];
    pipelineJourneyDefaultName = json['pipeline_journey_default_name'];
    distanceDays = json['distance_days'];
    statusColor = json['status_color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['deal_code'] = this.dealCode;
    data['deal_name'] = this.dealName;
    data['name'] = this.name;
    data['owner_name'] = this.ownerName;
    data['sale_name'] = this.saleName;
    data['journey_name'] = this.journeyName;
    data['journey_code'] = this.journeyCode;
    data['default_system'] = this.defaultSystem;
    data['default_system_name'] = this.defaultSystemName;
    data['phone'] = this.phone;
    data['amount'] = this.amount;
    data['date_assign'] = this.dateAssign;
    data['closing_date'] = this.closingDate;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_by'] = this.createdBy;
    data['updated_by'] = this.updatedBy;
    data['staff_created_name'] = this.staffCreatedName;
    data['staff_updated_name'] = this.staffUpdatedName;
    data['pipeline_journey_default_name'] = this.pipelineJourneyDefaultName;
    data['distance_days'] = this.distanceDays;
    data['status_color'] = this.statusColor;
    return data;
  }
}

class CustomerDealStatusModel {
  String? pipelineJourneyDefaultCode;
  String? pipelineJourneyDefaultName;

  CustomerDealStatusModel({this.pipelineJourneyDefaultCode, this.pipelineJourneyDefaultName});

  CustomerDealStatusModel.fromJson(Map<String, dynamic> json) {
    pipelineJourneyDefaultCode = json['pipeline_journey_default_code'];
    pipelineJourneyDefaultName = json['pipeline_journey_default_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pipeline_journey_default_code'] = this.pipelineJourneyDefaultCode;
    data['pipeline_journey_default_name'] = this.pipelineJourneyDefaultName;
    return data;
  }
}