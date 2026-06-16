import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:flutter/material.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin.dart';
import 'dart:io';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HttpOverrides.global = MyHttpOverrides();

  // await PatchAllLocales.patchNumberSeperators(
  //   patchForSamsungKeyboards: true,
  // );
  runApp(const MaterialApp(
    locale: Locale('vi', 'VN'),
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
// final Locale locale;
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
            child: const Text("Open deal"),
            onTap: () {
              EpointDealPlugin.open(
                  context,
                  const Locale(LangKey.langVi, 'vi'),
                  'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3dvcmtzcGFjZS5lcG9pbnRzLnZuL3VzZXIvbG9naW4iLCJpYXQiOjE3ODE1ODMwOTQsImV4cCI6MTc4MTYwNDY5NCwibmJmIjoxNzgxNTgzMDk0LCJqdGkiOiJUZ2lEVGZzNjhxQ0hoNTF3Iiwic3ViIjoxLCJwcnYiOiJhMGYzZTc0YmVkZjUxMmM0Nzc4Mjk3ZGU1ZjkyMDg2ZGFkMzljYTlmIiwic2lkIjoiYWRtaW5AcGlvYXBwcy52biIsImJyYW5kX2NvZGUiOiJzYWxlIn0.Fu9Np4QIvhmw6BBWoEqmE4rJULvMYJgqFLZRFGyub6g',
                  2,
                  {},
                  domain: 'https://staff-api.stag.epoints.vn',
                  brandCode: 'qc');
            },
          ),
        ),
      ),
    );
  }
}
