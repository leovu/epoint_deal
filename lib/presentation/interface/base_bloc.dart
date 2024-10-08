import 'package:epoint_deal_plugin/resource/repository.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

abstract class BaseBloc{

   Repository get repository => _repository;
  Repository _repository = Repository();

  BuildContext? _context;

  setContext(BuildContext context) => _context = context;
  BuildContext? get context => _context;

  set(BehaviorSubject<dynamic> stream, dynamic event){
    if(!stream.isClosed) stream.sink.add(event);
  }

  setError(BehaviorSubject<dynamic> stream, dynamic event){
    if(!stream.isClosed) stream.sink.addError(event);
  }

  @protected
  @mustCallSuper
  void dispose(){

  }
}