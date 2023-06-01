

import 'package:epoint_deal_plugin/model/request/list_deal_model_request.dart';

class FilterScreenModel {
  ListDealModelRequest filterModel;

  DateTime fromDate_created_at;
  DateTime toDate_created_at;
  String id_created_at;

  DateTime fromDate_closing_date;
  DateTime toDate_closing_date;
  String id_closing_date;

  DateTime fromDate_closing_due_date;
  DateTime toDate_closing_due_date;
  String id_closing_due_date;

   DateTime fromDate_history_care_date;
  DateTime toDate_history_care_date;
  String id_history_care_date;

  DateTime fromDate_work_schedule_date;
  DateTime toDate_work_schedule_date;
  String id_work_schedule_date;

  FilterScreenModel({
  this.filterModel, 
  this.fromDate_created_at,
  this.toDate_created_at, 
  this.id_created_at, 
  this.id_closing_date,
  this.toDate_closing_date,
  this.fromDate_closing_date, 
  this.fromDate_closing_due_date,
  this.id_closing_due_date,
  this.toDate_closing_due_date,
  this.fromDate_history_care_date,
  this.toDate_history_care_date,
  this.id_history_care_date,
  this.fromDate_work_schedule_date,
  this.toDate_work_schedule_date,
  this.id_work_schedule_date});

  factory FilterScreenModel.fromJson(Map<String, dynamic> parsedJson) {
    return FilterScreenModel(
        filterModel: parsedJson['filterModel'],
        fromDate_created_at: parsedJson['fromDate_created_at'],
        toDate_created_at: parsedJson['toDate_created_at'],
        id_created_at: parsedJson['id_created_at'],
        fromDate_closing_date: parsedJson['fromDate_closing_date'],
        toDate_closing_date: parsedJson['toDate_closing_date'],
        id_closing_date: parsedJson['id_closing_date'],

        fromDate_closing_due_date: parsedJson['fromDate_closing_due_date'],
        toDate_closing_due_date: parsedJson['toDate_closing_due_date'],
        id_closing_due_date: parsedJson['id_closing_due_date'],

        fromDate_history_care_date: parsedJson['fromDate_history_care_date'],
        toDate_history_care_date: parsedJson['toDate_history_care_date'],
        id_history_care_date: parsedJson['id_history_care_date'],

        fromDate_work_schedule_date: parsedJson['fromDate_work_schedule_date'],
        toDate_work_schedule_date: parsedJson['toDate_work_schedule_date'],
        id_work_schedule_date: parsedJson['id_work_schedule_date'],

        );
  }

     Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filterModel'] = filterModel.toJson();
    data['fromDate_created_at'] = fromDate_created_at;
    data['toDate_created_at'] = toDate_created_at;
    data['id_created_at'] = id_created_at ?? "";

    data['fromDate_closing_date'] = fromDate_closing_date;
    data['toDate_closing_date'] = toDate_closing_date;
    data['id_closing_date'] = id_closing_date ?? "";

    data['fromDate_closing_due_date'] = fromDate_closing_due_date;
    data['toDate_closing_due_date'] = toDate_closing_due_date;
    data['id_closing_due_date'] = id_closing_due_date ?? "";


    data['fromDate_history_care_date'] = fromDate_history_care_date;
    data['toDate_history_care_date'] = toDate_history_care_date;
    data['id_history_care_date'] = id_history_care_date ?? "";

    data['fromDate_work_schedule_date'] = fromDate_work_schedule_date;
    data['toDate_work_schedule_date'] = toDate_work_schedule_date;
    data['id_work_schedule_date'] = id_work_schedule_date ?? "";

    return data;
  }



}