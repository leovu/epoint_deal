import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class DiscountBloc extends BaseBloc {

  DiscountBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamIsMoney.close();
    super.dispose();
  }

  final _streamIsMoney = BehaviorSubject<bool>();
  ValueStream<bool> get outputIsMoney => _streamIsMoney.stream;
  setIsMoney(bool event) => set(_streamIsMoney, event);
}