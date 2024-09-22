import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:flutter/material.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await PatchAllLocales.patchNumberSeperators(
  //   patchForSamsungKeyboards: true,
  // );
  runApp(MaterialApp(
    locale: const Locale('vi', 'VN'),
    title: 'Navigation Basics',
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);
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
            child: Text("Open deal"),
            onTap: () async {
              var result = await EpointDealPlugin.open(
                  context,
                  const Locale(LangKey.langVi, 'vi'),
                  'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWZmLWFwaS1zdGFnLmVwb2ludHMudm4vdXNlci9yZWZyZXNoLXRva2VuIiwiaWF0IjoxNzI2OTM1MzgxLCJleHAiOjE3MjY5OTgzNDEsIm5iZiI6MTcyNjk3Njc0MSwianRpIjoid2VkVjN5QUlxelV6UUZ6MyIsInN1YiI6MSwicHJ2IjoiYTBmM2U3NGJlZGY1MTJjNDc3ODI5N2RlNWY5MjA4NmRhZDM5Y2E5ZiIsInNpZCI6ImFkbWluQHBpb2FwcHMudm4iLCJicmFuZF9jb2RlIjoicWMifQ.pEuJNvZsnSAo-5bTkccYYJM0Qgju7rI_1n-AMqUoNsI',
                  2,
                  {},
                  domain: 'https://staff-api.stag.epoints.vn',
                  brandCode: 'qc');

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
