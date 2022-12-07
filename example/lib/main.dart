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
           var result = await EpointDealPlugin.open(context,const Locale(LangKey.langVi, 'VN')  , 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOi8vc3RhZmYtYXBpLnN0YWcuZXBvaW50cy52bi91c2VyL2xvZ2luIiwiaWF0IjoxNjcwNDE5MzMxLCJleHAiOjE2NzA0NDA5MzEsIm5iZiI6MTY3MDQxOTMzMSwianRpIjoiNzRRSGIxRlZMOHZqQjlpSCIsInN1YiI6MSwicHJ2IjoiYTBmM2U3NGJlZGY1MTJjNDc3ODI5N2RlNWY5MjA4NmRhZDM5Y2E5ZiIsInNpZCI6ImFkbWluQHBpb2FwcHMudm4iLCJicmFuZF9jb2RlIjoicWMifQ.9BXNNLRJgJ5RTqty3kEn7I6wtecdPmuAWxWq83cbsSM',
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
