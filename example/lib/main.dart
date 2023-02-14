import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:flutter/material.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin.dart';

void main() {
  runApp(MaterialApp(
    locale: const Locale('vi','VN'),
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home:  MyApp(),
  ));
}


class MyApp extends StatefulWidget {
  MyApp({Key key, this.locale}) : super(key: key);
final Locale locale;
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { 
  @override
  void initState() {
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
      child: InkWell(
        child: Text("Open deal"),
        onTap: () async {
           var result = await EpointDealPlugin.open(context,const Locale(LangKey.langVi, 'VN')  , 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWZmLWFwaS5zdGFnLmVwb2ludHMudm4vdXNlci9sb2dpbiIsImlhdCI6MTY3NjM0MDIyNCwiZXhwIjoxNjc2MzYxODI0LCJuYmYiOjE2NzYzNDAyMjQsImp0aSI6Imk3VFlxUnp0RWhBNWNhZ0kiLCJzdWIiOjEsInBydiI6ImEwZjNlNzRiZWRmNTEyYzQ3NzgyOTdkZTVmOTIwODZkYWQzOWNhOWYiLCJzaWQiOiJhZG1pbkBwaW9hcHBzLnZuIiwiYnJhbmRfY29kZSI6InFjIn0.2BWriT5OGIrY40egVqR0idDCzXGzX8q0fKs34Ql6-g4',
     2,domain: 'https://staff-api.stag.epoints.vn', brandCode: 'qc');

     if (result != null) {

       print(result);
     }
        },
      ),
    ),
      ),
    );
  }
}
