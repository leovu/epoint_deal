

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

  FilterScreenModel({this.filterModel, this.fromDate_created_at, this.toDate_created_at, this.id_created_at, this.id_closing_date,this.toDate_closing_date,this.fromDate_closing_date, this.fromDate_closing_due_date,this.id_closing_due_date,this.toDate_closing_due_date});

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

        );
  }
}