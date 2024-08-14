import 'package:flutter/material.dart';

class ChatFunctionModel {
  String? name;
  Function? function;
  IconData? icon;
  String? key;

  ChatFunctionModel({this.name, this.function, this.icon, this.key});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['function'] = this.function;
    data['icon'] = this.icon;
    data['key'] = this.key;
    return data;
  }
}