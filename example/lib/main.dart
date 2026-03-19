import 'package:epoint_deal_plugin/common/lang_key.dart';
import 'package:flutter/material.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
                  const Locale(LangKey.langEn, 'en'),
                  'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczovL3N0YWZmLWFwaS5kZXYubWF0dGhld3NsaXF1b3IuY29tLmF1L3VzZXIvbG9naW4iLCJpYXQiOjE3NzM4MTYxNjEsImV4cCI6MTc3MzgzNzc2MSwibmJmIjoxNzczODE2MTYxLCJqdGkiOiJpcndGVjJiaml3dHJBVVJGIiwic3ViIjoyOTQsInBydiI6ImEwZjNlNzRiZWRmNTEyYzQ3NzgyOTdkZTVmOTIwODZkYWQzOWNhOWYiLCJzaWQiOiJ0cmluZCIsInBob25lIjoidHJpbmQiLCJicmFuZF9jb2RlIjoibWF0dGhld3NsaXF1b3IiLCJpbWVpIjoicG9ydGFsMTIzIn0.9nVsRWVHyP8FqsY_hl6SbgxWARys_v7lzSZwyNzwL4k',
                  2,
                  {},
                  domain: 'https://staff-api.dev.matthewsliquor.com.au',
                  brandCode: 'matthewsliquor');
            },
          ),
        ),
      ),
    );
  }
}
