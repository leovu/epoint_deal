import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'epoint_deal_plugin_platform_interface.dart';

/// An implementation of [EpointDealPluginPlatform] that uses method channels.
class MethodChannelEpointDealPlugin extends EpointDealPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('epoint_deal_plugin');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
