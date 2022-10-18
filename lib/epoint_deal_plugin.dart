
import 'epoint_deal_plugin_platform_interface.dart';

class EpointDealPlugin {
  Future<String?> getPlatformVersion() {
    return EpointDealPluginPlatform.instance.getPlatformVersion();
  }
}
