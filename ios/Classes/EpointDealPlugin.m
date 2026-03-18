#import "EpointDealPlugin.h"
#if __has_include(<epoint_deal_plugin/epoint_deal_plugin-Swift.h>)
#import <epoint_deal_plugin/epoint_deal_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "epoint_deal_plugin-Swift.h"
#endif

@implementation EpointDealPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftEpointDealPlugin registerWithRegistrar:registrar];
}
@end
