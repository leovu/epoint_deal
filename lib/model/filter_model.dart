import 'package:flutter/material.dart';

class FilterModel{
  dynamic id;
  String? text;
  String? icon;
  DateTime? fromDate;
  DateTime? toDate;
  Color? color;
  bool selected;

  FilterModel({this.id, this.text, this.icon, this.color, this.selected = false});
}