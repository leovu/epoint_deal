import 'package:epoint_deal_plugin/model/filter_model.dart';
import 'package:epoint_deal_plugin/presentation/interface/base_bloc.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class FilterOrderBloc extends BaseBloc {

  FilterOrderBloc(BuildContext context){
    setContext(context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _streamDate.close();

    _streamStatusModels.close();
    super.dispose();
  }

  final _streamDate = BehaviorSubject<DateTime?>();
  ValueStream<DateTime?> get outputDate => _streamDate.stream;
  setDate(DateTime? event) => set(_streamDate, event);

  final _streamStatusModels = BehaviorSubject<List<FilterModel>?>();
  ValueStream<List<FilterModel>?> get outputStatusModels => _streamStatusModels.stream;
  setStatusModels(List<FilterModel>? event) => set(_streamStatusModels, event);
}