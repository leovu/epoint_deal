import 'package:flutter_test/flutter_test.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin_platform_interface.dart';
import 'package:epoint_deal_plugin/epoint_deal_plugin_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEpointDealPluginPlatform
    with MockPlatformInterfaceMixin
    implements EpointDealPluginPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final EpointDealPluginPlatform initialPlatform = EpointDealPluginPlatform.instance;

  test('$MethodChannelEpointDealPlugin is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEpointDealPlugin>());
  });

  test('getPlatformVersion', () async {
    EpointDealPlugin epointDealPlugin = EpointDealPlugin();
    MockEpointDealPluginPlatform fakePlatform = MockEpointDealPluginPlatform();
    EpointDealPluginPlatform.instance = fakePlatform;

    expect(await epointDealPlugin.getPlatformVersion(), '42');
  });
}
