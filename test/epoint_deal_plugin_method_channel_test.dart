import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin_method_channel.dart';

void main() {
  MethodChannelEpointDealPlugin platform = MethodChannelEpointDealPlugin();
  const MethodChannel channel = MethodChannel('epoint_deal_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
