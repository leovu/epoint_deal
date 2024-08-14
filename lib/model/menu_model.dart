import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class MenuGroupModel{
  final String? title;
  final List<MenuModel>? menus;

  MenuGroupModel({this.title, this.menus});
}

class MenuModel{
  final String? icon;
  final String? text;
  final GestureTapCallback? onTap;
  final Color? color;
  final bool enable;
  final ValueStream<int?>? stream;

  MenuModel({this.icon, this.text, this.onTap, this.color, this.stream, this.enable = true});
}