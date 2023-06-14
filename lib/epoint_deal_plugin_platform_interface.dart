import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'epoint_deal_plugin_method_channel.dart';

abstract class EpointDealPluginPlatform extends PlatformInterface {
  /// Constructs a EpointDealPluginPlatform.
  EpointDealPluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static EpointDealPluginPlatform _instance = MethodChannelEpointDealPlugin();

  /// The default instance of [EpointDealPluginPlatform] to use.
  ///
  /// Defaults to [MethodChannelEpointDealPlugin].
  static EpointDealPluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EpointDealPluginPlatform] when
  /// they register themselves.
  static set instance(EpointDealPluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
